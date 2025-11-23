import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/widgets/filter/data/model/filter_dialog_data_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/activity/data/model/activities_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/activity/logic/activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit() : super(ActivityInitialState());

  static ActivityCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  ScrollController activitiesScrollController = ScrollController();

  int selectedIndex = 0;
  int myCurrentPage = 1;
  int teamCurrentPage = 1;

  FilterDialogDataModel? filterModel;
  FilterDialogDataModel? teamFilterModel;
  ActivitiesModel? myActivities;
  ActivitiesModel? teamActivities;

  getActivities() async {
    emit(ActivityLoadingState());

    try {
      final response = await DioHelper.getData(
        url: "logs",
        query: {
          'PageNumber': myCurrentPage,
          'PageSize': 15,
          'Search': searchController.text,
          'RoleId': filterModel?.roleId,
          'Action': filterModel?.actionId,
          'Module': filterModel?.moduleId,
          'UserId': filterModel?.userId,
          'StartDate': filterModel?.startDate,
          'EndDate': filterModel?.endDate,
          'History': true,
        },
      );

      final activities = ActivitiesModel.fromJson(response!.data);

      if (myCurrentPage == 1 || myActivities == null) {
        myActivities = activities;
      } else {
        myActivities?.data?.activities
            ?.addAll(activities.data?.activities ?? []);
        myActivities?.data?.currentPage = activities.data?.currentPage;
        myActivities?.data?.totalPages = activities.data?.totalPages;
      }

      emit(ActivitySuccessState(myActivities!));
    } catch (error) {
      emit(ActivityErrorState(error.toString()));
    }
  }

  getTeamActivities() async {
    emit(ActivityLoadingState());

    try {
      final response = await DioHelper.getData(
        url: "logs",
        query: {
          'PageNumber': teamCurrentPage,
          'PageSize': 15,
          'Search': searchController.text,
          'RoleId': teamFilterModel?.roleId,
          'Action': teamFilterModel?.actionId,
          'Module': teamFilterModel?.moduleId,
          'UserId': teamFilterModel?.userId,
          'StartDate': teamFilterModel?.startDate,
          'EndDate': teamFilterModel?.endDate,
          'History': false,
        },
      );

      final activities = ActivitiesModel.fromJson(response!.data);

      if (teamCurrentPage == 1 || teamActivities == null) {
        teamActivities = activities;
      } else {
        teamActivities?.data?.activities
            ?.addAll(activities.data?.activities ?? []);
        teamActivities?.data?.currentPage = activities.data?.currentPage;
        teamActivities?.data?.totalPages = activities.data?.totalPages;
      }

      emit(ActivitySuccessState(teamActivities!));
    } catch (error) {
      emit(ActivityErrorState(error.toString()));
    }
  }

  void initialize() {
    activitiesScrollController.dispose();

    activitiesScrollController = ScrollController()
      ..addListener(() {
        if (activitiesScrollController.position.atEdge &&
            activitiesScrollController.position.pixels != 0) {
          if (selectedIndex == 0) {
            myCurrentPage++;
            getActivities();
          } else {
            teamCurrentPage++;
            getTeamActivities();
          }
        }
      });

    myCurrentPage = 1;
    myActivities = null;
    getActivities();

    if (role != "Cleaner") {
      teamCurrentPage = 1;
      teamActivities = null;
      getTeamActivities();
    }
  }

  void changeTap(int index) {
    selectedIndex = index;
    emit(ActivityLoadingState());

    if (index == 0) {
      myCurrentPage = 1;
      myActivities = null;
      getActivities();
    } else {
      teamCurrentPage = 1;
      teamActivities = null;
      getTeamActivities();
    }
  }

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
      case 'Question':
        return Routes.questionScreen;
      case 'FeedbackDevice':
        return Routes.devicesScreen;
      case 'Audit':
      case 'Feedback':
        return Routes.feedbackAuditDetailsScreen;
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

String formatTimeDifferenceFromString(String dateString) {
  final time = parseUtc(dateString); // convert backend UTC to local
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




  DateTime parseUtc(String dateString) {
  return DateTime.parse("${dateString}Z").toUtc().toLocal();
}

}
