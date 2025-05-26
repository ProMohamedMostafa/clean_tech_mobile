import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/cache_helper/cache_helper.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/auth/login/data/model/log_in_model.dart';
import 'package:smart_cleaning_application/features/screens/auth/login/logic/login_cubit_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LogInModel? logInModel;
  userLogin(BuildContext context) {
    emit(LoginLoadingState());
    DioHelper.postData(url: ApiConstants.loginUrl, data: {
      'emailOrUserName': emailController.text,
      'password': passwordController.text
    }).then((value) async {
      logInModel = LogInModel.fromJson(value!.data);
      await saveUserToken(logInModel!.data!.token!);
      await saveUserId(logInModel!.data!.id!);
      await saveRole(logInModel!.data!.role!);
      await saveOnBoarding('isOnBoarding');
      await sendTokenToServer();
      emit(LoginSuccessState(logInModel!));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  Future<void> saveUserToken(String token) async {
    await CacheHelper.setSecuredString(SharedPrefKeys.userToken, token);
    DioHelper.setTokenIntoHeaderAfterLogin(token);
  }

  Future<void> saveUserId(int id) async {
    await CacheHelper.setData(key: SharedPrefKeys.userId, value: id);
    uId = await CacheHelper.getInt(SharedPrefKeys.userId);
  }

  Future<void> saveRole(String rolee) async {
    await CacheHelper.setData(key: SharedPrefKeys.userRole, value: rolee);
    role = await CacheHelper.getString(SharedPrefKeys.userRole);
  }

  Future<void> saveOnBoarding(String onBoarding) async {
    await CacheHelper.setData(
        key: SharedPrefKeys.isOnBoarding, value: onBoarding);
    isBoarding = await CacheHelper.getString(SharedPrefKeys.isOnBoarding);
  }

  Future<void> sendTokenToServer() async {
    emit(NotificationLoadingState());
    try {
      await DioHelper.postData(
          url: 'device/token', data: {'token': deviceToken});
      emit(NotificationSuccessState());
    } catch (error) {
      emit(NotificationErrorState(error.toString()));
    }
  }

  IconData suffixIcon = Icons.visibility_outlined;
  bool ispassword = true;
  changeSuffixIconVisiability() {
    ispassword = !ispassword;
    suffixIcon =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeSuffixIconVisiabiltyState());
  }
}
