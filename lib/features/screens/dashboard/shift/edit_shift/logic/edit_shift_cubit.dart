import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/edit_shift/data/model/edit_shift_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/edit_shift/logic/edit_shift_state.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/shift_details/data/models/shift_details_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/section_list_model.dart';

class EditShiftCubit extends Cubit<EditShiftState> {
  EditShiftCubit() : super(EditShiftInitialState());

  static EditShiftCubit get(context) => BlocProvider.of(context);

  TextEditingController shiftNameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  final allOrganizationsController = MultiSelectController<OrganizationItem>();
  final allBuildingsController = MultiSelectController<BuildingItem>();
  final allFloorsController = MultiSelectController<FloorItem>();
  final allSectionsController = MultiSelectController<SectionItem>();

  final formKey = GlobalKey<FormState>();

  List<int> selectedOrganizationsIds = [];
  List<int> selectedBuildingsIds = [];
  List<int> selectedFloorsIds = [];
  List<int> selectedSectionsIds = [];

  EditShiftDetailsModel? editShiftDetailsModel;
  editShift(int? id) async {
    emit(EditShiftLoadingState());
    try {
      final response =
          await DioHelper.putData(url: ApiConstants.editShiftsUrl, data: {
        "id": id,
        "name": shiftNameController.text.isEmpty
            ? shiftDetailsModel!.data!.name
            : shiftNameController.text,
        "startDate": startDateController.text.isEmpty
            ? shiftDetailsModel!.data!.startDate
            : startDateController.text,
        "endDate": endDateController.text.isEmpty
            ? shiftDetailsModel!.data!.endDate
            : endDateController.text,
        "startTime": startTimeController.text.isEmpty
            ? shiftDetailsModel!.data!.startTime
            : startTimeController.text,
        "endTime": endTimeController.text.isEmpty
            ? shiftDetailsModel!.data!.endTime
            : endTimeController.text,
        "organizationIds": [...selectedOrganizationsIds],
        "buildingIds": [...selectedBuildingsIds],
        "floorIds": [...selectedFloorsIds],
        "sectionIds": [...selectedSectionsIds]
      });
      editShiftDetailsModel = EditShiftDetailsModel.fromJson(response!.data);
      emit(EditShiftSuccessState(editShiftDetailsModel!));
    } catch (error) {
      emit(EditShiftErrorState(error.toString()));
    }
  }

  ShiftDetailsModel? shiftDetailsModel;
  getShiftDetails(int? id) {
    emit(ShiftDetailsLoadingState());
    DioHelper.getData(url: 'shifts/$id').then((value) {
      shiftDetailsModel = ShiftDetailsModel.fromJson(value!.data);
      emit(ShiftDetailsSuccessState(shiftDetailsModel!));
    }).catchError((error) {
      emit(ShiftDetailsErrorState(error.toString()));
    });
  }

  OrganizationListModel? organizationModel;
  List<OrganizationItem> organizationItem = [
    OrganizationItem(name: 'No organizations')
  ];
  getOrganization() {
    emit(OrganizationLoadingState());
    DioHelper.getData(url: "organizations/pagination").then((value) {
      organizationModel = OrganizationListModel.fromJson(value!.data);
      organizationItem = organizationModel?.data?.data ??
          [OrganizationItem(name: 'No organizations')];
      emit(OrganizationSuccessState(organizationModel!));
    }).catchError((error) {
      emit(OrganizationErrorState(error.toString()));
    });
  }

  BuildingListModel? buildingModel;
  List<BuildingItem> buildingItem = [BuildingItem(name: 'No building')];
  getBuilding() {
    emit(BuildingLoadingState());
    DioHelper.getData(url: 'buildings/pagination').then((value) {
      buildingModel = BuildingListModel.fromJson(value!.data);
      buildingItem =
          buildingModel?.data?.data ?? [BuildingItem(name: 'No building')];
      emit(BuildingSuccessState(buildingModel!));
    }).catchError((error) {
      emit(BuildingErrorState(error.toString()));
    });
  }

