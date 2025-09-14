import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/add_task/data/models/create_task_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/point_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/section_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/add_task/data/models/users_shift_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/edit_task/data/models/organization_basic_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/edit_task/data/models/tasks_basic_model.dart';

abstract class AddTaskState {}

class AddTaskInitialState extends AddTaskState {}

class AddTaskLoadingState extends AddTaskState {}

class AddTaskSuccessState extends AddTaskState {
  final CreateTaskModel createTaskModel;

  AddTaskSuccessState(this.createTaskModel);
}

class AddTaskErrorState extends AddTaskState {
  final String message;
  AddTaskErrorState(this.message);
}


//**************************** */

class AllUsersLoadingState extends AddTaskState {}

class AllUsersSuccessState extends AddTaskState {
  final UsersShiftModel usersShiftModel;

  AllUsersSuccessState(this.usersShiftModel);
}

class AllUsersErrorState extends AddTaskState {
  final String error;
  AllUsersErrorState(this.error);
}
//***************************** */

class GetAllTasksLoadingState extends AddTaskState {}

class GetAllTasksSuccessState extends AddTaskState {
  final TasksBasicModel tasksBasicModel;

  GetAllTasksSuccessState(this.tasksBasicModel);
}

class GetAllTasksErrorState extends AddTaskState {
  final String error;
  GetAllTasksErrorState(this.error);
}

//**************************************** */
class GetOrganizationLoadingState extends AddTaskState {}

class GetOrganizationSuccessState extends AddTaskState {
  final OrganizationBasicModel organizationBasicModel;

  GetOrganizationSuccessState(this.organizationBasicModel);
}

class GetOrganizationErrorState extends AddTaskState {
  final String error;
  GetOrganizationErrorState(this.error);
}


//**************************** */

class GetBuildingLoadingState extends AddTaskState {}

class GetBuildingSuccessState extends AddTaskState {
  final BuildingListModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends AddTaskState {
  final String error;
  GetBuildingErrorState(this.error);
}
//**************************** */

class GetFloorLoadingState extends AddTaskState {}

class GetFloorSuccessState extends AddTaskState {
  final FloorListModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends AddTaskState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetSectionLoadingState extends AddTaskState {}

class GetSectionSuccessState extends AddTaskState {
  final SectionListModel sectionModel;

  GetSectionSuccessState(this.sectionModel);
}

class GetSectionErrorState extends AddTaskState {
  final String error;
  GetSectionErrorState(this.error);
}
//**************************** */

class GetPointLoadingState extends AddTaskState {}

class GetPointSuccessState extends AddTaskState {
  final PointListModel pointsModel;

  GetPointSuccessState(this.pointsModel);
}

class GetPointErrorState extends AddTaskState {
  final String error;
  GetPointErrorState(this.error);
}

//*************************** */
class ShiftLoadingState extends AddTaskState {}

class ShiftSuccessState extends AddTaskState {
  final ShiftModel allShiftsModel;
  ShiftSuccessState(this.allShiftsModel);
}

class ShiftErrorState extends AddTaskState {
  final String error;
  ShiftErrorState(this.error);
}
//***************************** */

class CameraSelectedState extends AddTaskState {
  final XFile image;
  CameraSelectedState(this.image);
}

class FilesSelectedState extends AddTaskState {
  final List<PlatformFile> files;
  FilesSelectedState(this.files);
}

class RemoveSelectedFileState extends AddTaskState {}
