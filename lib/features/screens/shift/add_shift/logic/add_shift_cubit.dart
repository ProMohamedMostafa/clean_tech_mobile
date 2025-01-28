import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/points_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/add_shift/data/model/create_shift_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/add_shift/logic/add_shift_state.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_model.dart';

class AddShiftCubit extends Cubit<AddShiftState> {
  AddShiftCubit() : super(AddShiftInitialState());

  static AddShiftCubit get(context) => BlocProvider.of(context);
  TextEditingController shiftNameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController organizationIdController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController buildingIdController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController floorIdController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController pointIdController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
        "organizationsIds": organizationIdController.text.isEmpty
            ? null
            : [organizationIdController.text],
        "buildingsIds": buildingIdController.text.isEmpty
            ? null
            : [buildingIdController.text],
        "floorsIds":
            floorIdController.text.isEmpty ? null : [floorIdController.text],
        "pointsIds":
            pointIdController.text.isEmpty ? null : [pointIdController.text]
      });
      createShiftModel = CreateShiftModel.fromJson(response!.data);
      emit(AddShiftSuccessState(createShiftModel!));
    } catch (error) {
      emit(AddShiftErrorState(error.toString()));
    }
  }

  OrganizationListModel? organizationModel;
  getOrganization() {
    emit(OrganizationLoadingState());
    DioHelper.getData(url: ApiConstants.organizationUrl).then((value) {
      organizationModel = OrganizationListModel.fromJson(value!.data);
      emit(OrganizationSuccessState(organizationModel!));
    }).catchError((error) {
      emit(OrganizationErrorState(error.toString()));
    });
  }

  BuildingModel? buildingModel;
  getBuilding(int buildingId) {
    emit(GetBuildingLoadingState());
    DioHelper.getData(url: 'buildings/organization/$buildingId').then((value) {
      buildingModel = BuildingModel.fromJson(value!.data);
      emit(GetBuildingSuccessState(buildingModel!));
    }).catchError((error) {
      emit(GetBuildingErrorState(error.toString()));
    });
  }

  FloorModel? floorModel;
  getFloor(int floorId) {
    emit(GetFloorLoadingState());
    DioHelper.getData(url: 'floors/building/$floorId').then((value) {
      floorModel = FloorModel.fromJson(value!.data);
      emit(GetFloorSuccessState(floorModel!));
    }).catchError((error) {
      emit(GetFloorErrorState(error.toString()));
    });
  }

  PointsModel? pointModel;
  getPoints(int pointId) {
    emit(GetPointLoadingState());
    DioHelper.getData(url: 'points/floor/$pointId').then((value) {
      pointModel = PointsModel.fromJson(value!.data);
      emit(GetPointSuccessState(pointModel!));
    }).catchError((error) {
      emit(GetPointErrorState(error.toString()));
    });
  }
}
