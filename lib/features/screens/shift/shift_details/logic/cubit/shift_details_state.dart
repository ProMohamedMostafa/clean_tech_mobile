part of 'shift_details_cubit.dart';

abstract class ShiftDetailsState {}

final class ShiftDetailsInitial extends ShiftDetailsState {}

//******************** */
class ShiftOrganizationDetailsLoadingState extends ShiftDetailsState {}

class ShiftOrganizationDetailsSuccessState extends ShiftDetailsState {
  final ShiftOrganizationDetailsModel shiftOrganizationDetailsModel;
  ShiftOrganizationDetailsSuccessState(this.shiftOrganizationDetailsModel);
}

class ShiftOrganizationDetailsErrorState extends ShiftDetailsState {
  final String error;
  ShiftOrganizationDetailsErrorState(this.error);
} //******************** */

class ShiftBuildingDetailsLoadingState extends ShiftDetailsState {}

class ShiftBuildingDetailsSuccessState extends ShiftDetailsState {
  final ShiftBuildingsDetailsModel shiftBuildingsDetailsModel;
  ShiftBuildingDetailsSuccessState(this.shiftBuildingsDetailsModel);
}

class ShiftBuildingDetailsErrorState extends ShiftDetailsState {
  final String error;
  ShiftBuildingDetailsErrorState(this.error);
} //******************** */

class ShiftFloorDetailsLoadingState extends ShiftDetailsState {}

class ShiftFloorDetailsSuccessState extends ShiftDetailsState {
  final ShiftFloorDetailsModel shiftFloorDetailsModel;
  ShiftFloorDetailsSuccessState(this.shiftFloorDetailsModel);
}

class ShiftFloorDetailsErrorState extends ShiftDetailsState {
  final String error;
  ShiftFloorDetailsErrorState(this.error);
} //******************** */

class ShiftSectionDetailsLoadingState extends ShiftDetailsState {}

class ShiftSectionDetailsSuccessState extends ShiftDetailsState {
  final ShiftSectionDetailsModel shiftSectionDetailsModel;
  ShiftSectionDetailsSuccessState(this.shiftSectionDetailsModel);
}

class ShiftSectionDetailsErrorState extends ShiftDetailsState {
  final String error;
  ShiftSectionDetailsErrorState(this.error);
}

//******************** */
class ShiftDetailsLoadingState extends ShiftDetailsState {}

class ShiftDetailsSuccessState extends ShiftDetailsState {
  final ShiftDetailsModel shiftDetailsModel;
  ShiftDetailsSuccessState(this.shiftDetailsModel);
}

class ShiftDetailsErrorState extends ShiftDetailsState {
  final String error;
  ShiftDetailsErrorState(this.error);
}
//******************** */
class ShiftDeleteLoadingState extends ShiftDetailsState {}

class ShiftDeleteSuccessState extends ShiftDetailsState {
  final DeleteShiftModel deleteShiftModel;
  ShiftDeleteSuccessState(this.deleteShiftModel);
}

class ShiftDeleteErrorState extends ShiftDetailsState {
  final String error;
  ShiftDeleteErrorState(this.error);
}
