abstract class ForgotPasswordStates {}

class ForgotPasswordInitialState extends ForgotPasswordStates {}

class ForgotPasswordLoadingState extends ForgotPasswordStates {}

class ForgotPasswordSuccessState extends ForgotPasswordStates {
  final String message;

  ForgotPasswordSuccessState(this.message);
}

class ForgotPasswordErrorState extends ForgotPasswordStates {
  final String error;
  ForgotPasswordErrorState(this.error);
}