  FloorListModel? floorModel;
  List<FloorItem> floorItem = [FloorItem(name: 'No floors')];
  getFloor() {
    emit(FloorLoadingState());
    DioHelper.getData(url: 'floors/pagination').then((value) {
      floorModel = FloorListModel.fromJson(value!.data);
      floorItem = floorModel?.data?.data ?? [FloorItem(name: 'No floors')];
      emit(FloorSuccessState(floorModel!));
    }).catchError((error) {
      emit(FloorErrorState(error.toString()));
    });
  }

  SectionListModel? sectionModel;
  List<SectionItem> sectionItem = [SectionItem(name: 'No sections')];
  getSection() {
    emit(SectionLoadingState());
    DioHelper.getData(url: 'sections/pagination').then((value) {
      sectionModel = SectionListModel.fromJson(value!.data);
      sectionItem =
          sectionModel?.data?.data ?? [SectionItem(name: 'No sections')];
      emit(SectionSuccessState(sectionModel!));
    }).catchError((error) {
      emit(SectionErrorState(error.toString()));
    });
  }

  void initializeControllers() {
    if (shiftDetailsModel != null &&
        organizationModel != null &&
        buildingModel != null &&
        floorModel != null &&
        sectionModel != null) {
      // Initialize Organizations
      final organizations = organizationModel!.data!.data!
          .map((organization) => DropdownItem(
                label: organization.name ?? 'Unnamed Organization',
                value: OrganizationItem(
                  id: organization.id,
                  name: organization.name,
                  cityId: organization.cityId,
                  cityName: organization.cityName,
                  areaId: organization.areaId,
                  areaName: organization.areaName,
                  countryName: organization.countryName,
                ),
              ))
          .toList();

      allOrganizationsController.setItems(organizations);
      selectedOrganizationsIds = shiftDetailsModel!.data!.organizations
              ?.map((org) => org.id ?? 0)
              .where((id) => id != 0)
              .toList() ??
          [];
      allOrganizationsController.selectWhere(
          (item) => selectedOrganizationsIds.contains(item.value.id));

      // Initialize Buildings
      final buildings = buildingModel!.data!.data!
          .map((building) => DropdownItem(
                label: building.name ?? 'Unnamed Building',
                value: BuildingItem(
                  id: building.id,
                  name: building.name,
                  organizationId: building.organizationId,
                  organizationName: building.organizationName,
                ),
              ))
          .toList();

      allBuildingsController.setItems(buildings);
      selectedBuildingsIds = shiftDetailsModel!.data!.building
              ?.map((building) => building.id ?? 0)
              .where((id) => id != 0)
              .toList() ??
          [];
      allBuildingsController
          .selectWhere((item) => selectedBuildingsIds.contains(item.value.id));

      // Initialize Floors
      final floors = floorModel!.data!.data!
          .map((floor) => DropdownItem(
                label: floor.name ?? 'Unnamed Floor',
                value: FloorItem(
                  id: floor.id,
                  name: floor.name,
                  buildingId: floor.buildingId,
                  buildingName: floor.buildingName,
                ),
              ))
          .toList();

      allFloorsController.setItems(floors);
      selectedFloorsIds = shiftDetailsModel!.data!.floors
              ?.map((floor) => floor.id ?? 0)
              .where((id) => id != 0)
              .toList() ??
          [];
      allFloorsController
          .selectWhere((item) => selectedFloorsIds.contains(item.value.id));

      // Initialize Sections
      final sections = sectionModel!.data!.data!
          .map((section) => DropdownItem(
                label: section.name ?? 'Unnamed Section',
                value: SectionItem(
                  id: section.id,
                  name: section.name,
                  floorId: section.floorId,
                  floorName: section.floorName,
                ),
              ))
          .toList();

      allSectionsController.setItems(sections);
      selectedSectionsIds = shiftDetailsModel!.data!.sections
              ?.map((section) => section.id ?? 0)
              .where((id) => id != 0)
              .toList() ??
          [];
      allSectionsController
          .selectWhere((item) => selectedSectionsIds.contains(item.value.id));
    }
  }
}
