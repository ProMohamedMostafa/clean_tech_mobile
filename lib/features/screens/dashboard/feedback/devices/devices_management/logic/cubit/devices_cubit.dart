import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/widgets/filter/data/model/filter_dialog_data_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/devices/devices_management/data/model/devices_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/edit_task/data/models/section_basic_model.dart';
part 'devices_state.dart';

class DevicesCubit extends Cubit<DevicesState> {
  DevicesCubit() : super(DevicesInitial());

  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  int currentPage = 1;

  FilterDialogDataModel? filterModel;
  DevicesModel? devicesModel;

  getDevices() {
    emit(DevicesLoadingState());
    DioHelper.getData(url: "feedback/devices", query: {
      'PageNumber': currentPage,
      'PageSize': 20,
      'SearchQuery': searchController.text,
      'SectionId': filterModel?.sectionId,
    }).then((value) {
      final newDevices = DevicesModel.fromJson(value!.data);

      if (currentPage == 1 || devicesModel == null) {
        devicesModel = newDevices;
      } else {
        devicesModel?.data?.data?.addAll(newDevices.data?.data ?? []);
        devicesModel?.data?.currentPage = newDevices.data?.currentPage;
        devicesModel?.data?.totalPages = newDevices.data?.totalPages;
      }

      emit(DevicesSuccessState(devicesModel!));
    }).catchError((error) {
      emit(DevicesErrorState(error.toString()));
    });
  }

  void initialize() {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          currentPage++;
          getDevices();
        }
      });
    getDevices();
    getSection();
  }

  SectionBasicModel? sectionModel;
  getSection() {
    emit(GetSectionLoadingState());
    DioHelper.getData(url: 'sections/basic').then((value) {
      sectionModel = SectionBasicModel.fromJson(value!.data);

      emit(GetSectionSuccessState(sectionModel!));
    }).catchError((error) {
      emit(GetSectionErrorState(error.toString()));
    });
  }

  forcedDeletedDevice(int id) {
    emit(ForceDeleteDeviceLoadingState());
    DioHelper.deleteData(url: 'feedback/devices/delete/$id').then((value) {
      final message = value?.data['message'] ?? "deleted successfully";
      emit(ForceDeleteDeviceSuccessState(message));
    }).catchError((error) {
      emit(ForceDeleteDeviceErrorState(error.toString()));
    });
  }

  Future<void> refresh() async {
    currentPage = 1;
    devicesModel = null;
    emit(DevicesLoadingState());
    await getDevices();
  }
}
