import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/gallary_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/task/edit_task/data/models/delete_task_model.dart';
import 'package:smart_cleaning_application/features/screens/task/view_task/data/model/change_task_status.dart';
import 'package:smart_cleaning_application/features/screens/task/view_task/data/model/task_details.dart';

part 'task_details_state.dart';

class TaskDetailsCubit extends Cubit<TaskDetailsState> {
  TaskDetailsCubit() : super(TaskDetailsInitialState());

  final formKey = GlobalKey<FormState>();

  TextEditingController commentController = TextEditingController();
  TextEditingController currentReadingController = TextEditingController();

  TaskDetailsModel? taskDetailsModel;
  getTaskDetails(int id) {
    emit(TaskDetailsLoadingState());
    DioHelper.getData(url: "tasks/$id").then((value) {
      taskDetailsModel = TaskDetailsModel.fromJson(value!.data);
      emit(TaskDetailsSuccessState(taskDetailsModel!));
    }).catchError((error) {
      emit(TaskDetailsErrorState(error.toString()));
    });
  }

  UsersModel? usersModel;
  getUsers() {
    emit(UserLoadingState());
    DioHelper.getData(url: "users/pagination").then((value) {
      usersModel = UsersModel.fromJson(value!.data);
      emit(UserSuccessState(usersModel!));
    }).catchError((error) {
      emit(UserErrorState(error.toString()));
    });
  }

  DeleteTaskModel? deleteTaskModel;
  taskDelete(int id) {
    emit(TaskDeleteLoadingState());
    DioHelper.postData(url: 'tasks/delete/$id').then((value) {
      deleteTaskModel = DeleteTaskModel.fromJson(value!.data);
      emit(TaskDeleteSuccessState(deleteTaskModel!));
    }).catchError((error) {
      emit(TaskDeleteErrorState(error.toString()));
    });
  }

  ChangeTaskStatusModel? changeTaskStatusModel;
  changeTaskStatus(int taskId, int statusIndex, {double? reading}) async {
    emit(GetChangeTaskStatusLoadingState());
    Map<String, dynamic> formDataMap = {
      "TaskId": taskId,
      "Status": statusIndex,
      "ReadingAfter": reading,
    };
    FormData formData = FormData.fromMap(formDataMap);
    try {
      final response = await DioHelper.postData2(
          url: ApiConstants.changeTaskStatusUrl, data: formData);
      changeTaskStatusModel = ChangeTaskStatusModel.fromJson(response!.data);
      emit(GetChangeTaskStatusSuccessState(changeTaskStatusModel!));
    } catch (error) {
      emit(GetChangeTaskStatusErrorState(error.toString()));
    }
  }

  addComment(String image, int taskId, int statusIndex) async {
    MultipartFile? imageFile;
    if (image.isNotEmpty) {
      imageFile = await MultipartFile.fromFile(
        image,
        filename: image.split('/').last,
      );
    }
    emit(AddCommentsLoadingState());
    Map<String, dynamic> formDataMap = {
      "TaskId": taskId,
      "Comment": commentController.text,
      "Files": imageFile,
    };
    FormData formData = FormData.fromMap(formDataMap);
    try {
      final response =
          await DioHelper.postData2(url: 'comments/create', data: formData);
      final message = response?.data['message'] ?? "added successfully";

      emit(AddCommentsSuccessState(message!));
    } catch (error) {
      emit(AddCommentsErrorState(error.toString()));
    }
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

  Future<void> cameraFile() async {
    final ImagePicker cameraPicker = ImagePicker();
    final XFile? selectedImage =
        await cameraPicker.pickImage(source: ImageSource.camera);

    if (selectedImage != null) {
      image = selectedImage;
      emit(CameraSelectedState(image!));
    }
  }
}
