import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/all_organization_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/data/models/all_tasks_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/gallary_model.dart';
import 'package:smart_cleaning_application/features/screens/task/edit_task/data/models/edit_task_model.dart';
import 'package:smart_cleaning_application/features/screens/task/edit_task/logic/edit_task_state.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/task_details.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/point_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/section_model.dart';

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
  TextEditingController sectionController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController cleanersController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController parentTaskController = TextEditingController();
  TextEditingController currentReadingController = TextEditingController();
  final supervisorsController = MultiSelectController<User>();
  final formKey = GlobalKey<FormState>();

  EditTaskModel? editTaskModel;
  editTask(
    int id,
    int? priorityId,
    int? statusId,
    int? buildingId,
    int? floorId,
    int? sectionId,
    int? pointId,
    List<int>? selectedSupervisorIds,
    int? parentId,
    double? currentReading,
  ) async {
    emit(EditTaskLoadingState());
    Map<String, dynamic> formDataMap = {
      "Id": id,
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
      "SectionId": sectionController.text.isEmpty
          ? taskDetailsModel!.data!.sectionId
          : sectionId,
      "PointId": pointController.text.isEmpty
          ? taskDetailsModel!.data!.pointId
          : pointId,
      "UserIds": selectedSupervisorIds ??
          taskDetailsModel?.data?.users?.map((user) => user.id ?? 0).toList() ??
          [],
      "Files": [],
      "CurrentReading": currentReadingController.text.isEmpty
          ? taskDetailsModel!.data!.currentReading
          : currentReading,
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

  AllOrganizationModel? allOrganizationModel;
  getOrganization() {
    emit(GetOrganizationLoadingState());
    DioHelper.getData(url: ApiConstants.organizationUrl).then((value) {
      allOrganizationModel = AllOrganizationModel.fromJson(value!.data);
      emit(GetOrganizationSuccessState(allOrganizationModel!));
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
