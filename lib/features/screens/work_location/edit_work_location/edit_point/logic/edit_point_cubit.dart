import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_cleaners_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_managers_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_supervisors_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_point/data/model/edit_point_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_point/data/model/point_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_point/logic/edit_point_state.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_point_details/data/model/point_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_point_details/data/model/point_shifts_details_model.dart';

class EditPointCubit extends Cubit<EditPointState> {
  EditPointCubit() : super(EditPointInitialState());

  static EditPointCubit get(context) => BlocProvider.of(context);
  TextEditingController nationalityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController floorIdController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController pointNumberController = TextEditingController();
  TextEditingController pointDescriptionController = TextEditingController();
  final allmanagersController = MultiSelectController<ManagersData>();
  final allSupervisorsController = MultiSelectController<SupervisorsData>();
  final allCleanersController = MultiSelectController<CleanersData>();
  final shiftController = MultiSelectController<ShiftDetails>();
  final formKey = GlobalKey<FormState>();

  PointEditModel? editPointModel;
  editPoint(
      int? id,
      List<int>? selectedManagersIds,
      List<int>? selectedSupervisorsIds,
      List<int>? selectedCleanersIds,
      List<int>? shifts) async {
    emit(EditPointLoadingState());
    try {
      final managersIds = selectedManagersIds?.isEmpty ?? true
          ? pointManagersDetailsModel?.data?.managers?.map((m) => m.id).toList()
          : selectedManagersIds;
      final supervisorsIds = selectedSupervisorsIds?.isEmpty ?? true
          ? pointManagersDetailsModel?.data?.supervisors
              ?.map((s) => s.id)
              .toList()
          : selectedSupervisorsIds;
      final cleanersIds = selectedCleanersIds?.isEmpty ?? true
          ? pointManagersDetailsModel?.data?.cleaners?.map((c) => c.id).toList()
          : selectedCleanersIds;
      final response =
          await DioHelper.putData(url: ApiConstants.pointEditUrl, data: {
        "id": id,
        "name": pointController.text.isEmpty
            ? pointDetailsInEditModel!.data!.name
            : pointController.text,
        "number": pointNumberController.text.isEmpty
            ? pointDetailsInEditModel!.data!.number
            : pointNumberController.text,
        "description": pointDescriptionController.text.isEmpty
            ? pointDetailsInEditModel!.data!.description
            : pointDescriptionController.text,
        "floorId": floorController.text.isEmpty
            ? pointDetailsInEditModel!.data!.floorId
            : floorIdController.text,
        "managersIds": [...?managersIds, ...?supervisorsIds, ...?cleanersIds],
        "shiftsIds": shifts?? pointShiftsDetailsModel!.data!.shifts,
      });
      editPointModel = PointEditModel.fromJson(response!.data);
      emit(EditPointSuccessState(editPointModel!));
    } catch (error) {
      emit(EditPointErrorState(error.toString()));
    }
  }

  PointDetailsInEditModel? pointDetailsInEditModel;
  getPointDetailsInEdit(int id) {
    emit(GetPointDetailsLoadingState());
    DioHelper.getData(url: 'points/$id').then((value) {
      pointDetailsInEditModel = PointDetailsInEditModel.fromJson(value!.data);
      emit(GetPointDetailsSuccessState(pointDetailsInEditModel!));
    }).catchError((error) {
      emit(GetPointDetailsErrorState(error.toString()));
    });
  }

  PointManagersDetailsModel? pointManagersDetailsModel;
  getPointManagersDetails(int pointId) {
    emit(PointManagersDetailsLoadingState());
    DioHelper.getData(url: 'point/manager/$pointId').then((value) {
      pointManagersDetailsModel =
          PointManagersDetailsModel.fromJson(value!.data);
      emit(PointManagersDetailsSuccessState(pointManagersDetailsModel!));
    }).catchError((error) {
      emit(PointManagersDetailsErrorState(error.toString()));
    });
  }

  PointShiftsDetailsModel? pointShiftsDetailsModel;
  getPointShiftsDetails(int pointId) {
    emit(PointShiftsDetailsLoadingState());
    DioHelper.getData(url: 'point/shift/$pointId').then((value) {
      pointShiftsDetailsModel = PointShiftsDetailsModel.fromJson(value!.data);
      emit(PointShiftsDetailsSuccessState(pointShiftsDetailsModel!));
    }).catchError((error) {
      emit(PointShiftsDetailsErrorState(error.toString()));
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

  FloorModel? floorModel;
  getFloor(int buildingId) {
    emit(GetFloorLoadingState());
    DioHelper.getData(url: 'floors/building/$buildingId').then((value) {
      floorModel = FloorModel.fromJson(value!.data);
      emit(GetFloorSuccessState(floorModel!));
    }).catchError((error) {
      emit(GetFloorErrorState(error.toString()));
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
    DioHelper.getData(url: 'users/role/2').then((value) {
      allManagersModel = AllManagersModel.fromJson(value!.data);
      emit(AllManagersSuccessState(allManagersModel!));
    }).catchError((error) {
      emit(AllManagersErrorState(error.toString()));
    });
  }

  AllSupervisorsModel? allSupervisorsModel;
  getSupervisors() {
    emit(AllSupervisorsLoadingState());
    DioHelper.getData(url: 'users/role/3').then((value) {
      allSupervisorsModel = AllSupervisorsModel.fromJson(value!.data);
      emit(AllSupervisorsSuccessState(allSupervisorsModel!));
    }).catchError((error) {
      emit(AllSupervisorsErrorState(error.toString()));
    });
  }

  AllCleanersModel? allCleanersModel;
  getCleaners() {
    emit(AllCleanersLoadingState());
    DioHelper.getData(url: 'users/role/4').then((value) {
      allCleanersModel = AllCleanersModel.fromJson(value!.data);
      emit(AllCleanersSuccessState(allCleanersModel!));
    }).catchError((error) {
      emit(AllCleanersErrorState(error.toString()));
    });
  }
}
