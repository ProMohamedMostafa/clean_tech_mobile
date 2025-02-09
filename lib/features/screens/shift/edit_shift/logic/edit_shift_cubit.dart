import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/all_organization_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/points_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/edit_shift/data/model/edit_shift_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/edit_shift/logic/edit_shift_state.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/data/model/shift_details_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/data/model/shift_level_details_model.dart';

class EditShiftCubit extends Cubit<EditShiftState> {
  EditShiftCubit() : super(EditShiftInitialState());

  static EditShiftCubit get(context) => BlocProvider.of(context);

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
        "organizationsIds": organizationController.text.isEmpty
            ? shiftLevelDetailsModel!.data!.organizations!
                .map((e) => e.id)
                .toList()
            : [int.parse(organizationIdController.text)],
        "buildingsIds": buildingController.text.isEmpty
            ? shiftLevelDetailsModel!.data!.buildings!.map((e) => e.id).toList()
            : [int.parse(buildingIdController.text)],
        "floorsIds": floorController.text.isEmpty
            ? shiftLevelDetailsModel!.data!.floors!.map((e) => e.id).toList()
            : [int.parse(floorIdController.text)],
        "pointsIds": pointController.text.isEmpty
            ? shiftLevelDetailsModel!.data!.points!.map((e) => e.id).toList()
            : [int.parse(pointIdController.text)],
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

  ShiftLevelDetailsModel? shiftLevelDetailsModel;
  getShiftLevelDetails(int? id) {
    emit(ShiftLevelDetailsLoadingState());
    DioHelper.getData(url: 'level/$id').then((value) {
      shiftLevelDetailsModel = ShiftLevelDetailsModel.fromJson(value!.data);
      emit(ShiftLevelDetailsSuccessState(shiftLevelDetailsModel!));
    }).catchError((error) {
      emit(ShiftLevelDetailsErrorState(error.toString()));
    });
  }

