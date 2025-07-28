import 'package:smart_cleaning_application/features/screens/setting/change_password/data/model/change_password_model.dart';

abstract class ChangePasswordStates {}

class ChangePasswordInitialState extends ChangePasswordStates {}

class ChangePasswordLoadingState extends ChangePasswordStates {}

class ChangePasswordSuccessState extends ChangePasswordStates {
  final ChangePasswordModel changePasswordModel;
  ChangePasswordSuccessState(this.changePasswordModel);
}

class ChangePasswordErrorState extends ChangePasswordStates {
  final String error;
  ChangePasswordErrorState(this.error);
}

//************ */
class ChangeSuffixIconVisiabiltyState extends ChangePasswordStates {}
