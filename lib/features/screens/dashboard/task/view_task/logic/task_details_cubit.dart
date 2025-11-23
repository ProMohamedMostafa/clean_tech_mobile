import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/task_management/data/models/delete_task_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/view_task/data/model/change_task_status.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/view_task/data/model/task_details.dart';

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
      "File": imageFile,
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

  XFile? image;
  Future<void> pickSingleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      image = XFile(result.files.single.path!);
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

  void removeSelectedFile() {
    image = null;
    emit(RemoveSelectedFileState());
  }

  final List<String> priority = ["High", "Medium", "Low"];
  final List<Color> priorityColor = [
    Colors.red,
    Colors.orange,
    Colors.green,
  ];

  Color? priorityColorForTask;
  bool descTextShowFlag = false;

  String formatTime(String time) {
    List<String> parts = time.split(':');
    return '${parts[0]}:${parts[1]}';
  }

  String formatDuration(String duration) {
    try {
      int days = 0, hours = 0, minutes = 0;

      // Split the fractional seconds (after last dot)
      String mainPart = duration.contains(".")
          ? duration.substring(0, duration.lastIndexOf('.'))
          : duration;

      // Check if days are present (dot before HH:MM:SS)
      if (mainPart.contains(".") &&
          mainPart.indexOf('.') < mainPart.indexOf(':')) {
        // Example: "1.03:01:43"
        var splitDay = mainPart.split('.');
        days = int.parse(splitDay[0]);
        mainPart = splitDay[1]; // HH:MM:SS
      }

      // Split hours, minutes, seconds
      var parts = mainPart.split(':');

      if (parts.length == 3) {
        hours = int.parse(parts[0]);
        minutes = int.parse(parts[1]);
      } else if (parts.length == 2) {
        minutes = int.parse(parts[0]);
      } else if (parts.length == 1) {
      } else {
        return "Invalid duration";
      }

      // Add days to hours
      hours += days * 24;

      // Build a readable string
      List<String> result = [];
      if (hours > 0) result.add("$hours hour${hours > 1 ? 's' : ''}");
      if (minutes > 0) result.add("$minutes min${minutes > 1 ? 's' : ''}");

      return result.isEmpty ? "0 sec" : result.join(' ');
    } catch (e) {
      return "Invalid duration";
    }
  }

  DateTime parseUtc(String dateString) {
    // Treat backend time as UTC
    return DateTime.parse("${dateString}Z").toUtc().toLocal();
  }
}
