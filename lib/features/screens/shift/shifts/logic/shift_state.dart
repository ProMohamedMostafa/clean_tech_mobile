import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/all_shifts_deleted_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/all_shifts_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/shift_buildings_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/shift_details_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/shift_floors_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/shift_organizations_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/shift_points_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/shift_users_details.dart';

abstract class ShiftState {}

class ShiftInitialState extends ShiftState {}

class ShiftLoadingState extends ShiftState {}

class ShiftSuccessState extends ShiftState {
  final AllShiftsModel allShiftsModel;
  ShiftSuccessState(this.allShiftsModel);
}

class ShiftErrorState extends ShiftState {
  final String error;
  ShiftErrorState(this.error);
}

//******************** */
class ShiftDetailsLoadingState extends ShiftState {}

class ShiftDetailsSuccessState extends ShiftState {
  final ShiftDetailsModel shiftDetailsModel;
  ShiftDetailsSuccessState(this.shiftDetailsModel);
}

class ShiftDetailsErrorState extends ShiftState {
  final String error;
  ShiftDetailsErrorState(this.error);
}

//******************** */
class ShiftOrganizationsLoadingState extends ShiftState {}

class ShiftOrganizationsSuccessState extends ShiftState {
  final ShiftOrganizationsModel shiftOrganizationsModel;
  ShiftOrganizationsSuccessState(this.shiftOrganizationsModel);
}

class ShiftOrganizationsErrorState extends ShiftState {
  final String error;
  ShiftOrganizationsErrorState(this.error);
}

//******************** */
class ShiftBuildingsLoadingState extends ShiftState {}

class ShiftBuildingsSuccessState extends ShiftState {
  final ShiftBuildingsModel shiftBuildingsModel;
  ShiftBuildingsSuccessState(this.shiftBuildingsModel);
}

class ShiftBuildingsErrorState extends ShiftState {
  final String error;
  ShiftBuildingsErrorState(this.error);
}

//******************** */
class ShiftFloorsLoadingState extends ShiftState {}

class ShiftFloorsSuccessState extends ShiftState {
  final ShiftFloorsModel shiftFloorsModel;
  ShiftFloorsSuccessState(this.shiftFloorsModel);
}

class ShiftFloorsErrorState extends ShiftState {
  final String error;
  ShiftFloorsErrorState(this.error);
}

//******************** */
class ShiftPointsLoadingState extends ShiftState {}

class ShiftPointsSuccessState extends ShiftState {
  final ShiftPointsModel shiftPointsModel;
  ShiftPointsSuccessState(this.shiftPointsModel);
}

class ShiftPointsErrorState extends ShiftState {
  final String error;
  ShiftPointsErrorState(this.error);
}

//******************** */
class ShiftUsersDetailsLoadingState extends ShiftState {}

class ShiftUsersDetailsSuccessState extends ShiftState {
  final ShiftUsersModel shiftUsersModel;
  ShiftUsersDetailsSuccessState(this.shiftUsersModel);
}

class ShiftUsersDetailsErrorState extends ShiftState {
  final String error;
  ShiftUsersDetailsErrorState(this.error);
}

//******************** */
class ShiftDeleteLoadingState extends ShiftState {}

class ShiftDeleteSuccessState extends ShiftState {
  final String message;
  ShiftDeleteSuccessState(this.message);
}

class ShiftDeleteErrorState extends ShiftState {
  final String error;
  ShiftDeleteErrorState(this.error);
}

//******************** */
class AllShiftDeleteLoadingState extends ShiftState {}

class AllShiftDeleteSuccessState extends ShiftState {
  final AllShiftsDeletedModel allShiftsDeletedModel;
  AllShiftDeleteSuccessState(this.allShiftsDeletedModel);
}

class AllShiftDeleteErrorState extends ShiftState {
  final String error;
  AllShiftDeleteErrorState(this.error);
}

//******************** */
class RestoreShiftLoadingState extends ShiftState {}

class RestoreShiftSuccessState extends ShiftState {
  final String message;
  RestoreShiftSuccessState(this.message);
}

class RestoreShiftErrorState extends ShiftState {
  final String error;
  RestoreShiftErrorState(this.error);
}

//******************** */
class ForceDeleteShiftLoadingState extends ShiftState {}

class ForceDeleteShiftSuccessState extends ShiftState {
  final String message;
  ForceDeleteShiftSuccessState(this.message);
}

class ForceDeleteShiftErrorState extends ShiftState {
  final String error;
  ForceDeleteShiftErrorState(this.error);
}
