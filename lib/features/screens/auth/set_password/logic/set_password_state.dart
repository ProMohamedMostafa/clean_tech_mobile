abstract class SetPasswordStates {}

class SetPasswordInitialState extends SetPasswordStates {}

class SetPasswordLoadingState extends SetPasswordStates {}

class SetPasswordSuccessState extends SetPasswordStates {
  final String message;

  SetPasswordSuccessState(this.message);
}

class SetPasswordErrorState extends SetPasswordStates {
  final String error;
  SetPasswordErrorState(this.error);
}

//************ */
class ChangeSuffixIconVisiabiltyState extends SetPasswordStates {}
