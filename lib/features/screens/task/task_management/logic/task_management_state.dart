import 'package:image_picker/image_picker.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/all_area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/data/models/all_tasks_model.dart';
import 'package:smart_cleaning_application/features/screens/task/edit_task/data/models/delete_task_list_model.dart';
import 'package:smart_cleaning_application/features/screens/task/edit_task/data/models/delete_task_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/change_task_status.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/completed_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/in_progress_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/not_approvable_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/not_resolved_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/overdue_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/pending_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/rejected_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/task_details.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/providers_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/point_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/section_model.dart';

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

class GetPendingTasksLoadingState extends TaskManagementState {}

class GetPendingTasksSuccessState extends TaskManagementState {
  final PendingModel pendingModel;

  GetPendingTasksSuccessState(this.pendingModel);
}

class GetPendingTasksErrorState extends TaskManagementState {
  final String error;
  GetPendingTasksErrorState(this.error);
}
//**************************************** */

class GetInProgressTasksLoadingState extends TaskManagementState {}

class GetInProgressTasksSuccessState extends TaskManagementState {
  final InProgressModel inProgressModel;

  GetInProgressTasksSuccessState(this.inProgressModel);
}

class GetInProgressTasksErrorState extends TaskManagementState {
  final String error;
  GetInProgressTasksErrorState(this.error);
}
//**************************************** */

class GetNotApprovableTasksLoadingState extends TaskManagementState {}

class GetNotApprovableTasksSuccessState extends TaskManagementState {
  final NotApprovableModel notApprovableModel;

  GetNotApprovableTasksSuccessState(this.notApprovableModel);
}

class GetNotApprovableTasksErrorState extends TaskManagementState {
  final String error;
  GetNotApprovableTasksErrorState(this.error);
}
//**************************************** */

class GetCompletedTasksLoadingState extends TaskManagementState {}

class GetCompletedTasksSuccessState extends TaskManagementState {
  final CompletedModel completedModel;

  GetCompletedTasksSuccessState(this.completedModel);
}

class GetCompletedTasksErrorState extends TaskManagementState {
  final String error;
  GetCompletedTasksErrorState(this.error);
}

//**************************************** */

class GetRejectedTasksLoadingState extends TaskManagementState {}

class GetRejectedTasksSuccessState extends TaskManagementState {
  final RejectedModel rejectedModel;

  GetRejectedTasksSuccessState(this.rejectedModel);
}

class GetRejectedTasksErrorState extends TaskManagementState {
  final String error;
  GetRejectedTasksErrorState(this.error);
}
//**************************************** */

class GetNotResolvedTasksLoadingState extends TaskManagementState {}

class GetNotResolvedTasksSuccessState extends TaskManagementState {
  final NotResolvedModel notResolvedModel;

  GetNotResolvedTasksSuccessState(this.notResolvedModel);
}

class GetNotResolvedTasksErrorState extends TaskManagementState {
  final String error;
  GetNotResolvedTasksErrorState(this.error);
}
//**************************************** */

class GetOverdueTasksLoadingState extends TaskManagementState {}

class GetOverdueTasksSuccessState extends TaskManagementState {
  final OverdueModel overdueModel;

  GetOverdueTasksSuccessState(this.overdueModel);
}

class GetOverdueTasksErrorState extends TaskManagementState {
  final String error;
  GetOverdueTasksErrorState(this.error);
}

//**************************************** */

class GetTaskDetailsLoadingState extends TaskManagementState {}

class GetTaskDetailsSuccessState extends TaskManagementState {
  final TaskDetailsModel taskDetailsModel;

  GetTaskDetailsSuccessState(this.taskDetailsModel);
}

class GetTaskDetailsErrorState extends TaskManagementState {
  final String error;
  GetTaskDetailsErrorState(this.error);
}

//**************************************** */

class GetChangeTaskStatusLoadingState extends TaskManagementState {}

class GetChangeTaskStatusSuccessState extends TaskManagementState {
  final ChangeTaskStatusModel changeTaskStatusModel;

  GetChangeTaskStatusSuccessState(this.changeTaskStatusModel);
}

class GetChangeTaskStatusErrorState extends TaskManagementState {
  final String error;
  GetChangeTaskStatusErrorState(this.error);
}
//**************************************** */

class AddCommentsLoadingState extends TaskManagementState {}

class AddCommentsSuccessState extends TaskManagementState {
  final String message;

  AddCommentsSuccessState(this.message);
}

class AddCommentsErrorState extends TaskManagementState {
  final String error;
  AddCommentsErrorState(this.error);
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

//***************************** */

class ImageSelectedState extends TaskManagementState {
  final XFile image;
  ImageSelectedState(this.image);
}

class CameraSelectedState extends TaskManagementState {
  final XFile image;
  CameraSelectedState(this.image);
}
//**************************** */

class GetAreaLoadingState extends TaskManagementState {}

class GetAreaSuccessState extends TaskManagementState {
  final AllAreaModel allAreaModel;

  GetAreaSuccessState(this.allAreaModel);
}

class GetAreaErrorState extends TaskManagementState {
  final String error;
  GetAreaErrorState(this.error);
}
//**************************** */

class GetCityLoadingState extends TaskManagementState {}

class GetCitySuccessState extends TaskManagementState {
  final CityListModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends TaskManagementState {
  final String error;
  GetCityErrorState(this.error);
}
//**************************** */

class GetOrganizationLoadingState extends TaskManagementState {}

class GetOrganizationSuccessState extends TaskManagementState {
  final OrganizationListModel organizationModel;

  GetOrganizationSuccessState(this.organizationModel);
}

class GetOrganizationErrorState extends TaskManagementState {
  final String error;
  GetOrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends TaskManagementState {}

class GetBuildingSuccessState extends TaskManagementState {
  final BuildingListModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends TaskManagementState {
  final String error;
  GetBuildingErrorState(this.error);
}
//**************************** */

class GetFloorLoadingState extends TaskManagementState {}

class GetFloorSuccessState extends TaskManagementState {
  final FloorListModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends TaskManagementState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetSectionLoadingState extends TaskManagementState {}

class GetSectionSuccessState extends TaskManagementState {
  final SectionListModel sectionModel;

  GetSectionSuccessState(this.sectionModel);
}

class GetSectionErrorState extends TaskManagementState {
  final String error;
  GetSectionErrorState(this.error);
}
//**************************** */

class GetPointLoadingState extends TaskManagementState {}

class GetPointSuccessState extends TaskManagementState {
  final PointListModel pointsModel;

  GetPointSuccessState(this.pointsModel);
}

class GetPointErrorState extends TaskManagementState {
  final String error;
  GetPointErrorState(this.error);
}

//***************** */

class AllUsersLoadingState extends TaskManagementState {}

class AllUsersSuccessState extends TaskManagementState {
  final UsersModel usersModel;

  AllUsersSuccessState(this.usersModel);
}

class AllUsersErrorState extends TaskManagementState {
  final String error;
  AllUsersErrorState(this.error);
}

//*************************************** */

class AllProvidersLoadingState extends TaskManagementState {}

class AllProvidersSuccessState extends TaskManagementState {
  final ProvidersModel providersModel;

  AllProvidersSuccessState(this.providersModel);
}

class AllProvidersErrorState extends TaskManagementState {
  final String error;
  AllProvidersErrorState(this.error);
}
