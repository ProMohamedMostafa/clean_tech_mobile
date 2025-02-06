import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/all_area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/points_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/task/edit_task/data/models/delete_task_list_model.dart';
import 'package:smart_cleaning_application/features/screens/task/edit_task/data/models/delete_task_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/all_tasks_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/change_task_status.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/completed_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/in_progress_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/not_approvable_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/not_resolved_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/overdue_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/pending_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/rejected_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/task_action_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/task_details.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/task_files_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/logic/task_management_state.dart';

import '../../../integrations/data/models/gallary_model.dart';

class TaskManagementCubit extends Cubit<TaskManagementState> {
  TaskManagementCubit() : super(TaskManagementInitialState());

  static TaskManagementCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  TextEditingController createdByController = TextEditingController();
  TextEditingController assignToController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  DeleteTaskModel? deleteTaskModel;
  taskDelete(int id) {
    emit(TaskDeleteLoadingState());
    DioHelper.postData(url: 'tasks/delete/$id', data: {'id': id}).then((value) {
      deleteTaskModel = DeleteTaskModel.fromJson(value!.data);
      emit(TaskDeleteSuccessState(deleteTaskModel!));
    }).catchError((error) {
      emit(TaskDeleteErrorState(error.toString()));
    });
  }

  DeleteTaskListModel? deleteTaskListModel;
  getAllDeletedTasks() {
    emit(TaskDeleteListLoadingState());
    DioHelper.getData(url: ApiConstants.getAllDeletedTasksUrl).then((value) {
      deleteTaskListModel = DeleteTaskListModel.fromJson(value!.data);
      emit(TaskDeleteListSuccessState(deleteTaskListModel!));
    }).catchError((error) {
      emit(TaskDeleteListErrorState(error.toString()));
    });
  }

