import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/features/screens/login/logic/login_cubit_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  // SignInModel? signInModel;

  // userLogin({
  //   required String email,
  //   required String password,
  // }) {
  //   emit(LoginLoadingState());
  //   DioHelper.postData(
  //       url: 'auth/$type/login',
  //       data: {'email': email, 'password': password}).then((value) {
  //     signInModel = SignInModel.fromJson(value.data);
  //     emit(LoginSuccessState());
  //   }).catchError((error) {
  //     emit(LoginErrorState(error.toString()));
  //   });
  // }
  IconData suffixIcon = Icons.visibility_outlined;
  bool ispassword = true;
  changeSuffixIconVisiability() {
    ispassword = !ispassword;
    suffixIcon =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeSuffixIconVisiabiltyState());
  }
}
