import 'package:smart_cleaning_application/features/screens/dashboard/feedback/devices/devices_management/data/model/devices_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/edit_feedback_audit/data/model/feedback_audit_details.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/section_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/edit_task/data/models/organization_basic_model.dart';

abstract class EditFeedbackAuditState {}

final class EditFeedbackAuditInitial extends EditFeedbackAuditState {}

final class EditFeedbackAuditLoadingState extends EditFeedbackAuditState {}

final class EditFeedbackAuditSuccessState extends EditFeedbackAuditState {
  final String message;
  EditFeedbackAuditSuccessState(this.message);
}

final class EditFeedbackAuditErrorState extends EditFeedbackAuditState {
  final String error;
  EditFeedbackAuditErrorState(this.error);
}

//**************************************** */
class GetOrganizationLoadingState extends EditFeedbackAuditState {}

class GetOrganizationSuccessState extends EditFeedbackAuditState {
  final OrganizationBasicModel organizationBasicModel;

  GetOrganizationSuccessState(this.organizationBasicModel);
}

class GetOrganizationErrorState extends EditFeedbackAuditState {
  final String error;
  GetOrganizationErrorState(this.error);
}

//**************************** */

class GetBuildingLoadingState extends EditFeedbackAuditState {}

class GetBuildingSuccessState extends EditFeedbackAuditState {
  final BuildingListModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends EditFeedbackAuditState {
  final String error;
  GetBuildingErrorState(this.error);
}
//**************************** */

class GetFloorLoadingState extends EditFeedbackAuditState {}

class GetFloorSuccessState extends EditFeedbackAuditState {
  final FloorListModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends EditFeedbackAuditState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetSectionLoadingState extends EditFeedbackAuditState {}

class GetSectionSuccessState extends EditFeedbackAuditState {
  final SectionListModel sectionModel;

  GetSectionSuccessState(this.sectionModel);
}

class GetSectionErrorState extends EditFeedbackAuditState {
  final String error;
  GetSectionErrorState(this.error);
}

//************************ */
final class FeedbackAuditDetailsLoadingState extends EditFeedbackAuditState {}

final class FeedbackAuditDetailsSuccessState extends EditFeedbackAuditState {
  final FeedbackAuditDetailsModel feedbackAuditDetailsModel;
  FeedbackAuditDetailsSuccessState(this.feedbackAuditDetailsModel);
}

final class FeedbackAuditDetailsErrorState extends EditFeedbackAuditState {
  final String error;
  FeedbackAuditDetailsErrorState(this.error);
}
//**************************** */

class GetDeviceLoadingState extends EditFeedbackAuditState {}

class GetDeviceSuccessState extends EditFeedbackAuditState {
  final DevicesModel deviceModel;

  GetDeviceSuccessState(this.deviceModel);
}

class GetDeviceErrorState extends EditFeedbackAuditState {
  final String error;
  GetDeviceErrorState(this.error);
}
