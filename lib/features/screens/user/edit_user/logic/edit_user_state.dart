import 'package:smart_cleaning_application/features/screens/user/edit_user/data/model/edit_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_details_model.dart';

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

class UserLoadingState extends EditUserState {}

class UserSuccessState extends EditUserState {
  final UserDetailsModel userDetailsModelModel;

  UserSuccessState(this.userDetailsModelModel);
}

class UserErrorState extends EditUserState {
  final String error;
  UserErrorState(this.error);
}
