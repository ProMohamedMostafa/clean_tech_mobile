abstract class VerifyAccountState {}

class VerifyAccountInitialState extends VerifyAccountState {}

class VerifyAccountLoadingState extends VerifyAccountState {}

class VerifyAccountSuccessState extends VerifyAccountState {
  final String message;

  VerifyAccountSuccessState(this.message);
}

class VerifyAccountErrorState extends VerifyAccountState {
  final String error;
  VerifyAccountErrorState(this.error);
}
