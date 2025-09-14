import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/devices/devices_management/data/model/devices_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/edit_feedback_audit/data/model/feedback_audit_details.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/edit_feedback_audit/logic/cubit/edit_feedback_audit_state.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/section_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/edit_task/data/models/organization_basic_model.dart';

class EditFeedbackAuditCubit extends Cubit<EditFeedbackAuditState> {
  EditFeedbackAuditCubit() : super(EditFeedbackAuditInitial());

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController organizationIdController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController buildingIdController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController floorIdController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  TextEditingController sectionIdController = TextEditingController();
  TextEditingController deviceController = TextEditingController();
  TextEditingController deviceIdController = TextEditingController();

  Future<void> editFeedbackAudit(int index, int id) async {
    emit(EditFeedbackAuditLoadingState());
    try {
      DioHelper.putData(
        url: "section/usage/edit",
        data: {
          "id": id,
          "name": nameController.text.isEmpty
              ? feedbackAuditDetailsModel!.data!.name!
              : nameController.text,
          "sectionId": sectionController.text.isEmpty
              ? feedbackAuditDetailsModel!.data!.sectionId
              : sectionIdController.text,
          "feedbackDeviceId": deviceController.text.isEmpty
              ? feedbackAuditDetailsModel!.data!.feedbackDeviceId
              : deviceIdController.text,
          "type": index
        },
      ).then((value) {
        final message = value?.data['message'] ?? "Operation successfully";
        emit(EditFeedbackAuditSuccessState(message));
      });
    } catch (error) {
      emit(EditFeedbackAuditErrorState(error.toString()));
    }
  }

  FeedbackAuditDetailsModel? feedbackAuditDetailsModel;
  getFeedbackAuditDetails(int selectIndex, int id) {
    emit(FeedbackAuditDetailsLoadingState());
    DioHelper.getData(url: 'section/usage/$id').then((value) {
      feedbackAuditDetailsModel =
          FeedbackAuditDetailsModel.fromJson(value!.data);
      emit(FeedbackAuditDetailsSuccessState(feedbackAuditDetailsModel!));
    }).catchError((error) {
      emit(FeedbackAuditDetailsErrorState(error.toString()));
    });
  }

  OrganizationBasicModel? organizationBasicModel;
  getOrganization() {
    emit(GetOrganizationLoadingState());
    DioHelper.getData(url: "organizations/basic").then((value) {
      organizationBasicModel = OrganizationBasicModel.fromJson(value!.data);

      emit(GetOrganizationSuccessState(organizationBasicModel!));
    }).catchError((error) {
      emit(GetOrganizationErrorState(error.toString()));
    });
  }

  BuildingListModel? buildingModel;
  List<BuildingItem> buildingItem = [BuildingItem(name: 'No building')];
  getBuilding() {
    emit(GetBuildingLoadingState());
    DioHelper.getData(
        url: 'buildings/pagination',
        query: {'OrganizationId': organizationIdController.text}).then((value) {
      buildingModel = BuildingListModel.fromJson(value!.data);
      buildingItem =
          buildingModel?.data?.data ?? [BuildingItem(name: 'No building')];
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

  DevicesModel? devicesModel;
  List<DeviceData> deviceData = [DeviceData(name: 'No devices')];
  getDevices() {
    emit(GetDeviceLoadingState());
    DioHelper.getData(url: 'feedback/devices', query: {'HasSection': false})
        .then((value) {
      devicesModel = DevicesModel.fromJson(value!.data);
      deviceData = devicesModel?.data?.data ?? [DeviceData(name: 'No devices')];
      emit(GetDeviceSuccessState(devicesModel!));
    }).catchError((error) {
      emit(GetDeviceErrorState(error.toString()));
    });
  }
}
