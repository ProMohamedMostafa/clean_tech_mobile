import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/section_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/edit_task/data/models/building_basic_model.dart';

part 'add_device_state.dart';

class AddDeviceCubit extends Cubit<AddDeviceState> {
  AddDeviceCubit() : super(AddDeviceInitial());

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController buildingIdController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController floorIdController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  TextEditingController sectionIdController = TextEditingController();
  TextEditingController deviceController = TextEditingController();
  TextEditingController deviceIdController = TextEditingController();

  Future<void> addDevice() async {
    emit(AddDeviceLoadingState());

    DioHelper.postData(
      url: 'feedback/devices/create',
      data: {
        "name": nameController.text,
        "sectionId": sectionIdController.text,
      },
    ).then((value) {
      final message = value?.data['message'] ?? "Operation successfully";
      emit(AddDeviceSuccessState(message));
    }).catchError((error) {
      emit(AddDeviceErrorState(error.toString()));
    });
  }

  BuildingBasicModel? buildingModel;
  getBuilding() {
    emit(GetBuildingLoadingState());
    DioHelper.getData(url: 'buildings/basic').then((value) {
      buildingModel = BuildingBasicModel.fromJson(value!.data);

      emit(GetBuildingSuccessState(buildingModel!));
    }).catchError((error) {
      emit(GetBuildingErrorState(error.toString()));
    });
  }

  FloorListModel? floorModel;
  List<FloorItem> floorItem = [FloorItem(name: 'No floors')];
  getFloor() {
    emit(GetFloorLoadingState());
    DioHelper.getData(
        url: 'floors/pagination',
        query: {'BuildingId': buildingIdController.text}).then((value) {
      floorModel = FloorListModel.fromJson(value!.data);
      floorItem = floorModel?.data?.data ?? [FloorItem(name: 'No floors')];
      emit(GetFloorSuccessState(floorModel!));
    }).catchError((error) {
      emit(GetFloorErrorState(error.toString()));
    });
  }

  SectionListModel? sectionModel;
  List<SectionItem> sectionItem = [SectionItem(name: 'No sections')];
  getSection() {
    emit(GetSectionLoadingState());
    DioHelper.getData(
        url: 'sections/pagination',
        query: {'FloorId': floorIdController.text}).then((value) {
      sectionModel = SectionListModel.fromJson(value!.data);
      sectionItem =
          sectionModel?.data?.data ?? [SectionItem(name: 'No sections')];
      emit(GetSectionSuccessState(sectionModel!));
    }).catchError((error) {
      emit(GetSectionErrorState(error.toString()));
    });
  }
}
