import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/gallary_model.dart';
import 'package:smart_cleaning_application/features/screens/task/edit_task/data/models/edit_task_model.dart';
import 'package:smart_cleaning_application/features/screens/task/edit_task/logic/edit_task_state.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/all_tasks_model.dart';
import 'package:smart_cleaning_application/features/screens/task/view_task/data/model/task_details.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/point_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/section_list_model.dart';

class EditTaskCubit extends Cubit<EditTaskState> {
  EditTaskCubit() : super(EditTaskInitialState());

  static EditTaskCubit get(context) => BlocProvider.of(context);
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

  bool isPointCountable = false;
  int? isSelected;
  String? selectedPriority;

  List<int>? selectedUsersIds = [];
  EditTaskModel? editTaskModel;
  editTask(int id, String? image) async {
    emit(EditTaskLoadingState());
    MultipartFile? imageFile;
    if (image != null && image.isNotEmpty) {
      imageFile = await MultipartFile.fromFile(
        image,
        filename: image.split('/').last,
      );
    }
    Map<String, dynamic> formDataMap = {
      "Id": id,
      "Title": taskTitleController.text.isEmpty
          ? taskDetailsModel!.data!.title
          : taskTitleController.text,
      "Description": descriptionController.text.isEmpty
          ? taskDetailsModel!.data!.description
          : descriptionController.text,
      "Priority": priorityController.text.isEmpty
          ? taskDetailsModel!.data!.priority
          : priorityIdController.text,
      "Status": statusController.text.isEmpty
          ? taskDetailsModel!.data!.status
          : statusIdController.text,
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
      "CurrentReading": currentlyReadingController.text.isEmpty
          ? taskDetailsModel!.data!.currentReading
          : double.parse(currentlyReadingController.text),
      "PointId": pointController.text.isEmpty
          ? taskDetailsModel!.data!.pointId
          : pointIdController.text,
      "ParentId": parentTaskController.text.isEmpty
          ? taskDetailsModel!.data!.parentId
          : parentIdTaskController.text,
      "UserIds": selectedUsersIds ??
          taskDetailsModel?.data?.users?.map((user) => user.id ?? 0).toList() ??
          [],
      "Files": [
        imageFile ?? taskDetailsModel!.data!.files,
      ],
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
  List<TaskData> taskData = [TaskData(title: 'No tasks available')];
  getAllTasks() {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination").then((value) {
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

  final List<String> priority = ["Low", "Medium", "High"];
  final List<Color> tasksColor = [
    Colors.green,
    Colors.orange,
    Colors.red,
  ];
}
