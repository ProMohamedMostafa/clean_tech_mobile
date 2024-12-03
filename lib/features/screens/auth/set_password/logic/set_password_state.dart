abstract class SetPasswordStates {}

class SetPasswordInitialState extends SetPasswordStates {}

class SetPasswordLoadingState extends SetPasswordStates {}

class SetPasswordSuccessState extends SetPasswordStates {
  // final SignInModel signinmodel;

  // SetPasswordStateSuccessState(this.signinmodel);
}

class SetPasswordErrorState extends SetPasswordStates {
  final String error;
  SetPasswordErrorState(this.error);
}

//************ */
class ChangeSuffixIconVisiabiltyState extends SetPasswordStates {}
