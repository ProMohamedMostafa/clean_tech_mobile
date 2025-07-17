part of 'task_details_cubit.dart';

abstract class TaskDetailsState {}

final class TaskDetailsInitialState extends TaskDetailsState {}

class TaskDetailsLoadingState extends TaskDetailsState {}

class TaskDetailsSuccessState extends TaskDetailsState {
  final TaskDetailsModel taskDetailsModel;

  TaskDetailsSuccessState(this.taskDetailsModel);
}

class TaskDetailsErrorState extends TaskDetailsState {
  final String error;
  TaskDetailsErrorState(this.error);
}

//*********************************** */
class AllUsersLoadingState extends TaskDetailsState {}

class AllUsersSuccessState extends TaskDetailsState {
  final UsersModel usersModel;

  AllUsersSuccessState(this.usersModel);
}

class AllUsersErrorState extends TaskDetailsState {
  final String error;
  AllUsersErrorState(this.error);
}
//**************************************** */

class TaskDeleteLoadingState extends TaskDetailsState {}

class TaskDeleteSuccessState extends TaskDetailsState {
  final DeleteTaskModel deleteTaskModel;

  TaskDeleteSuccessState(this.deleteTaskModel);
}

class TaskDeleteErrorState extends TaskDetailsState {
  final String error;
  TaskDeleteErrorState(this.error);
}
//**************************************** */

class GetChangeTaskStatusLoadingState extends TaskDetailsState {}

class GetChangeTaskStatusSuccessState extends TaskDetailsState {
  final ChangeTaskStatusModel changeTaskStatusModel;

  GetChangeTaskStatusSuccessState(this.changeTaskStatusModel);
}

class GetChangeTaskStatusErrorState extends TaskDetailsState {
  final String error;
  GetChangeTaskStatusErrorState(this.error);
}
//**************************************** */

class AddCommentsLoadingState extends TaskDetailsState {}

class AddCommentsSuccessState extends TaskDetailsState {
  final String message;

  AddCommentsSuccessState(this.message);
}

class AddCommentsErrorState extends TaskDetailsState {
  final String error;
  AddCommentsErrorState(this.error);
}
//***************************** */

class ImageSelectedState extends TaskDetailsState {
  final XFile image;
  ImageSelectedState(this.image);
}

class CameraSelectedState extends TaskDetailsState {
  final XFile image;
  CameraSelectedState(this.image);
}
class RemoveSelectedFileState extends TaskDetailsState {}
