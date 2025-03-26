import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/all_area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/data/models/all_tasks_model.dart';
import 'package:smart_cleaning_application/features/screens/task/edit_task/data/models/delete_task_list_model.dart';
import 'package:smart_cleaning_application/features/screens/task/edit_task/data/models/delete_task_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/change_task_status.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/completed_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/in_progress_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/not_approvable_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/not_resolved_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/overdue_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/pending_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/rejected_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/task_details.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/logic/task_management_state.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/providers_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/point_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/section_model.dart';
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
  TextEditingController sectionController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController providerController = TextEditingController();
    TextEditingController currentReadingController = TextEditingController();

  final formKey = GlobalKey<FormState>();

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
  getAllTasks(
      {DateTime? startDate,
      int? createdBy,
      int? assignTo,
      int? status,
      int? priority,
      int? areaId,
      int? cityId,
      int? organizationId,
      int? buildingId,
      int? floorId,
      int? sectionId,
      int? pointId,
      int? providerId}) {
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
      'provider': providerId,
      'area': areaId,
      'city': cityId,
      'organization': organizationId,
      'building': buildingId,
      'floor': floorId,
      'section': sectionId,
      'point': pointId,
    }).then((value) {
      allTasksModel = AllTasksModel.fromJson(value!.data);
      emit(GetAllTasksSuccessState(allTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
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

  ChangeTaskStatusModel? changeTaskStatusModel;
  changeTaskStatus(int taskId, int statusIndex,{double? reading}) async {
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

  CityListModel? cityModel;
  getCity(int areaId) {
    emit(GetCityLoadingState());
    DioHelper.getData(url: "cities/pagination", query: {'area': areaId})
        .then((value) {
      cityModel = CityListModel.fromJson(value!.data);
      emit(GetCitySuccessState(cityModel!));
    }).catchError((error) {
      emit(GetCityErrorState(error.toString()));
    });
  }

  OrganizationListModel? organizationModel;
  getOrganization(int cityId) {
    emit(GetOrganizationLoadingState());
    DioHelper.getData(url: "organizations/pagination", query: {'city': cityId})
        .then((value) {
      organizationModel = OrganizationListModel.fromJson(value!.data);
      emit(GetOrganizationSuccessState(organizationModel!));
    }).catchError((error) {
      emit(GetOrganizationErrorState(error.toString()));
    });
  }

  BuildingListModel? buildingModel;
  getBuilding(int organizationId) {
    emit(GetBuildingLoadingState());
    DioHelper.getData(
        url: 'buildings/pagination',
        query: {'organization': organizationId}).then((value) {
      buildingModel = BuildingListModel.fromJson(value!.data);
      emit(GetBuildingSuccessState(buildingModel!));
    }).catchError((error) {
      emit(GetBuildingErrorState(error.toString()));
    });
  }

  FloorListModel? floorModel;
  getFloor(int buildingId) {
    emit(GetFloorLoadingState());
    DioHelper.getData(url: 'floors/pagination', query: {'building': buildingId})
        .then((value) {
      floorModel = FloorListModel.fromJson(value!.data);
      emit(GetFloorSuccessState(floorModel!));
    }).catchError((error) {
      emit(GetFloorErrorState(error.toString()));
    });
  }

  SectionListModel? sectionModel;
  getSection(int floorId) {
    emit(GetSectionLoadingState());
    DioHelper.getData(url: 'sections/pagination', query: {'floor': floorId})
        .then((value) {
      sectionModel = SectionListModel.fromJson(value!.data);
      emit(GetSectionSuccessState(sectionModel!));
    }).catchError((error) {
      emit(GetSectionErrorState(error.toString()));
    });
  }

  PointListModel? pointModel;
  getPoint(int sectionId) {
    emit(GetPointLoadingState());
    DioHelper.getData(url: 'points/pagination', query: {'section': sectionId})
        .then((value) {
      pointModel = PointListModel.fromJson(value!.data);
      emit(GetPointSuccessState(pointModel!));
    }).catchError((error) {
      emit(GetPointErrorState(error.toString()));
    });
  }

  ProvidersModel? providersModel;
  getProviders() {
    emit(AllProvidersLoadingState());
    DioHelper.getData(url: ApiConstants.allProvidersUrl).then((value) {
      providersModel = ProvidersModel.fromJson(value!.data);
      emit(AllProvidersSuccessState(providersModel!));
    }).catchError((error) {
      emit(AllProvidersErrorState(error.toString()));
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
