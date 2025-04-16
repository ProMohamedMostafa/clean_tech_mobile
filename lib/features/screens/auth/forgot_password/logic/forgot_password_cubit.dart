import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/auth/forgot_password/logic/forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordStates> {
  ForgotPasswordCubit() : super(ForgotPasswordInitialState());
  static ForgotPasswordCubit get(context) => BlocProvider.of(context);
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  forgotPassWord() {
    emit(ForgotPasswordLoadingState());
    DioHelper.postData(
        url: 'auth/password-forgot/otp',
        data: {'email': emailController.text}).then((value) {
      final message = value?.data['message'] ?? "reset code sent to your email";
      emit(ForgotPasswordSuccessState(message));
    }).catchError((error) {
      emit(ForgotPasswordErrorState(error.toString()));
    });
  }
}
