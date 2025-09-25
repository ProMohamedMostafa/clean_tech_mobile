import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/feedback_audit_mangement/data/all_feedback_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_overview/data/models/feedback_audit_overview_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_overview/data/models/filter_location.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_overview/data/models/satisfaction_rate_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_overview/data/models/statistics.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_overview/data/models/total_device_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_overview/data/models/total_feedback_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_overview/data/models/total_feedbacks_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_overview/data/models/total_question_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/city_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/organization_list_model.dart';
part 'feedback_overview_state.dart';

class FeedbackOverviewCubit extends Cubit<FeedbackOverviewState> {
  FeedbackOverviewCubit() : super(FeedbackOverviewInitial());

  TextEditingController levelController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController areaIdController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController cityIdController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController organizationIdController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController buildingIdController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController floorIdController = TextEditingController();

  DateTime? selectedDate;

  void initializeFeedbackOverview() {
    getFeedbacksYear();
    getFeedbacks();
    getSatisfactionData();
    getTotalDeviceData();
    getTotalQuestionData();
    getTotalFeedbacksData();
    getFeedbackAuditData();
    getStatisticsData();
  }

//TotalQuestion Rate part
  TotalQuestionModel? totalQuestionModel;
  getTotalQuestionData() {
    emit(TotalQuestionLoadingState());
    DioHelper.getData(url: 'questions/home/count').then((value) {
      totalQuestionModel = TotalQuestionModel.fromJson(value!.data);
      emit(TotalQuestionSuccessState());
    }).catchError((error) {
      emit(TotalQuestionErrorState(error.toString()));
    });
  }

  //TotalFeedback Rate part
  TotalFeedbacksModel? totalFeedbacksModel;
  getTotalFeedbacksData() {
    emit(TotalfeedbacksLoadingState());
    DioHelper.getData(url: 'feedback/devices/home/count').then((value) {
      totalFeedbacksModel = TotalFeedbacksModel.fromJson(value!.data);
      emit(TotalfeedbacksSuccessState());
    }).catchError((error) {
      emit(TotalfeedbacksErrorState(error.toString()));
    });
  }

//Satisfaction Rate part
  SatisfactionRateModel? satisfactionRateModel;
  getSatisfactionData({int? month}) {
    emit(SatisfactionRateLoadingState());
    DioHelper.getData(url: 'feedback/answers/home/rate', query: {
      'Month': month,
    }).then((value) {
      satisfactionRateModel = SatisfactionRateModel.fromJson(value!.data);
      emit(SatisfactionRateSuccessState());
    }).catchError((error) {
      emit(SatisfactionRateErrorState(error.toString()));
    });
  }

  void changeSelectedDate(DateTime date) {
    selectedDate = date;
    emit(OverviewDateChanged());
  }

//Total device part
  String? selectedLocationDevices;
  FilterLocationModel? filterLocationModel;
  TotalDeviceModel? totalDeviceModel;
  getTotalDeviceData() {
    emit(TotalDeviceLoadingState());
    DioHelper.getData(url: 'feedback/devices/home/count', query: {
      'AreaId': filterLocationModel?.areaId,
      'CityId': filterLocationModel?.cityId,
      'OrganizationId': filterLocationModel?.organizationId,
      'BuildingId': filterLocationModel?.buildingId,
      'FloorId': filterLocationModel?.floorId,
    }).then((value) {
      totalDeviceModel = TotalDeviceModel.fromJson(value!.data);
      emit(TotalDeviceSuccessState());
    }).catchError((error) {
      emit(TotalDeviceErrorState(error.toString()));
    });
  }

  final List<String> levelOrder = [
    'Area',
    'City',
    'Organization',
    'Building',
    'Floor',
  ];
  String selectedLevel = '';
  void setSelectedLevel(String level) {
    selectedLevel = level;
    emit(FilterDialogLevelChanged());
  }

  bool shouldShow(String level) {
    final selectedIndex = levelOrder.indexOf(selectedLevel);
    final levelIndex = levelOrder.indexOf(level);
    return selectedIndex >= levelIndex;
  }

  void changeSelectedLocation(String location) {
    selectedLocationDevices = location;
    emit(OverviewLocationChanged());
  }

