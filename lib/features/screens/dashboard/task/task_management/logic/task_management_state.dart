import 'package:smart_cleaning_application/features/screens/dashboard/task/task_management/data/models/all_tasks_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/task_management/data/models/delete_task_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/task_management/data/models/delete_task_model.dart';


abstract class TaskManagementState {}

class TaskManagementInitialState extends TaskManagementState {}

class TaskManagementLoadingState extends TaskManagementState {}

class TaskManagementSuccessState extends TaskManagementState {}

class TaskManagementErrorState extends TaskManagementState {
  final String error;
  TaskManagementErrorState(this.error);
}
//**************************************** */

class GetAllTasksLoadingState extends TaskManagementState {}

class GetAllTasksSuccessState extends TaskManagementState {
  final AllTasksModel allTasksModel;

  GetAllTasksSuccessState(this.allTasksModel);
}

class GetAllTasksErrorState extends TaskManagementState {
  final String error;
  GetAllTasksErrorState(this.error);
}


//**************************************** */

class TaskDeleteLoadingState extends TaskManagementState {}

class TaskDeleteSuccessState extends TaskManagementState {
  final DeleteTaskModel deleteTaskModel;

  TaskDeleteSuccessState(this.deleteTaskModel);
}

class TaskDeleteErrorState extends TaskManagementState {
  final String error;
  TaskDeleteErrorState(this.error);
}

//***************** */

class RestoreTaskLoadingState extends TaskManagementState {}

class RestoreTaskSuccessState extends TaskManagementState {
  final String message;

  RestoreTaskSuccessState(this.message);
}

class RestoreTaskErrorState extends TaskManagementState {
  final String error;
  RestoreTaskErrorState(this.error);
}
//***************** */

class ForceDeleteTaskLoadingState extends TaskManagementState {}

class ForceDeleteTaskSuccessState extends TaskManagementState {
  final String message;

  ForceDeleteTaskSuccessState(this.message);
}

class ForceDeleteTaskErrorState extends TaskManagementState {
  final String error;
  ForceDeleteTaskErrorState(this.error);
}
//**************************************** */

class TaskDeleteListLoadingState extends TaskManagementState {}

class TaskDeleteListSuccessState extends TaskManagementState {
  final DeleteTaskListModel deleteTaskListModel;

  TaskDeleteListSuccessState(this.deleteTaskListModel);
}

class TaskDeleteListErrorState extends TaskManagementState {
  final String error;
  TaskDeleteListErrorState(this.error);
}

