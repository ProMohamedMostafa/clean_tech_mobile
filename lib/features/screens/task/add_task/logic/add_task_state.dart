import 'package:image_picker/image_picker.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/points_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/data/models/cleaner_model.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/data/models/create_task_model.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/data/models/supervisor_model.dart';

abstract class AddTaskState {}

class AddTaskInitialState extends AddTaskState {}

class AddTaskLoadingState extends AddTaskState {}

class AddTaskSuccessState extends AddTaskState {
  final CreateTaskModel createTaskModel;

  AddTaskSuccessState(this.createTaskModel);
}

class AddTaskErrorState extends AddTaskState {
  final CreateTaskModel createTaskModel;
  AddTaskErrorState(this.createTaskModel);
}

//**************************** */

class GetOrganizationLoadingState extends AddTaskState {}

class GetOrganizationSuccessState extends AddTaskState {
  final OrganizationModel organizationModel;

  GetOrganizationSuccessState(this.organizationModel);
}

class GetOrganizationErrorState extends AddTaskState {
  final String error;
  GetOrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends AddTaskState {}

class GetBuildingSuccessState extends AddTaskState {
  final BuildingModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends AddTaskState {
  final String error;
  GetBuildingErrorState(this.error);
}
//**************************** */

class GetFloorLoadingState extends AddTaskState {}

class GetFloorSuccessState extends AddTaskState {
  final FloorModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends AddTaskState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetPointsLoadingState extends AddTaskState {}

class GetPointsSuccessState extends AddTaskState {
  final PointsModel pointsModel;

  GetPointsSuccessState(this.pointsModel);
}

class GetPointsErrorState extends AddTaskState {
  final String error;
  GetPointsErrorState(this.error);
}

//**************************** */

class GetCleanerLoadingState extends AddTaskState {}

class GetCleanerSuccessState extends AddTaskState {
  final CleanerModel cleanerModel;

  GetCleanerSuccessState(this.cleanerModel);
}

class GetCleanerErrorState extends AddTaskState {
  final String error;
  GetCleanerErrorState(this.error);
}

//**************************** */

class GetSupervisorLoadingState extends AddTaskState {}

class GetSupervisorSuccessState extends AddTaskState {
  final SupervisorModel supervisorModel;

  GetSupervisorSuccessState(this.supervisorModel);
}

class GetSupervisorErrorState extends AddTaskState {
  final String error;
  GetSupervisorErrorState(this.error);
}
//***************************** */

class ImageSelectedState extends AddTaskState {
  final XFile image;
  ImageSelectedState(this.image);
}

class CameraSelectedState extends AddTaskState {
  final XFile image;
  CameraSelectedState(this.image);
}
