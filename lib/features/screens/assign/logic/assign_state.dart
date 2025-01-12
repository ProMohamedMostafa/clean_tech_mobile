
abstract class AssignStates {}

class AssignInitialState extends AssignStates {}

class AssignLoadingState extends AssignStates {}

class AssignSuccessState extends AssignStates {
  // final AssignModel assignModel;
  // AssignSuccessState(this.assignModel);
}

class AssignErrorState extends AssignStates {
  final String error;
  AssignErrorState(this.error);
}

