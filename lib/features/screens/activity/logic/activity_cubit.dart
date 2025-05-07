import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
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
}
