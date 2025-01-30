import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/all_organization_model.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/data/models/all_tasks_model.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/data/models/create_task_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/gallary_model.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/data/models/supervisor_model.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/logic/add_task_state.dart';

import '../../../integrations/data/models/building_model.dart';
import '../../../integrations/data/models/floor_model.dart';
import '../../../integrations/data/models/points_model.dart';
import 'package:image_picker/image_picker.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitialState());

  static AddTaskCubit get(context) => BlocProvider.of(context);
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
  final formKey = GlobalKey<FormState>();

  CreateTaskModel? createTaskModel;
  addTask(int priorityId, int? statusId, int? buildingId, int? floorId,
      int? pointId, List<int>? selectedSupervisorIds, int? parentId) async {
    emit(AddTaskLoadingState());
    Map<String, dynamic> formDataMap = {
      "ParentId": parentId,
      "Title": taskTitleController.text,
      "Description": descriptionController.text,
      "Priority": priorityId,
      "Status": statusId,
      "StartDate": startDateController.text,
      "EndDate": endDateController.text,
      "StartTime": startTimeController.text,
      "EndTime": endTimeController.text,
      "BuildingId": buildingId,
      "FloorId": floorId,
      "PointId": pointId,
      "CreatedBy": uId,
      "UsersIds": selectedSupervisorIds,
      "Files": null,
    };

    FormData formData = FormData.fromMap(formDataMap);
    try {
      final response = await DioHelper.postData2(
          url: ApiConstants.createTaskUrl, data: formData);
      createTaskModel = CreateTaskModel.fromJson(response!.data);
      emit(AddTaskSuccessState(createTaskModel!));
    } catch (error) {
      emit(AddTaskErrorState(error.toString()));
    }
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
