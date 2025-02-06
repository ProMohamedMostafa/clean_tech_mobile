import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_add/data/models/attendance_leaves_add_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_add/logic/leaves_add_state.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/gallary_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';

class LeavesAddCubit extends Cubit<LeavesAddState> {
  LeavesAddCubit() : super(LeavesAddInitialState());

  static LeavesAddCubit get(context) => BlocProvider.of(context);

  TextEditingController employeeController = TextEditingController();
  TextEditingController employeeIdController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController typeIdController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  AttendanceLeavesAddModel? attendanceLeavesAddModel;
  createLeaves(String? image, int typeId) async {
    emit(LeavesAddLoadingState());
 MultipartFile? imageFile;
    if (image != null && image.isNotEmpty) {
      imageFile = await MultipartFile.fromFile(
        image,
        filename: image.split('/').last,
      );
    }
    Map<String, dynamic> formDataMap = {
        "userLogin": uId,
        "userId": employeeIdController.text,
        "startDate": startDateController.text,
        "endDate": endDateController.text,
        "type": typeId,
        "reason": discriptionController.text,
        "File": imageFile,
      };

    FormData formData = FormData.fromMap(formDataMap);
    try {
      final response =
          await DioHelper.postData2(url: ApiConstants.leavesCreateUrl, data: formData);
      attendanceLeavesAddModel =
          AttendanceLeavesAddModel.fromJson(response!.data);
      emit(LeavesAddSuccessState(attendanceLeavesAddModel!));
    } catch (error) {
      emit(LeavesAddErrorState(error.toString()));
    }
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
