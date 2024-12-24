import 'package:smart_cleaning_application/features/screens/user_details/data/model/user_model.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserSuccessState extends UserState {
  final UserModel userModel;

  UserSuccessState(this.userModel);
}

class UserErrorState extends UserState {
  final String error;
  UserErrorState(this.error);
}
