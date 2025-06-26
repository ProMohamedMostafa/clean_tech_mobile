part of 'leaves_details_cubit.dart';

abstract class LeavesDetailsState {}

final class LeavesDetailsInitial extends LeavesDetailsState {}

class LeavesDetailsLoadingState extends LeavesDetailsState {}

class LeavesDetailsSuccessState extends LeavesDetailsState {
  final LeavesDetailsModel leavesDetailsModel;

  LeavesDetailsSuccessState(this.leavesDetailsModel);
}

class LeavesDetailsErrorState extends LeavesDetailsState {
  final String error;
  LeavesDetailsErrorState(this.error);
}

//***************** */

class LeavesDeleteLoadingState extends LeavesDetailsState {}

class LeavesDeleteSuccessState extends LeavesDetailsState {
  final String message;

  LeavesDeleteSuccessState(this.message);
}

class LeavesDeleteErrorState extends LeavesDetailsState {
  final String error;
  LeavesDeleteErrorState(this.error);
}

//***************** */

class LeavesApproveLoadingState extends LeavesDetailsState {}

class LeavesApproveSuccessState extends LeavesDetailsState {
  final String message;

  LeavesApproveSuccessState(this.message);
}

class LeavesApproveErrorState extends LeavesDetailsState {
  final String error;
  LeavesApproveErrorState(this.error);
}
//********************** */

class DescToggleState extends LeavesDetailsState {}