  AllOrganizationModel? allOrganizationModel;
  getOrganization() {
    emit(OrganizationLoadingState());
    DioHelper.getData(url: ApiConstants.organizationUrl).then((value) {
      allOrganizationModel = AllOrganizationModel.fromJson(value!.data);
      emit(OrganizationSuccessState(allOrganizationModel!));
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
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:multi_dropdown/multi_dropdown.dart';
// import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
// import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
// import 'package:smart_cleaning_application/features/screens/integrations/data/models/all_organization_model.dart';
// import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_model.dart';
// import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_model.dart';
// import 'package:smart_cleaning_application/features/screens/integrations/data/models/points_model.dart';
// import 'package:smart_cleaning_application/features/screens/shift/edit_shift/data/model/edit_shift_model.dart';
// import 'package:smart_cleaning_application/features/screens/shift/edit_shift/logic/edit_shift_state.dart';
// import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/shift_details_model.dart';
// import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/shift_level_details_model.dart';

// class EditShiftCubit extends Cubit<EditShiftState> {
//   EditShiftCubit() : super(EditShiftInitialState());

//   static EditShiftCubit get(context) => BlocProvider.of(context);

//   TextEditingController shiftNameController = TextEditingController();
//   TextEditingController startDateController = TextEditingController();
//   TextEditingController endDateController = TextEditingController();
//   TextEditingController startTimeController = TextEditingController();
//   TextEditingController endTimeController = TextEditingController();
//   TextEditingController organizationController = TextEditingController();
//   TextEditingController organizationIdController = TextEditingController();
//   final formKey = GlobalKey<FormState>();
//   final organizationsController = MultiSelectController<OrganizationData>();
//   final buildingsController = MultiSelectController<BuildingData>();
//   final floorsController = MultiSelectController<FloorData>();
//   final pointsController = MultiSelectController<PointData>();

//   EditShiftDetailsModel? editShiftDetailsModel;
//   editShift(int? id, List<int>? organizations, List<int>? buildings,
//       List<int>? floors, List<int>? points) async {
//     emit(EditShiftLoadingState());

//     try {
//       final response =
//           await DioHelper.putData(url: ApiConstants.editShiftsUrl, data: {
//         "id": id,
//         "name": shiftNameController.text.isEmpty
//             ? shiftDetailsModel!.data!.name
//             : shiftNameController.text,
//         "startDate": startDateController.text.isEmpty
//             ? shiftDetailsModel!.data!.startDate
//             : startDateController.text,
//         "endDate": endDateController.text.isEmpty
//             ? shiftDetailsModel!.data!.endDate
//             : endDateController.text,
//         "startTime": startTimeController.text.isEmpty
//             ? shiftDetailsModel!.data!.startTime
//             : startTimeController.text,
//         "endTime": endTimeController.text.isEmpty
//             ? shiftDetailsModel!.data!.endTime
//             : endTimeController.text,
//         "organizationsIds":
//             organizations ?? shiftLevelDetailsModel!.data!.organizations,
//         "buildingsIds": buildings ?? shiftLevelDetailsModel!.data!.buildings,
//         "floorsIds": floors ?? shiftLevelDetailsModel!.data!.floors,
//         "pointsIds": points ?? shiftLevelDetailsModel!.data!.points,
//       });
//       editShiftDetailsModel = EditShiftDetailsModel.fromJson(response!.data);
//       emit(EditShiftSuccessState(editShiftDetailsModel!));
//     } catch (error) {
//       emit(EditShiftErrorState(error.toString()));
//     }
//   }

//   ShiftDetailsModel? shiftDetailsModel;
//   getShiftDetails(int? id) {
//     emit(ShiftDetailsLoadingState());
//     DioHelper.getData(url: 'shifts/$id').then((value) {
//       shiftDetailsModel = ShiftDetailsModel.fromJson(value!.data);
//       emit(ShiftDetailsSuccessState(shiftDetailsModel!));
//     }).catchError((error) {
//       emit(ShiftDetailsErrorState(error.toString()));
//     });
//   }

//   ShiftLevelDetailsModel? shiftLevelDetailsModel;
//   getShiftLevelDetails(int? id) {
//     emit(ShiftLevelDetailsLoadingState());
//     DioHelper.getData(url: 'level/$id').then((value) {
//       shiftLevelDetailsModel = ShiftLevelDetailsModel.fromJson(value!.data);
//       emit(ShiftLevelDetailsSuccessState(shiftLevelDetailsModel!));
//     }).catchError((error) {
//       emit(ShiftLevelDetailsErrorState(error.toString()));
//     });
//   }

//   AllOrganizationModel? allOrganizationModel;
//   getOrganization() {
//     emit(OrganizationLoadingState());
//     DioHelper.getData(url: ApiConstants.organizationUrl).then((value) {
//       allOrganizationModel = AllOrganizationModel.fromJson(value!.data);
//       emit(OrganizationSuccessState(allOrganizationModel!));
//     }).catchError((error) {
//       emit(OrganizationErrorState(error.toString()));
//     });
//   }

//   BuildingModel? buildingModel;
//   getBuilding(int buildingId) {
//     emit(GetBuildingLoadingState());
//     DioHelper.getData(url: 'buildings/organization/$buildingId').then((value) {
//       buildingModel = BuildingModel.fromJson(value!.data);
//       emit(GetBuildingSuccessState(buildingModel!));
//     }).catchError((error) {
//       emit(GetBuildingErrorState(error.toString()));
//     });
//   }

//   FloorModel? floorModel;
//   getFloor(int floorId) {
//     emit(GetFloorLoadingState());
//     DioHelper.getData(url: 'floors/building/$floorId').then((value) {
//       floorModel = FloorModel.fromJson(value!.data);
//       emit(GetFloorSuccessState(floorModel!));
//     }).catchError((error) {
//       emit(GetFloorErrorState(error.toString()));
//     });
//   }

//   PointsModel? pointModel;
//   getPoints(int pointId) {
//     emit(GetPointLoadingState());
//     DioHelper.getData(url: 'points/floor/$pointId').then((value) {
//       pointModel = PointsModel.fromJson(value!.data);
//       emit(GetPointSuccessState(pointModel!));
//     }).catchError((error) {
//       emit(GetPointErrorState(error.toString()));
//     });
//   }
// }
