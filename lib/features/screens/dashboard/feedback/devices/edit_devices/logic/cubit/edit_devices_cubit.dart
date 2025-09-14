import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/devices/edit_devices/data/model/devices_details.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/section_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/edit_task/data/models/building_basic_model.dart';

part 'edit_devices_state.dart';

class EditDevicesCubit extends Cubit<EditDevicesState> {
  EditDevicesCubit() : super(EditDeviceInitial());

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController buildingIdController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController floorIdController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  TextEditingController sectionIdController = TextEditingController();

  Future<void> editDevice(int id) async {
    emit(EditDeviceLoadingState());
    try {
      DioHelper.putData(
        url: "feedback/devices/edit",
        data: {
          "id": id,
          "name": nameController.text.isEmpty
              ? deviceDetailsModel!.data!.name!
              : nameController.text,
          "sectionId": sectionController.text.isEmpty
              ? deviceDetailsModel!.data!.sectionId
              : sectionIdController.text,
        },
      ).then((value) {
        final message = value?.data['message'] ?? "Operation successfully";
        emit(EditDeviceSuccessState(message));
      });
    } catch (error) {
      emit(EditDeviceErrorState(error.toString()));
    }
  }

  DeviceDetails? deviceDetailsModel;
  getDeviceDetails(int id) {
    emit(DeviceDetailsLoadingState());
    DioHelper.getData(url: 'feedback/devices/$id').then((value) {
      deviceDetailsModel = DeviceDetails.fromJson(value!.data);
      emit(DeviceDetailsSuccessState(deviceDetailsModel!));
    }).catchError((error) {
      emit(DeviceDetailsErrorState(error.toString()));
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
