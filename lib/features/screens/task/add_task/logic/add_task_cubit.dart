import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/data/models/create_task_model.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/logic/add_task_state.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/point_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/section_list_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/all_tasks_model.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitialState());

  static AddTaskCubit get(context) => BlocProvider.of(context);
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController priorityIdController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController statusIdController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController currentlyReadingController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController pointIdController = TextEditingController();
  TextEditingController parentTaskController = TextEditingController();
  TextEditingController parentIdTaskController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController organizationIdController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController buildingIdController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController floorIdController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  TextEditingController sectionIdController = TextEditingController();

  final usersController = MultiSelectController<UserItem>();
  final formKey = GlobalKey<FormState>();

  bool isFormSubmitted = false;
  bool isPointCountable = false;

  List<int>? selectedUsersIds = [];
  CreateTaskModel? createTaskModel;
  addTask() async {
    emit(AddTaskLoadingState());
    List<MultipartFile> multipartFiles = await Future.wait(
      selectedFiles.map((file) async {
        return await MultipartFile.fromFile(
          file.path!,
          filename: file.name,
        );
      }),
    );

    Map<String, dynamic> formDataMap = {
      "Title": taskTitleController.text,
      "Description": descriptionController.text,
      "Priority": priorityIdController.text,
      "Status": statusIdController.text,
      "StartDate": startDateController.text,
      "EndDate": endDateController.text,
      "CurrentReading": currentlyReadingController.text,
      "StartTime": startTimeController.text,
      "EndTime": endTimeController.text,
      "PointId": pointIdController.text,
      "ParentId": parentIdTaskController.text,
      "UserIds": selectedUsersIds,
      "Files": multipartFiles,
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
  List<TaskData> taskData = [TaskData(title: 'No tasks available')];
  getAllTasks() {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {'CreatedBy': uId})
        .then((value) {
      allTasksModel = AllTasksModel.fromJson(value!.data);
      taskData =
          allTasksModel?.data?.data ?? [TaskData(title: 'No tasks available')];
      emit(GetAllTasksSuccessState(allTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
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

  OrganizationListModel? organizationModel;
  List<OrganizationItem> organizationItem = [
    OrganizationItem(name: 'No organizations')
  ];
  getOrganization() {
    emit(GetOrganizationLoadingState());
    DioHelper.getData(url: "organizations/pagination").then((value) {
      organizationModel = OrganizationListModel.fromJson(value!.data);
      organizationItem = organizationModel?.data?.data ??
          [OrganizationItem(name: 'No organizations')];
      emit(GetOrganizationSuccessState(organizationModel!));
    }).catchError((error) {
      emit(GetOrganizationErrorState(error.toString()));
    });
  }

  BuildingListModel? buildingModel;
  List<BuildingItem> buildingItem = [BuildingItem(name: 'No building')];
  getBuilding() {
    emit(GetBuildingLoadingState());
    DioHelper.getData(
        url: 'buildings/pagination',
        query: {'OrganizationId': organizationIdController.text}).then((value) {
      buildingModel = BuildingListModel.fromJson(value!.data);
      buildingItem =
          buildingModel?.data?.data ?? [BuildingItem(name: 'No building')];
      emit(GetBuildingSuccessState(buildingModel!));
    }).catchError((error) {
      emit(GetBuildingErrorState(error.toString()));
    });
  }

  FloorListModel? floorModel;
  List<FloorItem> floorItem = [FloorItem(name: 'No floors')];
  getFloor() {
    emit(GetFloorLoadingState());
    DioHelper.getData(
        url: 'floors/pagination',
        query: {'BuildingId': buildingIdController.text}).then((value) {
      floorModel = FloorListModel.fromJson(value!.data);
      floorItem = floorModel?.data?.data ?? [FloorItem(name: 'No floors')];
      emit(GetFloorSuccessState(floorModel!));
    }).catchError((error) {
      emit(GetFloorErrorState(error.toString()));
    });
  }

  SectionListModel? sectionModel;
  List<SectionItem> sectionItem = [SectionItem(name: 'No sections')];
  getSection() {
    emit(GetSectionLoadingState());
    DioHelper.getData(
        url: 'sections/pagination',
        query: {'FloorId': floorIdController.text}).then((value) {
      sectionModel = SectionListModel.fromJson(value!.data);
      sectionItem =
          sectionModel?.data?.data ?? [SectionItem(name: 'No sections')];
      emit(GetSectionSuccessState(sectionModel!));
    }).catchError((error) {
      emit(GetSectionErrorState(error.toString()));
    });
  }

  PointListModel? pointModel;
  List<PointItem> pointItem = [PointItem(name: 'No points')];
  getPoint() {
    emit(GetPointLoadingState());
    DioHelper.getData(
        url: 'points/pagination',
        query: {'SectionId': sectionIdController.text}).then((value) {
      pointModel = PointListModel.fromJson(value!.data);
      pointItem = pointModel?.data?.data ?? [PointItem(name: 'No points')];
      emit(GetPointSuccessState(pointModel!));
    }).catchError((error) {
      emit(GetPointErrorState(error.toString()));
    });
  }

  List<PlatformFile> selectedFiles = [];

  XFile? image;

  Future<void> pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'webp'],
    );

    if (result != null && result.files.isNotEmpty) {
      for (var file in result.files) {
        if (!selectedFiles.any((f) => f.path == file.path)) {
          selectedFiles.add(file);
        }
      }
      emit(FilesSelectedState(List.from(selectedFiles)));
    }
  }

  Future<void> cameraFile() async {
    final ImagePicker cameraPicker = ImagePicker();
    final XFile? selectedImage =
        await cameraPicker.pickImage(source: ImageSource.camera);

    if (selectedImage != null) {
      final file = File(selectedImage.path);
      final fileBytes = await file.readAsBytes();

      final platformFile = PlatformFile(
        name: selectedImage.name,
        path: selectedImage.path,
        size: fileBytes.length,
        bytes: fileBytes,
      );

      if (!selectedFiles.any((f) => f.path == platformFile.path)) {
        selectedFiles.add(platformFile);
        emit(FilesSelectedState(List.from(selectedFiles)));
      }
    }
  }

  void removeSelectedFile(int index) {
    selectedFiles.removeAt(index);
    emit(RemoveSelectedFileState());
  }

  final Map<String, int> priorityMap = {
    "High": 2,
    "Medium": 1,
    "Low": 0,
  };

  final List<Color> tasksColor = [
    Colors.red,
    Colors.orange,
    Colors.green,
  ];
}
