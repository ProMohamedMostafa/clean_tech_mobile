import 'package:smart_cleaning_application/features/screens/edit_user/data/model/edit_model.dart';
import 'package:smart_cleaning_application/features/screens/user_details/data/model/user_model.dart';

abstract class EditUserState {}

class EditUserInitialState extends EditUserState {}

class EditUserLoadingState extends EditUserState {}

class EditUserSuccessState extends EditUserState {
  final EditModel editModel;
  EditUserSuccessState(this.editModel);
}

class EditUserErrorState extends EditUserState {
  final String error;
  EditUserErrorState(this.error);
}

//************************* */

class UserInitialState extends EditUserState {}

class UserLoadingState extends EditUserState {}

class UserSuccessState extends EditUserState {
  final UserModel userModel;

  UserSuccessState(this.userModel);
}

class UserErrorState extends EditUserState {
  final String error;
  UserErrorState(this.error);
}
