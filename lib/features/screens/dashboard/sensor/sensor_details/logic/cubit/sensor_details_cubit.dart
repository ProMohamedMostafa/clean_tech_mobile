import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/sensor/sensor_details/data/model/sensor_details_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/sensor/sensor_details/data/model/delete_sensor_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/task_management/data/models/all_tasks_model.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

part 'sensor_details_state.dart';

class SensorDetailsCubit extends Cubit<SensorDetailsState> {
  SensorDetailsCubit() : super(SensorDetailsInitial());

  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();

  SensorDetailsModel? sensorDetailsModel;
  getSensorDetails(int? id) {
    emit(SensorDetailsLoadingState());
    DioHelper.getData(url: 'devices/$id').then((value) {
      sensorDetailsModel = SensorDetailsModel.fromJson(value!.data);
      checkKeyMatch();
      emit(SensorDetailsSuccessState(sensorDetailsModel!));
    }).catchError((error) {
      emit(SensorDetailsErrorState(error.toString()));
    });
  }

  DeletedSensorModel? deletedSensorModel;
  deleteSensor(int id) {
    emit(DeleteSensorLoadingState());
    DioHelper.postData(url: 'devices/delete/$id').then((value) {
      deletedSensorModel = DeletedSensorModel.fromJson(value!.data);
      emit(DeleteSensorSuccessState(deletedSensorModel!));
    }).catchError((error) {
      emit(DeleteSensorErrorState(error.toString()));
    });
  }

  ScrollController scrollController = ScrollController();
  int currentPage = 1;

  AllTasksModel? allTasksModel;
  getAllTasks(int deviceId) {
    emit(GetAllTasksLoadingState());

    final Map<String, dynamic> query = {
      'PageNumber': currentPage,
      'PageSize': 10,
      'DeviceId': deviceId,
    };

    final status = statusFilterList[selectedTreeIndex];
    if (status != null) {
      query['Status'] = status;
    }

    DioHelper.getData(url: "tasks/pagination", query: query).then((value) {
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

  initialize(int deviceId) {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          currentPage++;
          getAllTasks(deviceId);
        }
      });
    getAllTasks(deviceId);
  }

  Future<void> refreshTasks(int deviceId) async {
    currentPage = 1;
    allTasksModel = null;
    emit(GetAllTasksLoadingState());
    await getAllTasks(deviceId);
  }

  List<String?> statusFilterList = [
    null, // index 0: All Tasks (no status filter)
    "Pending", // index 1
    "InProgress", // index 2
    "NotApproval", // index 3
    "Completed", // index 4
    "Rejected", // index 5
    "NotResolved", // index 6
    "Overdue", // index 7
  ];

  bool descTextShowFlag = false;
  void toggleDescription() {
    descTextShowFlag = !descTextShowFlag;
    emit(SensorToggleDescription());
  }

  bool isSensorEnabled = false;
  void toggleSensor() {
    isSensorEnabled = !isSensorEnabled;
    emit(SensorToggleSensor());
  }

  int selectedIndex = 0;

  void updateSelectedIndex(int index) {
    selectedIndex = index;
    emit(SensorDetailsStateUpdated());
  }

  String getLastReadText(DateTime? lastSeenAt) {
    if (lastSeenAt == null) return 'N/A';

    final now = DateTime.now();
    final difference = now.difference(lastSeenAt);

    if (difference.inDays >= 1) {
      return '${difference.inDays} Day${difference.inDays > 1 ? 's' : ''}';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} Hr';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} Min';
    } else {
      return 'Just now';
    }
  }

  int selectedTreeIndex = 0;

  void updateSelectedTreeIndex(int index, int deviceId) {
    selectedTreeIndex = index;
    currentPage = 1;
    allTasksModel = null;
    emit(SensorDetailsStateUpdated());
    getAllTasks(deviceId);
  }

  List<String> getTapList(BuildContext context) {
    return [
      S.of(context).allTasks,
      S.of(context).pendingTask,
      S.of(context).inProgressTask,
      S.of(context).notApproval,
      S.of(context).completed,
      S.of(context).rejected,
      S.of(context).notResolvedTask,
      S.of(context).overdueTask,
    ];
  }

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

  String formatTime(String? timeString) {
    if (timeString == null) return "--:--";
    try {
      final parsed = DateTime.parse("2023-01-01T$timeString");
      return DateFormat.Hm().format(parsed);
    } catch (e) {
      return "--:--";
    }
  }

  deletelimit(int id) {
    emit(DeleteLimitLoadingState());
    DioHelper.deleteData(url: 'devices/limits/delete/$id').then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      sensorDetailsModel?.data?.limit = null;
      minController.clear();
      maxController.clear();
      emit(DeleteLimitSuccessState(message));
    }).catchError((error) {
      emit(DeleteLimitErrorState(error.toString()));
    });
  }

  void checkKeyMatch() {
    final containerKey = sensorDetailsModel?.data?.limit?.key;
    if (containerKey != null) {
      final matchingIndex = sensorDetailsModel?.data?.data?.indexWhere(
        (item) => item.key == containerKey,
      );

      if (matchingIndex != null && matchingIndex != -1) {
        if (matchingIndex != selectedIndex) {
          updateSelectedIndex(matchingIndex);
        }
      }
    } else if (sensorDetailsModel?.data?.data?.isNotEmpty ?? false) {
      updateSelectedIndex(0);
    }
  }

  createLimitSensor(int? id) {
    emit(CreateLimitSensorLoadingState());
    DioHelper.postData(url: 'devices/limits/create', data: {
      "deviceId": id,
      "key": sensorDetailsModel?.data?.data?[selectedIndex].key,
      "min": minController.text,
      "max": maxController.text,
    }).then((value) {
      final message = value?.data['message'] ?? "Create successfully";

      emit(CreateLimitSensorSuccessState(message));
    }).catchError((error) {
      emit(CreateLimitSensorErrorState(error.toString()));
    });
  }

  editLimitSensor(int? id) {
    emit(EditLimitSensorLoadingState());
    DioHelper.putData(url: 'devices/limits/edit', data: {
      "deviceId": id,
      "key": sensorDetailsModel!.data!.limit!.key,
      "min": minController.text.isEmpty
          ? sensorDetailsModel!.data!.limit!.min
          : minController.text,
      "max": maxController.text.isEmpty
          ? sensorDetailsModel!.data!.limit!.max
          : maxController.text,
    }).then((value) {
      final message = value?.data['message'] ?? "edit successfully";

      emit(EditLimitSensorSuccessState(message));
    }).catchError((error) {
      emit(EditLimitSensorErrorState(error.toString()));
    });
  }
}
