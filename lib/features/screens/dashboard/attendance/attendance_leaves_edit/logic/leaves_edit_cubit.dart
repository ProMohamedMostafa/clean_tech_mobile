import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attedance_leaves_details/data/model/leaves_details_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_leaves_edit/data/models/leaves_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_leaves_edit/logic/leaves_edit_state.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/users_model.dart';

class LeavesEditCubit extends Cubit<LeavesEditState> {
  LeavesEditCubit() : super(LeavesEditInitialState());

  static LeavesEditCubit get(context) => BlocProvider.of(context);

  TextEditingController employeeController = TextEditingController();
  TextEditingController employeeIdController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController typeIdController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  AttendanceLeavesEditModel? attendanceLeavesEditModel;

  Future<void> editLeaves(int id) async {
    emit(LeavesEditLoadingState());

    MultipartFile? imageFile;
    if (image != null) {
      imageFile = await MultipartFile.fromFile(
        image!.path,
        filename: image!.name,
      );
    }

    final formDataMap = {
      "Id": id,
      "UserId": employeeController.text.isNotEmpty
          ? employeeIdController.text
          : leavesDetailsModel!.data!.userId,
      "StartDate": startDateController.text.isNotEmpty
          ? startDateController.text
          : leavesDetailsModel!.data!.startDate,
      "EndDate": endDateController.text.isNotEmpty
          ? endDateController.text
          : leavesDetailsModel!.data!.endDate,
      "Type": typeController.text.isEmpty
          ? leavesDetailsModel!.data!.typeId
          : typeIdController.text,
      "Reason": discriptionController.text.isNotEmpty
          ? discriptionController.text
          : leavesDetailsModel!.data!.reason,
      "File": imageFile,
    };

    final formData = FormData.fromMap(formDataMap);

    try {
      final response = await DioHelper.putData2(
        url: ApiConstants.leavesEditUrl,
        data: formData,
      );
      attendanceLeavesEditModel =
          AttendanceLeavesEditModel.fromJson(response!.data);
      emit(LeavesEditSuccessState(attendanceLeavesEditModel!));
    } catch (error) {
      emit(LeavesEditErrorState(error.toString()));
    }
  }

  Future<void> editLeavesRequest(int id) async {
    emit(LeavesEditLoadingState());

    MultipartFile? imageFile;
    if (image != null) {
      imageFile = await MultipartFile.fromFile(
        image!.path,
        filename: image!.name,
      );
    }

    final formDataMap = {
      "Id": id,
      "StartDate": startDateController.text.isNotEmpty
          ? startDateController.text
          : leavesDetailsModel?.data?.startDate,
      "EndDate": endDateController.text.isNotEmpty
          ? endDateController.text
          : leavesDetailsModel?.data?.endDate,
      "Type": typeController.text.isEmpty
          ? leavesDetailsModel?.data?.typeId
          : typeIdController.text,
      "Reason": discriptionController.text.isNotEmpty
          ? discriptionController.text
          : leavesDetailsModel?.data?.reason,
      "File": imageFile,
    };

    final formData = FormData.fromMap(formDataMap);

    try {
      final response = await DioHelper.putData2(
        url: 'leaves/edit/request',
        data: formData,
      );
      attendanceLeavesEditModel =
          AttendanceLeavesEditModel.fromJson(response!.data);
      emit(LeavesEditSuccessState(attendanceLeavesEditModel!));
    } catch (error) {
      emit(LeavesEditErrorState(error.toString()));
    }
  }

  LeavesDetailsModel? leavesDetailsModel;
  getLeavesDetails(int? id) {
    emit(LeavesDetailsLoadingState());
    DioHelper.getData(url: "leaves/$id").then((value) {
      leavesDetailsModel = LeavesDetailsModel.fromJson(value!.data);
      emit(LeavesDetailsSuccessState(leavesDetailsModel!));
    }).catchError((error) {
      emit(LeavesDetailsErrorState(error.toString()));
    });
  }

  UsersModel? usersModel;
  List<UserItem> userItem = [UserItem(userName: 'No users available')];
  getAllUsers() {
    emit(AllUsersLoadingState());
    DioHelper.getData(url: "users/pagination").then((value) {
      usersModel = UsersModel.fromJson(value!.data);
      userItem =
          usersModel?.data?.users ?? [UserItem(userName: 'No users available')];
      emit(AllUsersSuccessState(usersModel!));
    }).catchError((error) {
      emit(AllUsersErrorState(error.toString()));
    });
  }

  void initialize() {
    if (role == 'Admin') {
      getAllUsers();
    }
  }

  XFile? image;

  Future<void> pickSingleFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      image = XFile(result.files.single.path!);
      emit(ImageSelectedState(image!));
    }
  }
}
