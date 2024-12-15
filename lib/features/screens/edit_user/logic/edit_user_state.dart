abstract class EditUserState {}

class EditUserInitialState extends EditUserState {}

class EditUserLoadingState extends EditUserState {}

class EditUserSuccessState extends EditUserState {}

class EditUserErrorState extends EditUserState {
  final String error;
  EditUserErrorState(this.error);
}
