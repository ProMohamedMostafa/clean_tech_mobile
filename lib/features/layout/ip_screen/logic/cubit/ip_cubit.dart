import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/helpers/cache_helper/cache_helper.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
part 'ip_state.dart';

class IpCubit extends Cubit<IpState> {
  IpCubit() : super(IpInitial());

  TextEditingController ipController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void checkIp() async {
    emit(IpLoadingState());

    final ip = ipController.text.trim();
    final bool isValid = _validateIp(ip);

    if (!isValid) {
      emit(IpErrorState("Invalid IP format"));
      return;
    }

    try {
      ApiConstants.apiBaseUrl = "http://$ip:8080/api/v1/";
      DioHelper.dio = null;
      await DioHelper.initDio();

      // This will throw if status code is not 2xx
      await DioHelper.dio!.post("auth/login");
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        // ✅ Means the server responded → the IP is correct
        await CacheHelper.setData(key: SharedPrefKeys.ip, value: ip);
        emit(IpSuccessState("IP is valid and reachable"));
      } else {
        emit(
            IpErrorState("Failed to connect. Please check your IP or server."));
      }
    } catch (e) {
      emit(IpErrorState("Unexpected error occurred."));
    }
  }

  bool _validateIp(String ip) {
    final regex = RegExp(r"^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$");
    return regex.hasMatch(ip);
  }
}
