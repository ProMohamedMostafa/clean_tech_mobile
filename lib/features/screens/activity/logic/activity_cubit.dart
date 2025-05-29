import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/widgets/filter/data/model/filter_dialog_data_model.dart';
import 'package:smart_cleaning_application/features/screens/activity/data/model/activities_model.dart';
import 'package:smart_cleaning_application/features/screens/activity/logic/activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit() : super(ActivityInitialState());

  static ActivityCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  ScrollController activitiesScrollController = ScrollController();

  int selectedIndex = 0;
  int currentPage = 1;
  FilterDialogDataModel? filterModel;
  ActivitiesModel? myActivities;
  ActivitiesModel? teamActivities;

  bool isPersonal = true;
  getActivities({required bool isPersonal}) async {
    emit(ActivityLoadingState());
    DioHelper.getData(
      url: "logs",
      query: {
        'PageNumber': currentPage,
        'PageSize': 15,
        'Search': searchController.text,
        'RoleId': filterModel?.roleId,
        'Action': filterModel?.actionId,
        'Module': filterModel?.moduleId,
        'UserId': filterModel?.userId,
        'StartDate': filterModel?.startDate,
        'EndDate': filterModel?.endDate,
        'History': isPersonal,
      },
    ).then((value) {
      final activities = ActivitiesModel.fromJson(value!.data);

      if (isPersonal) {
        if (currentPage == 1 || myActivities == null) {
          myActivities = activities;
        } else {
          myActivities?.data?.activities
              ?.addAll(activities.data?.activities ?? []);
          myActivities?.data?.currentPage = activities.data?.currentPage;
          myActivities?.data?.totalPages = activities.data?.totalPages;
        }
      } else {
        if (currentPage == 1 || teamActivities == null) {
          teamActivities = activities;
        } else {
          teamActivities?.data?.activities
              ?.addAll(activities.data?.activities ?? []);
          teamActivities?.data?.currentPage = activities.data?.currentPage;
          teamActivities?.data?.totalPages = activities.data?.totalPages;
        }
      }

      emit(ActivitySuccessState(
          isPersonal == true ? myActivities! : teamActivities!));
    }).catchError((error) {
      emit(ActivityErrorState(error.toString()));
    });
  }

  void initialize() {
    activitiesScrollController = ScrollController()
      ..addListener(() {
        if (activitiesScrollController.position.atEdge &&
            activitiesScrollController.position.pixels != 0) {
          currentPage++;
          getActivities(isPersonal: isPersonal);
        }
      });

    getActivities(isPersonal: isPersonal);
  }

  void changeTap(int index) {
    selectedIndex = index;
    currentPage = 1;
    isPersonal = (index == 0);

    if (isPersonal) {
      if (myActivities == null) {
        getActivities(isPersonal: true);
      } else {
        emit(ActivitySuccessState(myActivities!));
      }
    } else {
      if (teamActivities == null) {
        getActivities(isPersonal: false);
      } else {
        emit(ActivitySuccessState(teamActivities!));
      }
    }
  }

// activity_cubit.dart

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
      case 'ClockInOut':
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
      default:
        return Colors.black;
    }
  }

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
}
