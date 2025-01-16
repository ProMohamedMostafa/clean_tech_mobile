import 'package:image_picker/image_picker.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/data/models/all_tasks_model.dart';
import 'package:smart_cleaning_application/features/screens/task/edit_task/data/models/edit_task_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/task_details.dart';

import '../../../integrations/data/models/building_model.dart';
import '../../../integrations/data/models/floor_model.dart';
import '../../../integrations/data/models/organization_model.dart';
import '../../../integrations/data/models/points_model.dart';
import '../../add_task/data/models/supervisor_model.dart';

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
  final AllTasksModel allTasksModel;

  GetAllTasksSuccessState(this.allTasksModel);
}

class GetAllTasksErrorState extends EditTaskState {
  final String error;
  GetAllTasksErrorState(this.error);
}
//**************************************** */
class GetOrganizationLoadingState extends EditTaskState {}

class GetOrganizationSuccessState extends EditTaskState {
  final OrganizationModel organizationModel;

  GetOrganizationSuccessState(this.organizationModel);
}

class GetOrganizationErrorState extends EditTaskState {
  final String error;
  GetOrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends EditTaskState {}

class GetBuildingSuccessState extends EditTaskState {
  final BuildingModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends EditTaskState {
  final String error;
  GetBuildingErrorState(this.error);
}
//**************************** */

class GetFloorLoadingState extends EditTaskState {}

class GetFloorSuccessState extends EditTaskState {
  final FloorModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends EditTaskState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetPointsLoadingState extends EditTaskState {}

class GetPointsSuccessState extends EditTaskState {
  final PointsModel pointsModel;

  GetPointsSuccessState(this.pointsModel);
}

class GetPointsErrorState extends EditTaskState {
  final String error;
  GetPointsErrorState(this.error);
}


//**************************** */

class GetSupervisorLoadingState extends EditTaskState {}

class GetSupervisorSuccessState extends EditTaskState {
  final SupervisorModel supervisorModel;

  GetSupervisorSuccessState(this.supervisorModel);
}

class GetSupervisorErrorState extends EditTaskState {
  final String error;
  GetSupervisorErrorState(this.error);
}
class ImageSelectedState extends EditTaskState {
  final XFile image;
  ImageSelectedState(this.image);
}

class CameraSelectedState extends EditTaskState {
  final XFile image;
  CameraSelectedState(this.image);
}
