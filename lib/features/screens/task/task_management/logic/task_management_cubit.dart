import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/widgets/filter/data/model/filter_dialog_data_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/all_tasks_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/delete_task_list_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/delete_task_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/logic/task_management_state.dart';

class TaskManagementCubit extends Cubit<TaskManagementState> {
  TaskManagementCubit() : super(TaskManagementInitialState());

  static TaskManagementCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  ScrollController horizontalScrollController = ScrollController();
  DateTime selectedDate = DateTime.now();
  int selectedIndex = 0;
  int currentPage = 1;

  FilterDialogDataModel? filterModel;
  AllTasksModel? allTasksModel;
  getAllTasks() {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'PageNumber': currentPage,
      'PageSize': 15,
      'SearchQuery': searchController.text,
      'Status': filterModel?.taskStatusId ??
          (selectedIndex == 0 ? null : selectedIndex - 1),
      'Priority': filterModel?.priorityId,
      'CreatedBy': filterModel?.createdBy,
      'AssignTo': filterModel?.assignTo,
      'AreaId': filterModel?.areaId,
      'CityId': filterModel?.cityId,
      'OrganizationId': filterModel?.organizationId,
      'BuildingId': filterModel?.buildingId,
      'FloorId': filterModel?.floorId,
      'SectionId': filterModel?.sectionId,
      'PointId': filterModel?.pointId,
      'ProviderId': filterModel?.providerId,
      'StartDate': DateFormat('yyyy-MM-dd', 'en')
          .format(filterModel?.startDate ?? selectedDate),
      'EndDate': filterModel?.endDate != null
          ? DateFormat('yyyy-MM-dd', 'en').format(filterModel!.endDate!)
          : null,
      'StartTime': filterModel?.startTime,
      'EndTime': filterModel?.endTime,
      'DeviceId': filterModel?.deviceId
    }).then((value) {
      final newTask = AllTasksModel.fromJson(value!.data);

      if (currentPage == 1 || allTasksModel == null) {
        allTasksModel = newTask;
      } else {
        allTasksModel?.data?.data?.addAll(newTask.data?.data ?? []);
        allTasksModel?.data?.currentPage = newTask.data?.currentPage;
        allTasksModel?.data?.totalPages = newTask.data?.totalPages;
      }
      emit(GetAllTasksSuccessState(allTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }
  Future<void> refreshTasks({int? roleId}) async {
    currentPage = 1;
    allTasksModel = null;
    deleteTaskListModel = null;
    emit(GetAllTasksLoadingState());
    emit(TaskDeleteListLoadingState());
    await getAllTasks();
    await getAllDeletedTasks();
  }

  initialize() {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          currentPage++;
          getAllTasks();
        }
      });
    getAllTasks();
    getAllDeletedTasks();
  }

  void changeTap(int index) {
    selectedIndex = index;

    if (selectedIndex == tapList.length - 1) {
      // Last tab (Deleted) - show deleted tasks
      if (deleteTaskListModel == null) {
        getAllDeletedTasks();
      } else {
        emit(TaskDeleteListSuccessState(deleteTaskListModel!));
      }
    } else {
      // Other tabs - set status based on index

      selectedIndex == 0 ? null : selectedIndex - 1;
      currentPage = 1;
      allTasksModel = null;
      getAllTasks();
    }
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

  DeleteTaskModel? deleteTaskModel;
  List<TaskData> deletedTasks = [];
  taskDelete(int id) {
    emit(TaskDeleteLoadingState());
    DioHelper.postData(url: 'tasks/delete/$id').then((value) {
      deleteTaskModel = DeleteTaskModel.fromJson(value!.data);
      final deletedTask = allTasksModel?.data?.data?.firstWhere(
        (user) => user.id == id,
      );

      if (deletedTask != null) {
        // Remove from main list
        allTasksModel?.data?.data?.removeWhere((user) => user.id == id);

        // Add to deleted list
        deletedTasks.insert(0, deletedTask);

        if (currentPage == 1) {
          allTasksModel = null;
          getAllTasks();
        }
      }
      emit(TaskDeleteSuccessState(deleteTaskModel!));
    }).catchError((error) {
      emit(TaskDeleteErrorState(error.toString()));
    });
  }

  restoreDeletedTask(int id) {
    emit(RestoreTaskLoadingState());
    DioHelper.postData(url: 'tasks/restore/$id').then((value) {
      final message = value?.data['message'] ?? "restored successfully";

      final restoredData = deleteTaskListModel?.data?.firstWhere(
        (data) => data.id == id,
      );

      if (restoredData != null) {
        // Remove from deleted list
        deleteTaskListModel?.data?.removeWhere((data) => data.id == id);

        // Initialize users list if null
        allTasksModel?.data?.data ??= [];

        // Convert to User object
        final restoredUser = TaskData.fromJson(restoredData.toJson());

        // Find the correct position to insert (sorted by ID)
        int insertIndex = allTasksModel!.data!.data!
            .indexWhere((user) => user.id! > restoredUser.id!);

        // If not found, add to end
        if (insertIndex == -1) insertIndex = allTasksModel!.data!.data!.length;

        // Insert at correct position
        allTasksModel?.data?.data?.insert(insertIndex, restoredUser);

        // Update pagination metadata
        allTasksModel?.data?.totalCount =
            (allTasksModel?.data?.totalCount ?? 0) + 1;
        allTasksModel?.data?.totalPages =
            ((allTasksModel?.data?.totalCount ?? 0) /
                    (allTasksModel?.data?.pageSize ?? 10))
                .ceil();
      }

      emit(RestoreTaskSuccessState(message));
    }).catchError((error) {
      emit(RestoreTaskErrorState(error.toString()));
    });
  }

  forcedDeletedUser(int id) {
    emit(ForceDeleteTaskLoadingState());
    DioHelper.deleteData(url: 'tasks/forcedelete/$id').then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(ForceDeleteTaskSuccessState(message));
    }).catchError((error) {
      emit(ForceDeleteTaskErrorState(error.toString()));
    });
  }

  List<String> tapList = [
    'All',
    'Pending',
    'In Progress',
    'Not Approval',
    'Completed',
    'Rejected',
    'Not Resolved',
    'Overdue',
    'Deleted'
  ];

  Color getPriorityColor(String? priorityValue) {
    final List<String> priorities = ["High", "Medium", "Low"];
    final List<Color> colors = [
      Colors.red,
      Colors.orange,
      Colors.green,
    ];

    if (priorityValue != null && priorities.contains(priorityValue)) {
      return colors[priorities.indexOf(priorityValue)];
    } else {
      return Colors.black;
    }
  }
}
