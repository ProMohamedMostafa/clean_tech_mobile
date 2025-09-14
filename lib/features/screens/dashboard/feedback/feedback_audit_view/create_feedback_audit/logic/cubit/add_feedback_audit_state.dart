part of 'add_feedback_audit_cubit.dart';

abstract class AddFeedbackAuditState {}

final class AddFeedbackAuditInitial extends AddFeedbackAuditState {}

final class AddFeedbackAuditLoadingState extends AddFeedbackAuditState {}

final class AddFeedbackAuditSuccessState extends AddFeedbackAuditState {
  final String message;
  AddFeedbackAuditSuccessState(this.message);
}

final class AddFeedbackAuditErrorState extends AddFeedbackAuditState {
  final String error;
  AddFeedbackAuditErrorState(this.error);
}

//**************************************** */
class GetOrganizationLoadingState extends AddFeedbackAuditState {}

class GetOrganizationSuccessState extends AddFeedbackAuditState {
  final OrganizationBasicModel organizationBasicModel;

  GetOrganizationSuccessState(this.organizationBasicModel);
}

class GetOrganizationErrorState extends AddFeedbackAuditState {
  final String error;
  GetOrganizationErrorState(this.error);
}

//**************************** */

class GetBuildingLoadingState extends AddFeedbackAuditState {}

class GetBuildingSuccessState extends AddFeedbackAuditState {
  final BuildingListModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends AddFeedbackAuditState {
  final String error;
  GetBuildingErrorState(this.error);
}
//**************************** */

class GetFloorLoadingState extends AddFeedbackAuditState {}

class GetFloorSuccessState extends AddFeedbackAuditState {
  final FloorListModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends AddFeedbackAuditState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetSectionLoadingState extends AddFeedbackAuditState {}

class GetSectionSuccessState extends AddFeedbackAuditState {
  final SectionListModel sectionModel;

  GetSectionSuccessState(this.sectionModel);
}

class GetSectionErrorState extends AddFeedbackAuditState {
  final String error;
  GetSectionErrorState(this.error);
}
//**************************** */

class GetDeviceLoadingState extends AddFeedbackAuditState {}

class GetDeviceSuccessState extends AddFeedbackAuditState {
  final DevicesModel deviceModel;

  GetDeviceSuccessState(this.deviceModel);
}

class GetDeviceErrorState extends AddFeedbackAuditState {
  final String error;
  GetDeviceErrorState(this.error);
}
