import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/widgets/filter/data/model/filter_dialog_data_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/devices/devices_answers/data/device_answers_model.dart';
part 'device_answers_state.dart';

class DeviceAnswersCubit extends Cubit<DeviceAnswersState> {
  DeviceAnswersCubit() : super(DeviceAnswersInitial());

  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  int currentPage = 1;

  FilterDialogDataModel? filterModel;
  DeviceAnswersModel? devicesModel;
  getDeviceAnswers(int id) {
    emit(DeviceAnswersLoadingState());
    DioHelper.getData(url: "feedback/answers", query: {
      'PageNumber': currentPage,
      'PageSize': 20,
      'SearchQuery': searchController.text,
      "Date": filterModel?.date,
       "BuildingId":filterModel?.buildingId,
       "FloorId":filterModel?.floorId,
      'SectionId': filterModel?.sectionId,
      "FeedbackDeviceId": id
    }).then((value) {
      final newDevices = DeviceAnswersModel.fromJson(value!.data);

      if (currentPage == 1 || devicesModel == null) {
        devicesModel = newDevices;
      } else {
        devicesModel?.data?.data?.addAll(newDevices.data?.data ?? []);
        devicesModel?.data?.currentPage = newDevices.data?.currentPage;
        devicesModel?.data?.totalPages = newDevices.data?.totalPages;
      }

      emit(DeviceAnswersSuccessState(devicesModel!));
    }).catchError((error) {
      emit(DeviceAnswersErrorState(error.toString()));
    });
  }

  void initialize(int id) {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          currentPage++;
          getDeviceAnswers(id);
        }
      });
    getDeviceAnswers(id);
  }
}
