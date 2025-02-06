import 'package:image_picker/image_picker.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_edit/data/models/leaves_details_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_edit/data/models/leaves_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';

abstract class LeavesEditState {}

class LeavesEditInitialState extends LeavesEditState {}

class LeavesEditLoadingState extends LeavesEditState {}

class LeavesEditSuccessState extends LeavesEditState {
  final AttendanceLeavesEditModel attendanceLeavesEditModel;

  LeavesEditSuccessState(this.attendanceLeavesEditModel);
}

class LeavesEditErrorState extends LeavesEditState {
  final String error;
  LeavesEditErrorState(this.error);
}
//***************** */

class AllUsersLoadingState extends LeavesEditState {}

class AllUsersSuccessState extends LeavesEditState {
  final UsersModel usersModel;

  AllUsersSuccessState(this.usersModel);
}

class AllUsersErrorState extends LeavesEditState {
  final String error;
  AllUsersErrorState(this.error);
}

//***************** */

class LeavesDetailsLoadingState extends LeavesEditState {}

class LeavesDetailsSuccessState extends LeavesEditState {
  final LeavesDetailsModel leavesDetailsModel;

  LeavesDetailsSuccessState(this.leavesDetailsModel);
}

class LeavesDetailsErrorState extends LeavesEditState {
  final String error;
  LeavesDetailsErrorState(this.error);
}
//*************************** */
class ImageSelectedState extends LeavesEditState {
  final XFile image;
  ImageSelectedState(this.image);
}