  AreaListModel? areaListModel;
  List<AreaItem> areaItem = [AreaItem(name: 'No Areas')];
  getArea() {
    emit(FilterDialogLoading<AreaListModel>());
    DioHelper.getData(url: "areas/pagination").then((value) {
      areaListModel = AreaListModel.fromJson(value!.data);
      areaItem = areaListModel?.data?.data ?? [AreaItem(name: 'No Areas')];
      emit(FilterDialogSuccess<AreaListModel>());
    }).catchError((error) {
      emit(FilterDialogError<AreaListModel>());
    });
  }

  CityListModel? cityModel;
  List<CityItem> cityItem = [CityItem(name: 'No Cities')];
  getCity() {
    emit(FilterDialogLoading<CityListModel>());
    DioHelper.getData(
        url: "cities/pagination",
        query: {'Area': areaIdController.text}).then((value) {
      cityModel = CityListModel.fromJson(value!.data);
      cityItem = cityModel?.data?.data ?? [CityItem(name: 'No Cities')];
      emit(FilterDialogSuccess<CityListModel>());
    }).catchError((error) {
      emit(FilterDialogError<CityListModel>());
    });
  }

  OrganizationListModel? organizationModel;
  List<OrganizationItem> organizationItem = [
    OrganizationItem(name: 'No organizations')
  ];
  getOrganization() {
    emit(FilterDialogLoading<OrganizationListModel>());
    DioHelper.getData(
        url: "organizations/pagination",
        query: {'City': cityIdController.text}).then((value) {
      organizationModel = OrganizationListModel.fromJson(value!.data);
      organizationItem = organizationModel?.data?.data ??
          [OrganizationItem(name: 'No organizations')];
      emit(FilterDialogSuccess<OrganizationListModel>());
    }).catchError((error) {
      emit(FilterDialogError<OrganizationListModel>());
    });
  }

  BuildingListModel? buildingModel;
  List<BuildingItem> buildingItem = [BuildingItem(name: 'No building')];
  getBuilding() {
    emit(FilterDialogLoading<BuildingListModel>());
    DioHelper.getData(
        url: 'buildings/pagination',
        query: {'OrganizationId': organizationIdController.text}).then((value) {
      buildingModel = BuildingListModel.fromJson(value!.data);
      buildingItem =
          buildingModel?.data?.data ?? [BuildingItem(name: 'No building')];
      emit(FilterDialogSuccess<BuildingListModel>());
    }).catchError((error) {
      emit(FilterDialogError<BuildingListModel>());
    });
  }

  FloorListModel? floorModel;
  List<FloorItem> floorItem = [FloorItem(name: 'No floors')];
  getFloor() {
    emit(FilterDialogLoading<FloorListModel>());
    DioHelper.getData(
        url: 'floors/pagination',
        query: {'BuildingId': buildingIdController.text}).then((value) {
      floorModel = FloorListModel.fromJson(value!.data);
      floorItem = floorModel?.data?.data ?? [FloorItem(name: 'No floors')];
      emit(FilterDialogSuccess<FloorListModel>());
    }).catchError((error) {
      emit(FilterDialogError<FloorListModel>());
    });
  }

  //Feedback Part
  String? selectedFeedbackName;
  String selectedChartTypeFeedback = 'Line';
  String selectedDateRangeFeedback = '${DateTime.now().year}';

  TotalFeedbackModel? totalFeedbackModel;
  getFeedbacksYear({int? year, feedbackId}) {
    emit(TotalFeedbackLoadingState());
    DioHelper.getData(url: 'feedback/answers/home/count', query: {
      'Year': year,
      'FeedbackDeviceId': feedbackId,
    }).then((value) {
      totalFeedbackModel = TotalFeedbackModel.fromJson(value!.data);
      emit(TotalFeedbackSuccessState(totalFeedbackModel!));
    }).catchError((error) {
      emit(TotalFeedbackErrorState(error.toString()));
    });
  }

  AllFeedbackModel? feedbacksModel;
  int currentPage = 1;
  ScrollController feedbackScrollController = ScrollController();

  getFeedbacks() {
    emit(AllFeedbacksLoadingState());
    DioHelper.getData(url: "section/usage", query: {
      'PageNumber': currentPage,
      'PageSize': 10,
      'Type': 0,
    }).then((value) {
      final newFeedbacks = AllFeedbackModel.fromJson(value!.data);

      if (currentPage == 1 || feedbacksModel == null) {
        feedbacksModel = newFeedbacks;
      } else {
        feedbacksModel?.data?.data?.addAll(newFeedbacks.data?.data ?? []);
        feedbacksModel?.data?.currentPage = newFeedbacks.data?.currentPage;
        feedbacksModel?.data?.totalPages = newFeedbacks.data?.totalPages;
      }
      emit(AllFeedbacksSuccessState(feedbacksModel!));
    }).catchError((error) {
      emit(AllFeedbacksErrorState(error.toString()));
    });
  }

