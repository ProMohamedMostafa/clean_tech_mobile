import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/setting/change_password/data/model/change_password_model.dart';
import 'package:smart_cleaning_application/features/screens/setting/change_password/logic/change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordStates> {
  ChangePasswordCubit() : super(ChangePasswordInitialState());

  static ChangePasswordCubit get(context) => BlocProvider.of(context);
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  ChangePasswordModel? changePasswordModel;
  changePassword() {
    emit(ChangePasswordLoadingState());
    DioHelper.putData(url: ApiConstants.changePasswordUrl, data: {
      "id": uId,
      "currentPassword": oldPasswordController.text,
      "newPassword": passwordController.text,
      "newPasswordConfirmation": repeatPasswordController.text,
    }).then((value) {
      changePasswordModel = ChangePasswordModel.fromJson(value!.data);
      emit(ChangePasswordSuccessState(changePasswordModel!));
    }).catchError((error) {
      emit(ChangePasswordErrorState(error.toString()));
    });
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
