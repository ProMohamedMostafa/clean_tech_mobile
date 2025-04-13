import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/activity/data/model/activities_model.dart';
import 'package:smart_cleaning_application/features/screens/activity/logic/activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit() : super(ActivityInitialState());

  static ActivityCubit get(context) => BlocProvider.of(context);

  ScrollController myActivitiesScrollController = ScrollController();
  ScrollController teamActivitiesScrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  int myActivitiesCurrentPage = 1;
  int teamActivitiesCurrentPage = 1;
  ActivitiesModel? myActivities;

  getMyActivities() {
    emit(ActivityLoadingState());

    DioHelper.getData(
      url: "logs",
      query: {
        'PageNumber': myActivitiesCurrentPage,
        'PageSize': 10,
        'Search': searchController.text,
        'History': true,
      },
    ).then((value) {
      final myActicities = ActivitiesModel.fromJson(value!.data);

      if (myActivities == null) {
        myActivities = myActicities;
      } else {
        myActivities?.data.data.addAll(myActicities.data?.data ?? []);
        myActivities?.data.currentPage = myActicities.data.currentPage;
        myActivities?.data.totalPages = myActicities.data.totalPages;
      }

      emit(ActivitySuccessState(myActivities!));
    }).catchError((error) {
      emit(ActivityErrorState(error.toString()));
    });
  }

  ActivitiesModel? teamActivities;

  getTeamActivities() {
    emit(ActivityLoadingState());

    DioHelper.getData(
      url: "logs",
      query: {
        'PageNumber': teamActivitiesCurrentPage,
        'PageSize': 10,
        'Search': searchController.text,
        'History': false,
      },
    ).then((value) {
      final teamActicities = ActivitiesModel.fromJson(value!.data);

      if (myActivities == null) {
        teamActivities = teamActicities;
      } else {
        teamActivities?.data.data.addAll(teamActicities.data?.data ?? []);
        teamActivities?.data.currentPage = teamActicities.data.currentPage;
        teamActivities?.data.totalPages = teamActicities.data.totalPages;
      }

      emit(ActivitySuccessState(teamActivities!));
    }).catchError((error) {
      emit(ActivityErrorState(error.toString()));
    });
  }

  void myInitialize() {
    myActivitiesScrollController = ScrollController()
      ..addListener(() {
        if (myActivitiesScrollController.position.atEdge &&
            myActivitiesScrollController.position.pixels != 0) {
          myActivitiesCurrentPage++;
          getMyActivities();
        }
      });
  }

  void teamInitialize() {
    teamActivitiesScrollController = ScrollController()
      ..addListener(() {
        if (teamActivitiesScrollController.position.atEdge &&
            teamActivitiesScrollController.position.pixels != 0) {
          teamActivitiesCurrentPage++;
          getTeamActivities();
        }
      });
  }
}
