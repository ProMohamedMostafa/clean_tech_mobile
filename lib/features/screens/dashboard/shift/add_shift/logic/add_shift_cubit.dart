import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/add_shift/data/model/create_shift_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/add_shift/logic/add_shift_state.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/section_list_model.dart';

class AddShiftCubit extends Cubit<AddShiftState> {
  AddShiftCubit() : super(AddShiftInitialState());

  static AddShiftCubit get(context) => BlocProvider.of(context);
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

  CreateShiftModel? createShiftModel;
  addShift() async {
    emit(AddShiftLoadingState());
    try {
      final response =
          await DioHelper.postData(url: ApiConstants.createShiftUrl, data: {
        "name": shiftNameController.text,
        "startDate": startDateController.text,
        "endDate": endDateController.text,
        "startTime": startTimeController.text,
        "endTime": endTimeController.text,
        "organizationIds": [...selectedOrganizationsIds],
        "buildingIds": [...selectedBuildingsIds],
        "floorIds": [...selectedFloorsIds],
        "sectionIds": [...selectedSectionsIds]
      });
      createShiftModel = CreateShiftModel.fromJson(response!.data);
      emit(AddShiftSuccessState(createShiftModel!));
    } catch (error) {
      emit(AddShiftErrorState(error.toString()));
    }
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
    emit(GetBuildingLoadingState());
    DioHelper.getData(url: 'buildings/pagination').then((value) {
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
    DioHelper.getData(url: 'floors/pagination').then((value) {
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
    DioHelper.getData(url: 'sections/pagination').then((value) {
      sectionModel = SectionListModel.fromJson(value!.data);
      sectionItem =
          sectionModel?.data?.data ?? [SectionItem(name: 'No sections')];
      emit(GetSectionSuccessState(sectionModel!));
    }).catchError((error) {
      emit(GetSectionErrorState(error.toString()));
    });
  }
}
