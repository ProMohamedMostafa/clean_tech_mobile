abstract class VerifyAccountState {}

class VerifyAccountInitialState extends VerifyAccountState {}

class VerifyAccountLoadingState extends VerifyAccountState {}

class VerifyAccountSuccessState extends VerifyAccountState {
  // final SignInModel signinmodel;

  // VerifyAccountStateSuccessState(this.signinmodel);
}

class VerifyAccountErrorState extends VerifyAccountState {
  final String error;
  VerifyAccountErrorState(this.error);
}
