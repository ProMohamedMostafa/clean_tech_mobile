import 'package:image_picker/image_picker.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_leaves_add/data/models/attendance_leaves_add_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/users_model.dart';

abstract class LeavesAddState {}

class LeavesAddInitialState extends LeavesAddState {}

class LeavesAddLoadingState extends LeavesAddState {}

class LeavesAddSuccessState extends LeavesAddState {
  final AttendanceLeavesAddModel attendanceLeavesAddModel;

  LeavesAddSuccessState(this.attendanceLeavesAddModel);
}

class LeavesAddErrorState extends LeavesAddState {
  final String error;
  LeavesAddErrorState(this.error);
}
//***************** */

class AllUsersLoadingState extends LeavesAddState {}

class AllUsersSuccessState extends LeavesAddState {
  final UsersModel usersModel;

  AllUsersSuccessState(this.usersModel);
}

class AllUsersErrorState extends LeavesAddState {
  final String error;
  AllUsersErrorState(this.error);
}
//*************************** */
class ImageSelectedState extends LeavesAddState {
  final XFile image;
  ImageSelectedState(this.image);
}
class RemoveSelectedFileState extends LeavesAddState {}
