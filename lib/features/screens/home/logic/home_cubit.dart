import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/activity/data/model/activities_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/edit_task/data/models/section_basic_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/edit_task/data/models/users_basic_model.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/attendance_status.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/attendance_status_model.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/completetion_task.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/material_count_model.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/sensor_chart_model.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/shifts_count_model.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/stock_total_price_model.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/task_chart_status_model.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/task_status_model.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/total_stock.dart';
import 'package:smart_cleaning_application/features/screens/home/data/model/users_count_model.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_state.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/notification/data/model/notification_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/provider/provider_management/data/models/providers_model.dart';
import 'package:smart_cleaning_application/features/screens/setting/settings/data/model/profile_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  TextEditingController sectionController = TextEditingController();
  TextEditingController sectionIdController = TextEditingController();
  void initializeHome() {
    if (role == 'Admin') {
      getUserDetails();
      getUnReadNotification();
      getUserStatus();
      getMyActivities();
      getTeamActivities();
      getStockTotalPriceCount();
      getMaterialCount();
      getUsersCount();
      getAttendanceStatus();
      getShiftsCount();
      getTaskData();
      getChartTaskData();
      getQuantity();
      initialize();
      getCompleteiontask();
      getAllUsers();
    }
    if (role == 'Manager' || role == 'Supervisor') {
      getUserDetails();
      getUnReadNotification();
      getUserStatus();
      getMyActivities();
      getTeamActivities();
      getUsersCount();
      getAttendanceStatus();
      getTaskData();
      getChartTaskData();
      getCompleteiontask();
      getAllUsers();
    }
    if (role == 'Cleaner') {
      getUserDetails();
      getUnReadNotification();
      getUserStatus();
      getAttendanceStatus();
      getTaskData();
      getChartTaskData();
      getCompleteiontask();
    }
  }

  clockInOut() {
    emit(ClockInOutLoadingState());
    DioHelper.postData(url: 'attendance/clock').then((value) {
      final message = value?.data['message'] ?? "Operation successfully";

      attendanceStatusModel = AttendanceStatusModel.fromJson(value!.data);
      getUserStatus();

      emit(ClockInOutSuccessState(message));
    }).catchError((error) {
      emit(ClockInOutErrorState(error.toString()));
    });
  }

  String formatDuration(String duration) {
    try {
      final parts = duration.split(':');

      final hours = int.parse(parts[0]);
      final minutes = int.parse(parts[1]);
      final seconds = int.parse(parts[2].split('.')[0]);

      final formattedHours = hours.toString().padLeft(2, '0');
      final formattedMinutes = minutes.toString().padLeft(2, '0');
      final formattedSeconds = seconds.toString().padLeft(2, '0');

      return '$formattedHours:$formattedMinutes:$formattedSeconds';
    } catch (e) {
      return '--:--:--';
    }
  }

  AttendanceStatusModel? attendanceStatusModel;
  getUserStatus() {
    emit(UserStatusLoadingState());
    DioHelper.getData(url: 'attendance/status').then((value) {
      attendanceStatusModel = AttendanceStatusModel.fromJson(value!.data);
      emit(UserStatusSuccessState(attendanceStatusModel!));
    }).catchError((error) {
      emit(UserStatusErrorState(error.toString()));
    });
  }

  NotificationModel? notificationModel;
  void getUnReadNotification() {
    emit(UnReadNotificationLoadingState());
    DioHelper.getData(url: 'notifications', query: {'IsRead': false})
        .then((value) {
      notificationModel = NotificationModel.fromJson(value!.data);
      emit(UnReadNotificationSuccessState(notificationModel!));
    }).catchError((error) {
      emit(UnReadNotificationErrorState(error.toString()));
    });
  }

  // Home App Bar
  ProfileModel? profileModel;
  getUserDetails() {
    emit(UserDetailsLoadingState());
    DioHelper.getData(url: 'auth/profile').then((value) {
      profileModel = ProfileModel.fromJson(value!.data);
      emit(UserDetailsSuccessState(profileModel!));
    }).catchError((error) {
      emit(UserDetailsErrorState(error.toString()));
    });
  }

  // Home cards
  String formatTimeDifference(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else {
      return DateFormat('MMM d, y').format(time);
    }
  }

  int? _extractYearFromRange(String range) {
    final match = RegExp(r'\d{4}$').firstMatch(range);
    return match != null ? int.tryParse(match.group(0)!) : null;
  }

  MaterialCountModel? materialCountModel;
  getMaterialCount() {
    emit(MaterialCountLoadingState());
    DioHelper.getData(url: 'materials/under/count').then((value) {
      materialCountModel = MaterialCountModel.fromJson(value!.data);
      emit(MaterialCountSuccessState(materialCountModel!));
    }).catchError((error) {
      emit(MaterialCountErrorState(error.toString()));
    });
  }

  StockTotalPriceModel? stockTotalPriceModel;
  int? selectedMonth;
  int? selectedYear;

  void getStockTotalPriceCount({int? month, int? year}) {
    selectedMonth = month;
    selectedYear = year;
    emit(StockTotalPriceLoadingState());
    DioHelper.getData(
        url: 'stock/price/total',
        query: {'Month': month, 'Year': year}).then((value) {
      stockTotalPriceModel = StockTotalPriceModel.fromJson(value!.data);
      emit(StockTotalPriceSuccessState(stockTotalPriceModel!));
    }).catchError((error) {
      emit(StockTotalPriceErrorState(error.toString()));
    });
  }

  AttendanceStatus? attendanceStatus;
  getAttendanceStatus() {
    emit(AttendanceStatusLoadingState());
    DioHelper.getData(url: 'attendance/status/count').then((value) {
      attendanceStatus = AttendanceStatus.fromJson(value!.data);
      emit(AttendanceStatusSuccessState(attendanceStatus!));
    }).catchError((error) {
      emit(AttendanceStatusErrorState(error.toString()));
    });
  }

  UsersCountModel? usersCountModel;
  getUsersCount() {
    emit(UsersCountLoadingState());
    DioHelper.getData(url: 'users/count').then((value) {
      usersCountModel = UsersCountModel.fromJson(value!.data);
      emit(UsersCountSuccessState(usersCountModel!));
    }).catchError((error) {
      emit(UsersCountErrorState(error.toString()));
    });
  }

  ShiftsCountModel? shiftsCountModel;
  getShiftsCount() {
    emit(ShiftsCountLoadingState());
    DioHelper.getData(url: 'shifts/active/count').then((value) {
      shiftsCountModel = ShiftsCountModel.fromJson(value!.data);
      emit(ShiftsCountSuccessState(shiftsCountModel!));
    }).catchError((error) {
      emit(ShiftsCountErrorState(error.toString()));
    });
  }

  // Show activity part
  bool down = false;
  changeVisiability() {
    down = !down;
    emit(ChangeVisiabiltyState());
  }

  int selectedIndex = 0;
  String getRouteName(String? module, int? moduleId) {
    if (moduleId == null) return '';
    switch (module) {
      case 'User':
        return Routes.userDetailsScreen;
      case 'Area':
      case 'City':
      case 'Organization':
      case 'Building':
      case 'Floor':
      case 'Section':
      case 'Point':
        return Routes.workLocationDetailsScreen;
      case 'Task':
        return Routes.taskDetailsScreen;
      case 'Shift':
        return Routes.shiftDetailsScreen;
      case 'Leave':
        return Routes.leavesDetailsScreen;
      case 'Material':
        return Routes.materialDetailsScreen;
      case 'Device':
      case 'DeviceLimit':
        return Routes.sensorDetailsScreen;
      default:
        return '';
    }
  }

  int getWorkLocationIndex(String? module) {
    switch (module) {
      case 'Area':
        return 0;
      case 'City':
        return 1;
      case 'Organization':
        return 2;
      case 'Building':
        return 3;
      case 'Floor':
        return 4;
      case 'Section':
        return 5;
      case 'Point':
        return 6;
      default:
        return 0;
    }
  }

  Color getActionColor(String actionType) {
    switch (actionType) {
      case 'Create':
        return Colors.green;
      case 'Edit':
        return Colors.orange;
      case 'Delete':
        return Colors.red;
      case 'Restore':
        return Colors.teal;
      case 'ForceDelete':
        return Colors.deepOrange;
      case 'Login':
        return Colors.blue;
      case 'Logout':
        return Colors.indigo;
      case 'ClockIn':
      case 'ClockOut':
        return Colors.cyan;
      case 'ChangePassword':
        return Colors.brown;
      case 'EditProfile':
        return Colors.purple;
      case 'Assign':
        return Colors.lightGreen;
      case 'RemoveAssign':
        return Colors.pink;
      case 'StockIn':
        return Colors.blueGrey;
      case 'StockOut':
        return Colors.deepPurple;
      case 'ChangeStatus':
        return Colors.lime;
      case 'Comment':
        return Colors.amber;
      case 'EditSetting':
        return Colors.lightBlue;
      case 'Reminder':
        return Colors.deepOrangeAccent;
      case 'Archive':
      case 'UnArchive':
        return Colors.grey;
      case 'ReadData':
        return Colors.lightBlueAccent;
      case 'AssignShift':
      case 'RemoveShift':
        return Colors.cyanAccent;
      case 'AssignTag':
      case 'RemoveTag':
        return Colors.purpleAccent;
      default:
        return Colors.black;
    }
  }

  ActivitiesModel? myActivities;

  Future<void> getMyActivities() async {
    emit(ActivityLoadingState());
    try {
      final value = await DioHelper.getData(
        url: "logs",
        query: {'PageNumber': 1, 'PageSize': 20, 'History': true},
      );
      myActivities = ActivitiesModel.fromJson(value!.data);
      emit(ActivitySuccessState(myActivities!));
    } catch (error) {
      emit(ActivityErrorState(error.toString()));
    }
  }

  ActivitiesModel? teamActivities;
  Future<void> getTeamActivities() async {
    emit(ActivityTeamLoadingState());
    try {
      final value = await DioHelper.getData(
        url: "logs",
        query: {'PageNumber': 1, 'PageSize': 20, 'History': false},
      );
      teamActivities = ActivitiesModel.fromJson(value!.data);
      emit(ActivityTeamSuccessState(teamActivities!));
    } catch (error) {
      emit(ActivityTeamErrorState(error.toString()));
    }
  }

  void changeTap(int index) {
    selectedIndex = index;

    if (index == 0) {
      if (myActivities != null) {
        emit(ActivityLoadingState());
        emit(ActivitySuccessState(myActivities!));
      } else {
        getMyActivities();
      }
    } else {
      if (teamActivities != null) {
        emit(ActivityTeamLoadingState());
        emit(ActivityTeamSuccessState(teamActivities!));
      } else {
        getTeamActivities();
      }
    }
  }

  // sensor part

  SensorChartModel? sensorChartModel;
  getChartSensorData({int? month, int? year}) {
    emit(SensorChartLoadingState());
    DioHelper.getData(url: 'devices/completion/tasks', query: {
      'SectionId': sectionIdController.text,
      'Year': year,
      'Month': month,
    }).then((value) {
      sensorChartModel = SensorChartModel.fromJson(value!.data);
      emit(SensorChartSuccessState(sensorChartModel!));
    }).catchError((error) {
      emit(SensorChartErrorState(error.toString()));
    });
  }

  List<(String, String)> sectionItems = [];
  String? selectedSectionId;
  SectionBasicModel? sectionBasicModel;
  String? selectedSectionName;
  getSection() {
    emit(GetSectionLoadingState());
    DioHelper.getData(url: "sections/basic", query: {'HasDevices': true})
        .then((value) {
      sectionBasicModel = SectionBasicModel.fromJson(value!.data);
      sectionItems = sectionBasicModel?.data
              ?.map(
                (e) => (e.id.toString(), e.name ?? "Unknown"),
              )
              .toList() ??
          [];
      if (sectionItems.isNotEmpty) {
        selectedSectionId = sectionItems.first.$1;
      }
      emit(GetSectionSuccessState(sectionBasicModel!));
    }).catchError((error) {
      emit(GetSectionErrorState(error.toString()));
    });
  }

  //Stock Part
  String? selectedProviderName;
  String selectedChartTypeProvider = 'Line';
  String selectedDateRangeProvider = '${DateTime.now().year}';

  TotalStockModel? totalStockModel;
  getQuantity({int? year, providerId}) {
    emit(TotalStockLoadingState());
    DioHelper.getData(url: 'stock/quantity/sum', query: {
      'Year': year,
      'ProviderId': providerId,
    }).then((value) {
      totalStockModel = TotalStockModel.fromJson(value!.data);
      emit(TotalStockSuccessState(totalStockModel!));
    }).catchError((error) {
      emit(TotalStockErrorState(error.toString()));
    });
  }

  ProvidersModel? providersModel;
  int currentPage = 1;
  ScrollController providerScrollController = ScrollController();

  getProviders() {
    emit(AllProvidersLoadingState());
    DioHelper.getData(
        url: ApiConstants.allProvidersUrl,
        query: {'PageNumber': currentPage, 'PageSize': 10}).then((value) {
      final newProviders = ProvidersModel.fromJson(value!.data);

      if (currentPage == 1 || providersModel == null) {
        providersModel = newProviders;
      } else {
        providersModel?.data?.data?.addAll(newProviders.data?.data ?? []);
        providersModel?.data?.currentPage = newProviders.data?.currentPage;
        providersModel?.data?.totalPages = newProviders.data?.totalPages;
      }
      emit(AllProvidersSuccessState(providersModel!));
    }).catchError((error) {
      emit(AllProvidersErrorState(error.toString()));
    });
  }

  void initialize() {
    providerScrollController = ScrollController()
      ..addListener(() {
        if (providerScrollController.position.pixels ==
            providerScrollController.position.maxScrollExtent) {
          currentPage++;
          getProviders();
        }
      });
    getProviders();
  }

  void changeChartTypeStock(String type) {
    selectedChartTypeProvider = type;
    emit(ChangeChartTypeStockState());
  }

  void changeDateRangeProvider(String range) {
    selectedDateRangeProvider = range;
    emit(ChangeChartTypeStockState());
    final selectedYear = _extractYearFromRange(range);
    final providerId = selectedProviderName != 'All Providers'
        ? providersModel?.data?.data
            ?.firstWhere((p) => p.name == selectedProviderName)
            .id
        : null;

    getQuantity(year: selectedYear, providerId: providerId);
  }

  void changeSelectedProvider(int providerId) {
    if (providerId == 0) {
      selectedProviderName = 'All Providers';
    } else {
      final provider =
          providersModel?.data?.data?.firstWhere((p) => p.id == providerId);
      selectedProviderName = provider?.name ?? 'All Providers';
    }

    emit(ChangeProviderState());
    final selectedYear = _extractYearFromRange(selectedDateRangeProvider);
    getQuantity(year: selectedYear, providerId: providerId);
  }

  // completetion task part
  String? selectedUserName;
  String selectedChartTypeCompleteTask = 'Line';
  String selectedDateRangeCompleteTask = '${DateTime.now().year}';

  CompletetionTaskModel? completetionTaskModel;
  getCompleteiontask({int? year, userId}) {
    emit(CompletetionTaskLoadingState());
    DioHelper.getData(url: 'tasks/completion', query: {
      'Year': year,
      'UserId': userId,
    }).then((value) {
      completetionTaskModel = CompletetionTaskModel.fromJson(value!.data);
      emit(CompletetionTaskSuccessState(completetionTaskModel!));
    }).catchError((error) {
      emit(CompletetionTaskErrorState(error.toString()));
    });
  }

  int currentPageUser = 1;
  ScrollController userScrollController = ScrollController();
  UsersBasicModel? usersBasicModel;
  getAllUsers() {
    emit(AllUsersLoadingState());
    DioHelper.getData(url: "users/basic").then((value) {
      usersBasicModel = UsersBasicModel.fromJson(value!.data);

      emit(AllUsersSuccessState(usersBasicModel!));
    }).catchError((error) {
      emit(AllUsersErrorState(error.toString()));
    });
  }

  void changeChartTypeCompleteTask(String type) {
    selectedChartTypeCompleteTask = type;
    emit(ChangeChartTypeCompleteTaskState());
  }

  void changeDateRangeUser(String range) {
    selectedDateRangeCompleteTask = range;
    emit(ChangeChartTypeCompleteTaskState());
    final selectedYear = _extractYearFromRange(range);
    final userId = selectedUserName != 'All Users'
        ? usersBasicModel?.data
            ?.firstWhere((u) => u.userName == selectedUserName)
            .id
        : null;

    getCompleteiontask(year: selectedYear, userId: userId);
  }

  void changeSelectedUser(int userId) {
    if (userId == 0) {
      selectedUserName = 'All Users';
    } else {
      final user = usersBasicModel?.data?.firstWhere((p) => p.id == userId);
      selectedUserName = user?.userName ?? 'All Users';
    }

    emit(ChangeUserState());
    final selectedYear = _extractYearFromRange(selectedDateRangeCompleteTask);
    getCompleteiontask(year: selectedYear, userId: userId);
  }

  // task part
  String? selectedUserNametask;
  String selectedChartTypeTask = 'Line';
  String selectedDateRangeTask = '..... - ..... ${DateTime.now().year}';

  TaskChartStatusModel? taskChartStatusModel;
  getChartTaskData(
      {int? userId, String? startDate, String? endDate, int? priority}) {
    emit(TaskChartStatusLoadingState());
    DioHelper.getData(url: 'tasks/status', query: {
      'UserId': userId,
      'StartDate': startDate,
      'EndDate': endDate,
      'Priority': priority
    }).then((value) {
      taskChartStatusModel = TaskChartStatusModel.fromJson(value!.data);
      emit(TaskChartStatusSuccessState(taskChartStatusModel!));
    }).catchError((error) {
      emit(TaskChartStatusErrorState(error.toString()));
    });
  }

  TaskStatusModel? taskStatusModel;
  getTaskData(
      {int? userId, String? startDate, String? endDate, int? priority}) {
    emit(TaskStatusLoadingState());
    DioHelper.getData(url: 'tasks/status', query: {
      'UserId': userId,
      'StartDate': startDate,
      'EndDate': endDate,
      'Priority': priority
    }).then((value) {
      taskStatusModel = TaskStatusModel.fromJson(value!.data);
      emit(TaskStatusSuccessState(taskStatusModel!));
    }).catchError((error) {
      emit(TaskStatusErrorState(error.toString()));
    });
  }

  void changeChartTypeTask(String type) {
    selectedChartTypeTask = type;
    emit(ChangeChartTypeTaskState());
  }

  ({DateTime? startDate, DateTime? endDate}) _parseDateRange(String range) {
    try {
      final parts = range.split(' - ');
      if (parts.length != 2) return (startDate: null, endDate: null);

      final monthPart1 = parts[0].trim();
      final monthPart2AndYear = parts[1].trim().split(' ');
      if (monthPart2AndYear.length != 2)
        return (startDate: null, endDate: null);

      final monthPart2 = monthPart2AndYear[0];
      final yearPart = monthPart2AndYear[1];

      final year = int.tryParse(yearPart);
      if (year == null) return (startDate: null, endDate: null);

      final dateFormat = DateFormat('MMM');
      final startMonth = dateFormat.parse(monthPart1);
      final endMonth = dateFormat.parse(monthPart2);

      // Get first day of start month (we still need this for accurate month parsing)
      final startDate = DateTime(year, startMonth.month, 1);

      // Get last day of end month (we still need this for accurate month parsing)
      final endDate = DateTime(year, endMonth.month + 1, 0);

      return (startDate: startDate, endDate: endDate);
    } catch (e) {
      return (startDate: null, endDate: null);
    }
  }

  String _formatDateForApi(DateTime date) {
    return '${date.month}-${date.year}';
  }

  void changeDateRangeUserTask(String range) {
    selectedDateRangeTask = range;
    emit(ChangeChartTypeTaskState());

    final parsedDates = _parseDateRange(range);
    if (parsedDates.startDate == null || parsedDates.endDate == null) return;

    final userId = selectedUserNametask != 'All Users'
        ? usersBasicModel?.data
            ?.firstWhere((u) => u.userName == selectedUserNametask)
            .id
        : null;

    getChartTaskData(
      userId: userId,
      startDate: _formatDateForApi(parsedDates.startDate!),
      endDate: _formatDateForApi(parsedDates.endDate!),
    );
  }

  void changeSelectedUsertask(int userId) {
    if (userId == 0) {
      selectedUserNametask = 'All Users';
    } else {
      final user = usersBasicModel?.data?.firstWhere((p) => p.id == userId);
      selectedUserNametask = user?.userName ?? 'All Users';
    }

    emit(ChangeUserTaskState());

    if (selectedDateRangeTask.contains('.....')) {
      getChartTaskData(userId: userId == 0 ? null : userId);
    }
    // Otherwise send both user ID and dates
    else {
      final parsedDates = _parseDateRange(selectedDateRangeTask);
      if (parsedDates.startDate != null && parsedDates.endDate != null) {
        getChartTaskData(
          userId: userId == 0 ? null : userId,
          startDate: _formatDateForApi(parsedDates.startDate!),
          endDate: _formatDateForApi(parsedDates.endDate!),
        );
      }
    }
  }

  String selectedPriority = 'High';

  final List<String> priorities = ['High', 'Medium', 'Low'];

  final Map<String, Color> priorityColors = {
    'High': Colors.red,
    'Medium': Colors.orange,
    'Low': Colors.green,
  };

  int? convertPriorityToInt(String priority) {
    switch (priority) {
      case 'High':
        return 0;
      case 'Medium':
        return 1;
      case 'Low':
        return 2;
      default:
        return null;
    }
  }

  bool isArabic() {
    return Intl.getCurrentLocale() == 'ar';
  }
}
