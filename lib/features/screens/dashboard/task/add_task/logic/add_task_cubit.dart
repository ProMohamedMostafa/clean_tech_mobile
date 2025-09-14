import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/add_task/data/models/create_task_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/add_task/data/models/users_shift_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/add_task/logic/add_task_state.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/point_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/section_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/edit_task/data/models/organization_basic_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/edit_task/data/models/tasks_basic_model.dart';

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

  final allShiftsController = MultiSelectController<ShiftItem>();
  final usersController = MultiSelectController<UserShiftData>();
  final formKey = GlobalKey<FormState>();

  bool isFormSubmitted = false;
  bool isPointCountable = false;

  List<int> selectedShiftsIds = [];
  List<int> selectedUsersIds = [];
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
      "ShiftId": selectedShiftsIds.isNotEmpty ? selectedShiftsIds.first : null,
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

  TasksBasicModel? tasksBasicModel;
  getAllTasks() {
    emit(GetAllTasksLoadingState());

    DioHelper.getData(url: 'tasks/basic').then((value) {
      tasksBasicModel = TasksBasicModel.fromJson(value!.data);

      emit(GetAllTasksSuccessState(tasksBasicModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }

  UsersShiftModel? usersShiftModel;
  List<UserShiftData> userShiftData = [
    UserShiftData(userName: 'No shifts available')
  ];

  getAllUsers() {
    emit(AllUsersLoadingState());
    DioHelper.getData(url: "users/shift/${selectedShiftsIds.first}")
        .then((value) {
      usersShiftModel = UsersShiftModel.fromJson(value!.data);
      userShiftData = usersShiftModel?.data ??
          [UserShiftData(userName: 'No shifts available')];
      initializeUserPointControllers();
      emit(AllUsersSuccessState(usersShiftModel!));
    }).catchError((error) {
      emit(AllUsersErrorState(error.toString()));
    });
  }

  OrganizationBasicModel? organizationBasicModel;
  getOrganization() {
    emit(GetOrganizationLoadingState());
    DioHelper.getData(url: "organizations/basic").then((value) {
      organizationBasicModel = OrganizationBasicModel.fromJson(value!.data);

      emit(GetOrganizationSuccessState(organizationBasicModel!));
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

  ShiftModel? shiftModel;
  List<ShiftItem> shiftData = [ShiftItem(name: 'No shifts available')];
  getShifts() {
    emit(ShiftLoadingState());
    DioHelper.getData(
        url: ApiConstants.allShiftsUrl,
        query: {'PointId': pointIdController.text}).then((value) {
      shiftModel = ShiftModel.fromJson(value!.data);
      shiftData =
          shiftModel?.data?.data ?? [ShiftItem(name: 'No shifts available')];
      initializePointControllers();
      emit(ShiftSuccessState(shiftModel!));
    }).catchError((error) {
      emit(ShiftErrorState(error.toString()));
    });
  }

  void initializePointControllers() {
    if (pointModel != null && shiftModel != null) {
      final shifts = shiftModel!.data!.data!
          .map((shift) => DropdownItem(
                label: shift.name ?? '',
                value: ShiftItem(
                  id: shift.id,
                  name: shift.name,
                  startDate: shift.startDate,
                  endDate: shift.endDate,
                  startTime: shift.startTime,
                  endTime: shift.endTime,
                ),
              ))
          .toList();

      allShiftsController.setItems(shifts);

      final assignedShifts = pointModel!.data?.data;

      selectedShiftsIds = assignedShifts
              ?.where((shift) => shift.id != null)
              .map((shift) => shift.id!)
              .toList() ??
          [];

      allShiftsController.selectWhere(
        (item) => selectedShiftsIds.contains(item.value.id),
      );
    }
  }

  void initializeUserPointControllers() {
    if (usersShiftModel != null) {
      final users = usersShiftModel!.data!
          .map((user) => DropdownItem(
                label: user.userName ?? '',
                value: UserShiftData(
                  id: user.id,
                  userName: user.userName,
                ),
              ))
          .toList();

      usersController.setItems(users);

      selectedUsersIds = usersShiftModel!.data!
          .where((users) => users.id != null)
          .map((users) => users.id!)
          .toList();

      usersController.selectWhere(
        (item) => selectedUsersIds.contains(item.value.id),
      );
    }
  }
}
