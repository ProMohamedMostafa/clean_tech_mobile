abstract class TaskManagementState {}

class TaskManagementInitialState extends TaskManagementState {}

class TaskManagementLoadingState extends TaskManagementState {}

class TaskManagementSuccessState extends TaskManagementState {}

class TaskManagementErrorState extends TaskManagementState {
  final String error;
  TaskManagementErrorState(this.error);
}
