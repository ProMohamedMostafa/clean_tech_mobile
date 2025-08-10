import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/edit_task/data/models/edit_task_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/edit_task/data/models/organization_basic_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/edit_task/data/models/tasks_basic_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/edit_task/data/models/users_basic_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/view_task/data/model/task_details.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/point_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/section_list_model.dart';

abstract class EditTaskState {}

class EditTaskInitialState extends EditTaskState {}

class EditTaskLoadingState extends EditTaskState {}

class EditTaskSuccessState extends EditTaskState {
  final EditTaskModel editTaskModel;

  EditTaskSuccessState(this.editTaskModel);
}

class EditTaskErrorState extends EditTaskState {
  final String message;
  EditTaskErrorState(this.message);
}
//**************************************** */

class GetTaskDetailsLoadingState extends EditTaskState {}

class GetTaskDetailsSuccessState extends EditTaskState {
  final TaskDetailsModel taskDetailsModel;

  GetTaskDetailsSuccessState(this.taskDetailsModel);
}

class GetTaskDetailsErrorState extends EditTaskState {
  final String error;
  GetTaskDetailsErrorState(this.error);
}

//***************************** */

class GetAllTasksLoadingState extends EditTaskState {}

class GetAllTasksSuccessState extends EditTaskState {
  final TasksBasicModel tasksBasicModel;

  GetAllTasksSuccessState(this.tasksBasicModel);
}

class GetAllTasksErrorState extends EditTaskState {
  final String error;
  GetAllTasksErrorState(this.error);
}

//**************************************** */
class GetOrganizationLoadingState extends EditTaskState {}

class GetOrganizationSuccessState extends EditTaskState {
  final OrganizationBasicModel organizationBasicModel;

  GetOrganizationSuccessState(this.organizationBasicModel);
}

class GetOrganizationErrorState extends EditTaskState {
  final String error;
  GetOrganizationErrorState(this.error);
}

//**************************** */

class GetBuildingLoadingState extends EditTaskState {}

class GetBuildingSuccessState extends EditTaskState {
  final BuildingListModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends EditTaskState {
  final String error;
  GetBuildingErrorState(this.error);
}
//**************************** */

class GetFloorLoadingState extends EditTaskState {}

class GetFloorSuccessState extends EditTaskState {
  final FloorListModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends EditTaskState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetSectionLoadingState extends EditTaskState {}

class GetSectionSuccessState extends EditTaskState {
  final SectionListModel sectionModel;

  GetSectionSuccessState(this.sectionModel);
}

class GetSectionErrorState extends EditTaskState {
  final String error;
  GetSectionErrorState(this.error);
}
//**************************** */

class GetPointLoadingState extends EditTaskState {}

class GetPointSuccessState extends EditTaskState {
  final PointListModel pointsModel;

  GetPointSuccessState(this.pointsModel);
}

class GetPointErrorState extends EditTaskState {
  final String error;
  GetPointErrorState(this.error);
}

//**************************** */

class AllUsersLoadingState extends EditTaskState {}

class AllUsersSuccessState extends EditTaskState {
  final UsersBasicModel usersBasicModel;

  AllUsersSuccessState(this.usersBasicModel);
}

class AllUsersErrorState extends EditTaskState {
  final String error;
  AllUsersErrorState(this.error);
}

//***************************** */

class CameraSelectedState extends EditTaskState {
  final XFile image;
  CameraSelectedState(this.image);
}

class FilesSelectedState extends EditTaskState {
  final List<PlatformFile> files;
  FilesSelectedState(this.files);
}

class RemoveSelectedFileState extends EditTaskState {}

class RemoveExistingFileState extends EditTaskState {}

class FilesInitializedState extends EditTaskState {}
