import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_cleaners_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_managers_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_supervisors_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_floor/data/model/edit_floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_floor/data/model/floor_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_floor/logic/edit_floor_state.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_floor_details/data/model/floor_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_floor_details/data/model/floor_shifts_details_model.dart';

class EditFloorCubit extends Cubit<EditFloorState> {
  EditFloorCubit() : super(EditFloorInitialState());

  static EditFloorCubit get(context) => BlocProvider.of(context);
  TextEditingController nationalityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController buildingIdController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController floorNumberController = TextEditingController();
  TextEditingController floorDescriptionController = TextEditingController();
  final allmanagersController = MultiSelectController<ManagersData>();
  final allSupervisorsController = MultiSelectController<SupervisorsData>();
  final allCleanersController = MultiSelectController<CleanersData>();
  final shiftController = MultiSelectController<ShiftDetails>();
  final formKey = GlobalKey<FormState>();

  FloorEditModel? editFloorModel;
  editFloor(
      int? id,
      List<int>? selectedManagersIds,
      List<int>? selectedSupervisorsIds,
      List<int>? selectedCleanersIds,
      List<int>? shiftController) async {
    emit(EditFloorLoadingState());

    final managersIds = selectedManagersIds?.isEmpty ?? true
        ? floorManagersDetailsModel?.data?.managers?.map((m) => m.id).toList()
        : selectedManagersIds;
    final supervisorsIds = selectedSupervisorsIds?.isEmpty ?? true
        ? floorManagersDetailsModel?.data?.supervisors
            ?.map((s) => s.id)
            .toList()
        : selectedSupervisorsIds;
    final cleanersIds = selectedCleanersIds?.isEmpty ?? true
        ? floorManagersDetailsModel?.data?.cleaners?.map((c) => c.id).toList()
        : selectedCleanersIds;
    try {
      final response =
          await DioHelper.putData(url: ApiConstants.floorEditUrl, data: {
        "id": id,
        "name": floorController.text.isEmpty
            ? floorDetailsInEditModel!.data!.name
            : floorController.text,
        "number": floorNumberController.text.isEmpty
            ? floorDetailsInEditModel!.data!.number
            : floorNumberController.text,
        "description": floorDescriptionController.text.isEmpty
            ? floorDetailsInEditModel!.data!.description
            : floorDescriptionController.text,
        "buildingId": buildingController.text.isEmpty
            ? floorDetailsInEditModel!.data!.buildingId
            : buildingIdController.text,
        "managersIds": [...?managersIds, ...?supervisorsIds, ...?cleanersIds],
        "shiftsIds": shiftController ?? floorShiftsDetailsModel!.data!.shifts,
      });
      editFloorModel = FloorEditModel.fromJson(response!.data);
      emit(EditFloorSuccessState(editFloorModel!));
    } catch (error) {
      emit(EditFloorErrorState(error.toString()));
    }
  }

  FloorDetailsInEditModel? floorDetailsInEditModel;
  getFloorDetailsInEdit(int id) {
    emit(GetFloorDetailsLoadingState());
    DioHelper.getData(url: 'floors/$id').then((value) {
      floorDetailsInEditModel = FloorDetailsInEditModel.fromJson(value!.data);
      emit(GetFloorDetailsSuccessState(floorDetailsInEditModel!));
    }).catchError((error) {
      emit(GetFloorDetailsErrorState(error.toString()));
    });
  }

  FloorManagersDetailsModel? floorManagersDetailsModel;
  getFloorManagersDetails(int floorId) {
    emit(FloorManagersDetailsLoadingState());
    DioHelper.getData(url: 'floor/manager/$floorId').then((value) {
      floorManagersDetailsModel =
          FloorManagersDetailsModel.fromJson(value!.data);
      emit(FloorManagersDetailsSuccessState(floorManagersDetailsModel!));
    }).catchError((error) {
      emit(FloorManagersDetailsErrorState(error.toString()));
    });
  }

