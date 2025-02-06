import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_edit/data/models/leaves_details_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_edit/data/models/leaves_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_edit/logic/leaves_edit_state.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/gallary_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';

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
  editLeaves(String? image,int id,typeId) async {
    emit(LeavesEditLoadingState());
MultipartFile? imageFile;
    if (image != null && image.isNotEmpty) {
      imageFile = await MultipartFile.fromFile(
        image,
        filename: image.split('/').last,
      );
    }

      Map<String, dynamic> formDataMap = {
        "id": id,
        "userId": employeeController.text.isNotEmpty
            ? employeeIdController.text
            : leavesDetailsModel!.data!.id,
        "startDate": startDateController.text.isNotEmpty
            ? startDateController.text
            : leavesDetailsModel!.data!.startDate,
        "endDate": endDateController.text.isNotEmpty
            ? endDateController.text
            : leavesDetailsModel!.data!.endDate,
        "type": typeController.text.isNotEmpty
            ? typeId
            : leavesDetailsModel!.data!.type,
        "reason": discriptionController.text.isNotEmpty
            ? discriptionController.text
            : leavesDetailsModel!.data!.reason,
            "File": leavesDetailsModel!.data!.file ?? imageFile
      };

    FormData formData = FormData.fromMap(formDataMap);
    try {
      final response =
          await DioHelper.putData2(url: ApiConstants.leavesEditUrl, data: formData);
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
  getAllUsersInUserManage({
    int? organizationId,
    int? buildingId,
    int? floorId,
    int? pointId,
  }) {
    emit(AllUsersLoadingState());
    DioHelper.getData(url: "users/pagination").then((value) {
      usersModel = UsersModel.fromJson(value!.data);
      emit(AllUsersSuccessState(usersModel!));
    }).catchError((error) {
      emit(AllUsersErrorState(error.toString()));
    });
  }

GalleryModel? gellaryModel;
  XFile? image;
  Future<void> galleryFile() async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      image = selectedImage;
      emit(ImageSelectedState(image!));
    }
  }

}
