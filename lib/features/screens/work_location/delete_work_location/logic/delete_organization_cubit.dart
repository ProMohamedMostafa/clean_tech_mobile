import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/work_location/delete_work_location/data/model/deleted_area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/delete_work_location/data/model/deleted_building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/delete_work_location/data/model/deleted_city_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/delete_work_location/data/model/deleted_floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/delete_work_location/data/model/deleted_organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/delete_work_location/data/model/deleted_point_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/delete_work_location/logic/delete_organization_state.dart';

class DeleteOrganizationsCubit extends Cubit<DeleteOrganizationsState> {
  DeleteOrganizationsCubit() : super(DeleteOrganizationsInitialState());

  static DeleteOrganizationsCubit get(context) => BlocProvider.of(context);

  DeletedAreaList? deletedAreaList;
  getAllDeletedArea() {
    emit(DeletedAreaLoadingState());
    DioHelper.getData(url: ApiConstants.allDeletedAreaList).then((value) {
      deletedAreaList = DeletedAreaList.fromJson(value!.data);
      emit(DeletedAreaSuccessState(deletedAreaList!));
    }).catchError((error) {
      emit(DeletedAreaErrorState(error.toString()));
    });
  }

  DeletedCityList? deletedCityList;
  getAllDeletedCity() {
    emit(DeletedCityLoadingState());
    DioHelper.getData(url: ApiConstants.allDeletedCityList).then((value) {
      deletedCityList = DeletedCityList.fromJson(value!.data);
      emit(DeletedCitySuccessState(deletedCityList!));
    }).catchError((error) {
      emit(DeletedCityErrorState(error.toString()));
    });
  }

  DeletedOrganizationList? deletedOrganizationList;
  getAllDeletedOrganization() {
    emit(DeletedOrganizationLoadingState());
    DioHelper.getData(url: ApiConstants.allDeletedOrganizationList)
        .then((value) {
      deletedOrganizationList = DeletedOrganizationList.fromJson(value!.data);
      emit(DeletedOrganizationSuccessState(deletedOrganizationList!));
    }).catchError((error) {
      emit(DeletedOrganizationErrorState(error.toString()));
    });
  }

  DeletedBuildingList? deletedBuildingList;
  getAllDeletedBuilding() {
    emit(DeletedBuildingLoadingState());
    DioHelper.getData(url: ApiConstants.allDeletedBuildingList).then((value) {
      deletedBuildingList = DeletedBuildingList.fromJson(value!.data);
      emit(DeletedBuildingSuccessState(deletedBuildingList!));
    }).catchError((error) {
      emit(DeletedBuildingErrorState(error.toString()));
    });
  }

  DeletedFloorList? deletedFloorList;
  getAllDeletedFloor() {
    emit(DeletedFloorLoadingState());
    DioHelper.getData(url: ApiConstants.allDeletedFloorList).then((value) {
      deletedFloorList = DeletedFloorList.fromJson(value!.data);
      emit(DeletedFloorSuccessState(deletedFloorList!));
    }).catchError((error) {
      emit(DeletedFloorErrorState(error.toString()));
    });
  }

  DeletedPointList? deletedPointList;
  getAllDeletedPoint() {
    emit(DeletedPointLoadingState());
    DioHelper.getData(url: ApiConstants.allDeletedPointList).then((value) {
      deletedPointList = DeletedPointList.fromJson(value!.data);
      emit(DeletedPointSuccessState(deletedPointList!));
    }).catchError((error) {
      emit(DeletedPointErrorState(error.toString()));
    });
  }

  ///************************* */

  restoreDeletedArea(int id) {
    emit(DeleteRestoreAreaLoadingState());
    DioHelper.postData(url: 'areas/restore/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(DeleteRestoreAreaSuccessState(message));
    }).catchError((error) {
      emit(DeleteRestoreAreaErrorState(error.toString()));
    });
  }

  restoreDeletedCity(int id) {
    emit(DeleteRestoreCityLoadingState());
    DioHelper.postData(url: 'cities/restore/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(DeleteRestoreCitySuccessState(message));
    }).catchError((error) {
      emit(DeleteRestoreCityErrorState(error.toString()));
    });
  }

  restoreDeletedOrganization(int id) {
    emit(DeleteRestoreOrganizationLoadingState());
    DioHelper.postData(url: 'organizations/restore/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(DeleteRestoreOrganizationSuccessState(message));
    }).catchError((error) {
      emit(DeleteRestoreOrganizationErrorState(error.toString()));
    });
  }

  restoreDeletedBuilding(int id) {
    emit(DeleteRestoreBuildingLoadingState());
    DioHelper.postData(url: 'buildings/restore/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(DeleteRestoreBuildingSuccessState(message));
    }).catchError((error) {
      emit(DeleteRestoreBuildingErrorState(error.toString()));
    });
  }

  restoreDeletedFloor(int id) {
    emit(DeleteRestoreFloorLoadingState());
    DioHelper.postData(url: 'floors/restore/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(DeleteRestoreFloorSuccessState(message));
    }).catchError((error) {
      emit(DeleteRestoreFloorErrorState(error.toString()));
    });
  }

  restoreDeletedPoint(int id) {
    emit(DeleteRestorePointLoadingState());
    DioHelper.postData(url: 'points/restore/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(DeleteRestorePointSuccessState(message));
    }).catchError((error) {
      emit(DeleteRestorePointErrorState(error.toString()));
    });
  }

  ///************************* */

  forcedDeletedArea(int id) {
    emit(DeleteForceAreaLoadingState());
    DioHelper.deleteData(url: 'areas/forcedelete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "forced deleted successfully";
      emit(DeleteForceAreaSuccessState(message));
    }).catchError((error) {
      emit(DeleteForceAreaErrorState(error.toString()));
    });
  }

  forcedDeletedCity(int id) {
    emit(DeleteForceCityLoadingState());
    DioHelper.deleteData(url: 'cities/forcedelete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "forced deleted successfully";
      emit(DeleteForceCitySuccessState(message));
    }).catchError((error) {
      emit(DeleteForceCityErrorState(error.toString()));
    });
  }

  forcedDeletedOrganization(int id) {
    emit(DeleteForceOrganizationLoadingState());
    DioHelper.deleteData(url: 'organizations/forcedelete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "forced deleted successfully";
      emit(DeleteForceOrganizationSuccessState(message));
    }).catchError((error) {
      emit(DeleteForceOrganizationErrorState(error.toString()));
    });
  }

  forcedDeletedBuilding(int id) {
    emit(DeleteForceBuildingLoadingState());
    DioHelper.deleteData(url: 'buildings/forcedelete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "forced deleted successfully";
      emit(DeleteForceBuildingSuccessState(message));
    }).catchError((error) {
      emit(DeleteForceBuildingErrorState(error.toString()));
    });
  }

  forcedDeletedFloor(int id) {
    emit(DeleteForceFloorLoadingState());
    DioHelper.deleteData(url: 'floors/forcedelete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "forced deleted successfully";
      emit(DeleteForceFloorSuccessState(message));
    }).catchError((error) {
      emit(DeleteForceFloorErrorState(error.toString()));
    });
  }

  forcedDeletedPoint(int id) {
    emit(DeleteForcePointLoadingState());
    DioHelper.deleteData(url: 'points/forcedelete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "forced deleted successfully";
      emit(DeleteForcePointSuccessState(message));
    }).catchError((error) {
      emit(DeleteForcePointErrorState(error.toString()));
    });
  }
}
