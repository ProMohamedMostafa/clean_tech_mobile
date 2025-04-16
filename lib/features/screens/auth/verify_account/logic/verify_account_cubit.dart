import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/auth/verify_account/logic/verify_account_state.dart';

class VerifyAccountCubit extends Cubit<VerifyAccountState> {
  VerifyAccountCubit() : super(VerifyAccountInitialState());
  static VerifyAccountCubit get(context) => BlocProvider.of(context);

  TextEditingController pinCodeController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  checkOtp(String? email ) {
    emit(VerifyAccountLoadingState());
    DioHelper.postData(url: 'auth/check/otp', data: {
      'email': email,
      'code': pinCodeController.text,
    }).then((value) {
      final message = value?.data['message'] ?? "reset code sent to your email";
      emit(VerifyAccountSuccessState(message));
    }).catchError((error) {
      emit(VerifyAccountErrorState(error.toString()));
    });
  }
}
