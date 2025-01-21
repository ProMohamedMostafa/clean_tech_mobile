import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/data/models/all_tasks_model.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/data/models/gallary_model.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/data/models/supervisor_model.dart';
import 'package:smart_cleaning_application/features/screens/task/edit_task/data/models/edit_task_model.dart';
import 'package:smart_cleaning_application/features/screens/task/edit_task/data/models/users_task_model.dart';
import 'package:smart_cleaning_application/features/screens/task/edit_task/logic/edit_task_state.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/task_details.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/task_files_model.dart';
import '../../../integrations/data/models/building_model.dart';
import '../../../integrations/data/models/floor_model.dart';
import '../../../integrations/data/models/organization_model.dart';
import '../../../integrations/data/models/points_model.dart';

class EditTaskCubit extends Cubit<EditTaskState> {
  EditTaskCubit() : super(EditTaskInitialState());

  static EditTaskCubit get(context) => BlocProvider.of(context);
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController cleanersController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController parentTaskController = TextEditingController();
  final supervisorsController = MultiSelectController<SupervisorData>();

  EditTaskModel? editTaskModel;
  editTask(
    int id,
    int? priorityId,
    int? statusId,
    int? buildingId,
    int? floorId,
    int? pointId,
    List<int>? selectedSupervisorIds,
    int? parentId,
  ) async {
    emit(EditTaskLoadingState());
    Map<String, dynamic> formDataMap = {
      "id": id,
      "ParentId": parentTaskController.text.isEmpty
          ? taskDetailsModel!.data!.parentId
          : parentId,
      "Title": taskTitleController.text.isEmpty
          ? taskDetailsModel!.data!.title
          : taskTitleController.text,
      "Description": descriptionController.text.isEmpty
          ? taskDetailsModel!.data!.description
          : descriptionController.text,
      "Priority": priorityId ?? taskDetailsModel!.data!.priority,
      "Status": statusId ?? taskDetailsModel!.data!.status,
      "StartDate": startDateController.text.isEmpty
          ? taskDetailsModel!.data!.startDate
          : startDateController.text,
      "EndDate": endDateController.text.isEmpty
          ? taskDetailsModel!.data!.endDate
          : endDateController.text,
      "StartTime": startTimeController.text.isEmpty
          ? taskDetailsModel!.data!.startTime
          : startTimeController.text,
      "EndTime": endTimeController.text.isEmpty
          ? taskDetailsModel!.data!.endTime
          : endTimeController.text,
      "BuildingId": buildingController.text.isEmpty
          ? taskDetailsModel!.data!.buildingId
          : buildingId,
      "FloorId": floorController.text.isEmpty
          ? taskDetailsModel!.data!.floorId
          : floorId,
      "PointId": pointController.text.isEmpty
          ? taskDetailsModel!.data!.pointId
          : pointId,
      "UsersIds": selectedSupervisorIds ??
          usersTaskModel?.data?.map((user) => user.id ?? 0).toList() ??
          [],
      "Files": [],
    };

    FormData formData = FormData.fromMap(formDataMap);
    try {
      final response = await DioHelper.putData2(
          url: ApiConstants.editTaskUrl, data: formData);
      editTaskModel = EditTaskModel.fromJson(response!.data);
      emit(EditTaskSuccessState(editTaskModel!));
    } catch (error) {
      emit(EditTaskErrorState(error.toString()));
    }
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

  UsersTaskModel? usersTaskModel;
  getUsersTask(int id) {
    emit(GetUsersTaskLoadingState());
    DioHelper.getData(url: "assign/task/$id").then((value) {
      usersTaskModel = UsersTaskModel.fromJson(value!.data);
      emit(GetUsersTaskSuccessState(usersTaskModel!));
    }).catchError((error) {
      emit(GetUsersTaskErrorState(error.toString()));
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

  AllTasksModel? allTasksModel;
  getAllTasks() {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination").then((value) {
      allTasksModel = AllTasksModel.fromJson(value!.data);
      emit(GetAllTasksSuccessState(allTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }

  SupervisorModel? supervisorModel;
  getSupervisor() {
    emit(GetSupervisorLoadingState());
    DioHelper.getData(url: 'users/manager/$uId').then((value) {
      supervisorModel = SupervisorModel.fromJson(value!.data);
      emit(GetSupervisorSuccessState(supervisorModel!));
    }).catchError((error) {
      emit(GetSupervisorErrorState(error.toString()));
    });
  }

  OrganizationModel? organizationModel;
  getOrganization() {
    emit(GetOrganizationLoadingState());
    DioHelper.getData(url: ApiConstants.organizationUrl).then((value) {
      organizationModel = OrganizationModel.fromJson(value!.data);
      emit(GetOrganizationSuccessState(organizationModel!));
    }).catchError((error) {
      emit(GetOrganizationErrorState(error.toString()));
    });
  }

  BuildingModel? buildingModel;
  getBuilding(int id) {
    emit(GetBuildingLoadingState());
    DioHelper.getData(url: 'buildings/organization/$id').then((value) {
      buildingModel = BuildingModel.fromJson(value!.data);
      emit(GetBuildingSuccessState(buildingModel!));
    }).catchError((error) {
      emit(GetBuildingErrorState(error.toString()));
    });
  }

  FloorModel? floorModel;
  getFloor(int id) {
    emit(GetFloorLoadingState());
    DioHelper.getData(url: 'floors/building/$id').then((value) {
      floorModel = FloorModel.fromJson(value!.data);
      emit(GetFloorSuccessState(floorModel!));
    }).catchError((error) {
      emit(GetFloorErrorState(error.toString()));
    });
  }

  PointsModel? pointsModel;
  getPoints(int id) {
    emit(GetPointsLoadingState());
    DioHelper.getData(url: 'points/floor/$id').then((value) {
      pointsModel = PointsModel.fromJson(value!.data);
      emit(GetPointsSuccessState(pointsModel!));
    }).catchError((error) {
      emit(GetPointsErrorState(error.toString()));
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