  void initialize() {
    feedbackScrollController = ScrollController()
      ..addListener(() {
        if (feedbackScrollController.position.pixels ==
            feedbackScrollController.position.maxScrollExtent) {
          currentPage++;
          getFeedbacks();
        }
      });
    getFeedbacks();
  }

  void changeChartTypeFeedback(String type) {
    selectedChartTypeFeedback = type;
    emit(ChangeChartTypeFeedbackState());
  }

  void changeDateRangeFeedback(String range) {
    selectedDateRangeFeedback = range;
    emit(ChangeChartTypeFeedbackState());
    final selectedYear = _extractYearFromRange(range);
    final feedbackId = selectedFeedbackName != 'All Feedbacks'
        ? feedbacksModel?.data?.data
            ?.firstWhere((p) => p.name == selectedFeedbackName)
            .id
        : null;

    getFeedbacksYear(year: selectedYear, feedbackId: feedbackId);
  }

  void changeSelectedFeedback(int feedbackId) {
    if (feedbackId == 0) {
      selectedFeedbackName = 'All Feedbacks';
    } else {
      final feedback =
          feedbacksModel?.data?.data?.firstWhere((p) => p.id == feedbackId);
      selectedFeedbackName = feedback?.name ?? 'All Feedbacks';
    }

    emit(ChangeFeedbackState());
    final selectedYear = _extractYearFromRange(selectedDateRangeFeedback);
    getFeedbacksYear(year: selectedYear, feedbackId: feedbackId);
  }

  int? _extractYearFromRange(String range) {
    final match = RegExp(r'\d{4}$').firstMatch(range);
    return match != null ? int.tryParse(match.group(0)!) : null;
  }

//FeedbackAuditRate part
  FeedbackAuditModel? feedbackAuditModel;
  getFeedbackAuditData() {
    emit(FeedbackAuditLoadingState());
    DioHelper.getData(url: 'feedback/answers/home/audits', query: {
      'AreaId': filterLocationModel?.areaId,
      'CityId': filterLocationModel?.cityId,
      'OrganizationId': filterLocationModel?.organizationId,
      'BuildingId': filterLocationModel?.buildingId,
      'FloorId': filterLocationModel?.floorId,
    }).then((value) {
      feedbackAuditModel = FeedbackAuditModel.fromJson(value!.data);
      emit(FeedbackAuditSuccessState(feedbackAuditModel!));
    }).catchError((error) {
      emit(FeedbackAuditErrorState(error.toString()));
    });
  }

  String? selectedLocationGraph;
  void changeSelectedLocationGraph(String location) {
    selectedLocationGraph = location;
    emit(OverviewLocationChanged());
  }

//table part
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  int statisticscurrentPage = 1;
  StatisticsModel? statisticsModel;
  getStatisticsData() {
    emit(StatisticsDataLoadingState());

    DioHelper.getData(url: "feedback/answers/home/statistics", query: {
      'PageNumber': currentPage,
      'PageSize': 10,
      'SearchQuery': searchController.text,
    }).then((value) {
      final statistics = StatisticsModel.fromJson(value!.data);

      if (currentPage == 1 || statisticsModel == null) {
        statisticsModel = statistics;
      } else {
        statisticsModel?.data?.data?.addAll(statistics.data?.data ?? []);
        statisticsModel?.data?.currentPage = statistics.data?.currentPage;
        statisticsModel?.data?.totalPages = statistics.data?.totalPages;
      }

      emit(StatisticsDataSuccessState(statisticsModel!));
    }).catchError((error) {
      emit(StatisticsDataErrorState(error.toString()));
    });
  }

  void initializeStatistics() {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          currentPage++;
          getStatisticsData();
        }
      });
    getStatisticsData();
  }

  void clearFilter() {
    areaController.clear();
    cityController.clear();
    organizationController.clear();
    buildingController.clear();
    floorController.clear();

    areaIdController.clear();
    cityIdController.clear();
    organizationIdController.clear();
    buildingIdController.clear();
    floorIdController.clear();

    levelController.clear();
    selectedLevel = '';
    filterLocationModel = null;

    emit(FilterDialogCleared());
  }
}