  restoreDeletedTask(int id) {
    emit(RestoreTaskLoadingState());
    DioHelper.postData(url: 'tasks/restore/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(RestoreTaskSuccessState(message));
    }).catchError((error) {
      emit(RestoreTaskErrorState(error.toString()));
    });
  }

  forcedDeletedUser(int id) {
    emit(ForceDeleteTaskLoadingState());
    DioHelper.deleteData(url: 'tasks/forcedelete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(ForceDeleteTaskSuccessState(message));
    }).catchError((error) {
      emit(ForceDeleteTaskErrorState(error.toString()));
    });
  }

  AllTasksModel? allTasksModel;
  getAllTasks({
    DateTime? startDate,
    int? createdBy,
    int? assignTo,
    int? status,
    int? priority,
    int? areaId,
    int? cityId,
    int? organizationId,
    int? buildingId,
    int? floorId,
    int? pointId,
  }) {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'search': searchController.text,
      'startDate': DateFormat('yyyy-MM-dd').format(startDate!),
      'endDate': endDateController.text,
      'startTime': startTimeController.text,
      'endTime': endTimeController.text,
      'created': createdBy,
      'assignTo': assignTo,
      'status': status,
      'priority': priority,
      'area': areaId,
      'city': cityId,
      'organization': organizationId,
      'building': buildingId,
      'floor': floorId,
      'point': pointId,
    }).then((value) {
      allTasksModel = AllTasksModel.fromJson(value!.data);
      emit(GetAllTasksSuccessState(allTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }

  TaskFilesModel? taskFilesModel;
  getTaskFiles(int id) {
    emit(GetTaskFilesLoadingState());
    DioHelper.getData(url: "file/task/$id").then((value) {
      taskFilesModel = TaskFilesModel.fromJson(value!.data);
      emit(GetTaskFilesSuccessState(taskFilesModel!));
    }).catchError((error) {
      emit(GetTaskFilesErrorState(error.toString()));
    });
  }

  PendingModel? pendingModel;
  getPendingTasks(DateTime startDate) {
    emit(GetPendingTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'status': 0,
      'startDate': DateFormat('yyyy-MM-dd').format(startDate)
    }).then((value) {
      pendingModel = PendingModel.fromJson(value!.data);
      emit(GetPendingTasksSuccessState(pendingModel!));
    }).catchError((error) {
      emit(GetPendingTasksErrorState(error.toString()));
    });
  }

  InProgressModel? inProgressModel;
  getInProgressTasks(DateTime startDate) {
    emit(GetInProgressTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'status': 1,
      'startDate': DateFormat('yyyy-MM-dd').format(startDate)
    }).then((value) {
      inProgressModel = InProgressModel.fromJson(value!.data);
      emit(GetInProgressTasksSuccessState(inProgressModel!));
    }).catchError((error) {
      emit(GetInProgressTasksErrorState(error.toString()));
    });
  }

  NotApprovableModel? notApprovableModel;
  getNotApprovableTasks(DateTime startDate) {
    emit(GetNotApprovableTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'status': 2,
      'startDate': DateFormat('yyyy-MM-dd').format(startDate)
    }).then((value) {
      notApprovableModel = NotApprovableModel.fromJson(value!.data);
      emit(GetNotApprovableTasksSuccessState(notApprovableModel!));
    }).catchError((error) {
      emit(GetNotApprovableTasksErrorState(error.toString()));
    });
  }

  CompletedModel? completedModel;
  getCompletedTasks(DateTime startDate) {
    emit(GetCompletedTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'status': 3,
      'startDate': DateFormat('yyyy-MM-dd').format(startDate)
    }).then((value) {
      completedModel = CompletedModel.fromJson(value!.data);
      emit(GetCompletedTasksSuccessState(completedModel!));
    }).catchError((error) {
      emit(GetCompletedTasksErrorState(error.toString()));
    });
  }

  RejectedModel? rejectedModel;
  getRejectedTasks(DateTime startDate) {
    emit(GetRejectedTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'status': 4,
      'startDate': DateFormat('yyyy-MM-dd').format(startDate)
    }).then((value) {
      rejectedModel = RejectedModel.fromJson(value!.data);
      emit(GetRejectedTasksSuccessState(rejectedModel!));
    }).catchError((error) {
      emit(GetRejectedTasksErrorState(error.toString()));
    });
  }

  NotResolvedModel? notResolvedModel;
  getNotResolvedTasks(DateTime startDate) {
    emit(GetNotResolvedTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'status': 5,
      'startDate': DateFormat('yyyy-MM-dd').format(startDate)
    }).then((value) {
      notResolvedModel = NotResolvedModel.fromJson(value!.data);
      emit(GetNotResolvedTasksSuccessState(notResolvedModel!));
    }).catchError((error) {
      emit(GetNotResolvedTasksErrorState(error.toString()));
    });
  }

  OverdueModel? overdueModel;
  getOverdueTasks(DateTime startDate) {
    emit(GetOverdueTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'status': 6,
      'startDate': DateFormat('yyyy-MM-dd').format(startDate)
    }).then((value) {
      overdueModel = OverdueModel.fromJson(value!.data);
      emit(GetOverdueTasksSuccessState(overdueModel!));
    }).catchError((error) {
      emit(GetOverdueTasksErrorState(error.toString()));
    });
  }

  TaskDetailsModel? taskDetailsModel;
  getTaskDetails(int id) {
    emit(GetTaskDetailsLoadingState());
    DioHelper.getData(url: "tasks/$id").then((value) {
      taskDetailsModel = TaskDetailsModel.fromJson(value!.data);
      emit(GetTaskDetailsSuccessState(taskDetailsModel!));
    }).catchError((error) {
      emit(GetTaskDetailsErrorState(error.toString()));
    });
  }

  ChangeTaskStatusModel? changeTaskStatusModel;
  changeTaskStatus(int taskId, int statusIndex) async {
    emit(GetChangeTaskStatusLoadingState());
    Map<String, dynamic> formDataMap = {
      "TaskId": taskId,
      "Status": statusIndex,
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

  ChangeTaskStatusModel? changeTaskStatusCommentModel;
  addComment(String image, int taskId, int statusIndex) async {
    MultipartFile? imageFile;
    if (image.isNotEmpty) {
      imageFile = await MultipartFile.fromFile(
        image,
        filename: image.split('/').last,
      );
    }
    emit(GetChangeTaskStatusLoadingState());
    Map<String, dynamic> formDataMap = {
      "TaskId": taskId,
      "Status": statusIndex,
      "Comment": commentController.text,
      "Files": imageFile,
    };
    FormData formData = FormData.fromMap(formDataMap);
    try {
      final response = await DioHelper.postData2(
          url: ApiConstants.changeTaskStatusUrl, data: formData);
      changeTaskStatusCommentModel =
          ChangeTaskStatusModel.fromJson(response!.data);

      emit(GetChangeTaskStatusSuccessState(changeTaskStatusCommentModel!));
    } catch (error) {
      emit(GetChangeTaskStatusErrorState(error.toString()));
    }
  }

  TaskActionModel? taskActionModel;
  getTaskAction(int id) {
    emit(GetTaskActionLoadingState());

    DioHelper.getData(url: "action/task/$id").then((value) {
      taskActionModel = TaskActionModel.fromJson(value!.data);

      // Calculate time differences and total times based on status
      for (var action in taskActionModel!.data!) {
        if (action.status == "In Progress") {
          action.timeDifferenceText =
              calculateTimeDifference(action.createdAt!, action.status!);
        } else if (action.status == "Rejected") {
          action.timeDifferenceText =
              calculateTimeDifference(action.createdAt!, action.status!);
        } else if (action.status == "Completed") {
          action.timeDifferenceText =
              calculateTotalElapsedTime(action.createdAt!);
        } else if (action.status == "Waiting For Approval") {
          action.timeDifferenceText =
              calculateTotalElapsedTime(action.createdAt!);
        } else if (action.status == "Pending") {
          action.timeDifferenceText = "Task not start yet";
        } else if (action.status == "Not Resolved") {
          action.timeDifferenceText = "Task was stopped";
        } else if (action.status == "Overdue") {
          action.timeDifferenceText = "Task is Overdue";
        }
      }

      emit(GetTaskActionSuccessState(taskActionModel!));
    }).catchError((error) {
      emit(GetTaskActionErrorState(error.toString()));
    });
  }

  AllAreaModel? allAreaModel;
  getArea() {
    emit(GetAreaLoadingState());
    DioHelper.getData(url: ApiConstants.areaUrl).then((value) {
      allAreaModel = AllAreaModel.fromJson(value!.data);
      emit(GetAreaSuccessState(allAreaModel!));
    }).catchError((error) {
      emit(GetAreaErrorState(error.toString()));
    });
  }

  CityModel? cityModel;
  getCity(int areaId) {
    emit(GetCityLoadingState());
    DioHelper.getData(url: "cities/area/$areaId").then((value) {
      cityModel = CityModel.fromJson(value!.data);
      emit(GetCitySuccessState(cityModel!));
    }).catchError((error) {
      emit(GetCityErrorState(error.toString()));
    });
  }

  OrganizationModel? organizationModel;
  getOrganization(int cityId) {
    emit(GetOrganizationLoadingState());
    DioHelper.getData(url: "organizations/city/$cityId").then((value) {
      organizationModel = OrganizationModel.fromJson(value!.data);
      emit(GetOrganizationSuccessState(organizationModel!));
    }).catchError((error) {
      emit(GetOrganizationErrorState(error.toString()));
    });
  }

  BuildingModel? buildingModel;
  getBuilding(int organizationId) {
    emit(GetBuildingLoadingState());
    DioHelper.getData(url: 'buildings/organization/$organizationId')
        .then((value) {
      buildingModel = BuildingModel.fromJson(value!.data);
      emit(GetBuildingSuccessState(buildingModel!));
    }).catchError((error) {
      emit(GetBuildingErrorState(error.toString()));
    });
  }

  FloorModel? floorModel;
  getFloor(int buildingId) {
    emit(GetFloorLoadingState());
    DioHelper.getData(url: 'floors/building/$buildingId').then((value) {
      floorModel = FloorModel.fromJson(value!.data);
      emit(GetFloorSuccessState(floorModel!));
    }).catchError((error) {
      emit(GetFloorErrorState(error.toString()));
    });
  }

  PointsModel? pointsModel;
  getPoints(int pointId) {
    emit(GetPointLoadingState());
    DioHelper.getData(url: 'points/floor/$pointId').then((value) {
      pointsModel = PointsModel.fromJson(value!.data);
      emit(GetPointSuccessState(pointsModel!));
    }).catchError((error) {
      emit(GetPointErrorState(error.toString()));
    });
  }

  UsersModel? usersModel;
  getAllUsers() {
    emit(AllUsersLoadingState());
    DioHelper.getData(url: "users/pagination").then((value) {
      usersModel = UsersModel.fromJson(value!.data);
      emit(AllUsersSuccessState(usersModel!));
    }).catchError((error) {
      emit(AllUsersErrorState(error.toString()));
    });
  }

  String calculateTimeDifference(String createdAt, String status) {
    DateTime createdTime = DateTime.parse(createdAt);
    Duration difference = DateTime.now().difference(createdTime);

    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;

    String result = "Received";
    if (days > 0) result += " $days day${days > 1 ? 's' : ''}";
    if (hours > 0) result += " $hours hour${hours > 1 ? 's' : ''}";
    if (minutes > 0) result += " $minutes minute${minutes > 1 ? 's' : ''}";
    if (days == 0 && hours == 0 && minutes == 0) result += " just now";

    return result.trim();
  }

  String calculateTotalElapsedTime(String completedAt) {
    DateTime completedTime = DateTime.parse(completedAt);

    var inProgressAction = taskActionModel!.data!
        .firstWhere((action) => action.status == "In Progress");

    DateTime inProgressTime = DateTime.parse(inProgressAction.createdAt!);
    Duration difference = completedTime.difference(inProgressTime);

    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;

    String result = "Total time:";
    if (days > 0) result += " $days day${days > 1 ? 's' : ''}";
    if (hours > 0) result += " $hours hour${hours > 1 ? 's' : ''}";
    if (minutes > 0) result += " $minutes minute${minutes > 1 ? 's' : ''}";

    return result.trim();
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