  FloorShiftsDetailsModel? floorShiftsDetailsModel;
  getFloorShiftsDetails(int floorId) {
    emit(FloorShiftsDetailsLoadingState());
    DioHelper.getData(url: 'floor/shift/$floorId').then((value) {
      floorShiftsDetailsModel = FloorShiftsDetailsModel.fromJson(value!.data);
      emit(FloorShiftsDetailsSuccessState(floorShiftsDetailsModel!));
    }).catchError((error) {
      emit(FloorShiftsDetailsErrorState(error.toString()));
    });
  }

  NationalityModel? nationalityModel;
  getNationality() {
    emit(GetNationalityLoadingState());
    DioHelper.getData(url: ApiConstants.countriesUrl).then((value) {
      nationalityModel = NationalityModel.fromJson(value!.data);
      emit(GetNationalitySuccessState(nationalityModel!));
    }).catchError((error) {
      emit(GetNationalityErrorState(error.toString()));
    });
  }

  AreaModel? areaModel;
  getArea(String countryName) {
    emit(GetAreaLoadingState());
    DioHelper.getData(url: "areas/country/$countryName").then((value) {
      areaModel = AreaModel.fromJson(value!.data);
      emit(GetAreaSuccessState(areaModel!));
    }).catchError((error) {
      emit(GetAreaErrorState(error.toString()));
    });
  }

  CityModel? cityModel;
  getCity(int areaId) {
    emit(GetCityLoadingState());
    DioHelper.getData(url: "cities/area/$areaId").then((value) {
      cityModel = CityModel.fromJson(value!.data);
      emit(GetCitySuccessState(cityModel!));
    }).catchError((error) {
      emit(GetCityErrorState(error.toString()));
    });
  }

  OrganizationModel? organizationModel;
  getOrganization(int cityId) {
    emit(GetOrganizationsLoadingState());
    DioHelper.getData(url: "organizations/city/$cityId").then((value) {
      organizationModel = OrganizationModel.fromJson(value!.data);
      emit(GetOrganizationsSuccessState(organizationModel!));
    }).catchError((error) {
      emit(GetOrganizationsErrorState(error.toString()));
    });
  }

  BuildingModel? buildingModel;
  getBuilding(int organizationId) {
    emit(GetBuildingLoadingState());
    DioHelper.getData(url: 'buildings/organization/$organizationId')
        .then((value) {
      buildingModel = BuildingModel.fromJson(value!.data);
      emit(GetBuildingSuccessState(buildingModel!));
    }).catchError((error) {
      emit(GetBuildingErrorState(error.toString()));
    });
  }

  ShiftModel? shiftModel;
  getShifts() {
    emit(ShiftLoadingState());
    DioHelper.getData(url: 'shifts/pagination').then((value) {
      shiftModel = ShiftModel.fromJson(value!.data);
      emit(ShiftSuccessState(shiftModel!));
    }).catchError((error) {
      emit(ShiftErrorState(error.toString()));
    });
  }

  AllManagersModel? allManagersModel;
  getManagers() {
    emit(AllManagersLoadingState());
    DioHelper.getData(url: 'users/manager/1').then((value) {
      allManagersModel = AllManagersModel.fromJson(value!.data);
      emit(AllManagersSuccessState(allManagersModel!));
    }).catchError((error) {
      emit(AllManagersErrorState(error.toString()));
    });
  }

  AllSupervisorsModel? allSupervisorsModel;
  getSupervisors() {
    emit(AllSupervisorsLoadingState());
    DioHelper.getData(url: 'users/manager/2').then((value) {
      allSupervisorsModel = AllSupervisorsModel.fromJson(value!.data);
      emit(AllSupervisorsSuccessState(allSupervisorsModel!));
    }).catchError((error) {
      emit(AllSupervisorsErrorState(error.toString()));
    });
  }

  AllCleanersModel? allCleanersModel;
  getCleaners() {
    emit(AllCleanersLoadingState());
    DioHelper.getData(url: 'users/manager/3').then((value) {
      allCleanersModel = AllCleanersModel.fromJson(value!.data);
      emit(AllCleanersSuccessState(allCleanersModel!));
    }).catchError((error) {
      emit(AllCleanersErrorState(error.toString()));
    });
  }
}
