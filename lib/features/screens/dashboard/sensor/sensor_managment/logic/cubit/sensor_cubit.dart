import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/widgets/filter/data/model/filter_dialog_data_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/sensor/sensor_managment/data/model/deleted_sensor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/sensor/sensor_managment/data/model/sensor_model.dart';

part 'sensor_state.dart';

class SensorCubit extends Cubit<SensorState> {
  SensorCubit() : super(SensorInitial());

  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  int selectedIndex = 0;
  int currentPage = 1;
  FilterDialogDataModel? filterModel;

  SensorModel? sensorModel;
  getSensorsData() {
    emit(SensorManagementLoading());
    DioHelper.getData(url: "devices", query: {
      'PageNumber': currentPage,
      'PageSize': 15,
      'SearchQuery': searchController.text,
      'ApplicationId': filterModel?.applicationId,
      'AreaId': filterModel?.areaId,
      'CityId': filterModel?.cityId,
      'OrganizationId': filterModel?.organizationId,
      'BuildingId': filterModel?.buildingId,
      'FloorId': filterModel?.floorId,
      'SectionId': filterModel?.sectionId,
      'PointId': filterModel?.pointId,
      'MinBattery': filterModel?.minBattery ?? 0,
      'MaxBattery': filterModel?.maxBattery ?? 100,
      'IsActive': filterModel?.activityStatus,
      'IsAsign': filterModel?.isAsign
    }).then((value) {
      final newUsers = SensorModel.fromJson(value!.data);

      if (currentPage == 1 || sensorModel == null) {
        sensorModel = newUsers;
      } else {
        sensorModel?.data?.data?.addAll(newUsers.data?.data ?? []);
        sensorModel?.data?.currentPage = newUsers.data?.currentPage;
        sensorModel?.data?.totalPages = newUsers.data?.totalPages;
      }

      emit(SensorManagementSuccess(sensorModel!));
    }).catchError((error) {
      emit(SensorManagementError(error.toString()));
    });
  }

  void initialize() {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          currentPage++;
          getSensorsData();
        }
      });
    getSensorsData();
    getAllDeletedSensors();
  }

  void changeTap(int index) {
    selectedIndex = index;

    if (index == 0) {
      if (sensorModel == null) {
        currentPage = 1;
        sensorModel = null;
        getSensorsData();
      } else {
        emit(SensorManagementSuccess(sensorModel!));
      }
    } else {
      if (deletedSensorListModel == null) {
        getAllDeletedSensors();
      } else {
        emit(DeletedSensorsSuccessState(deletedSensorListModel!));
      }
    }
  }

  Future<void> refreshSensors() async {
    currentPage = 1;
    sensorModel = null;
    deletedSensorListModel = null;
    emit(SensorManagementLoading());
    emit(DeletedSensorsLoadingState());
    await getSensorsData();
    await getAllDeletedSensors();
  }

  DeletedSensorListModel? deletedSensorListModel;
  getAllDeletedSensors() {
    emit(DeletedSensorsLoadingState());
    DioHelper.getData(url: 'devices/deleted/index').then((value) {
      deletedSensorListModel = DeletedSensorListModel.fromJson(value!.data);
      emit(DeletedSensorsSuccessState(deletedSensorListModel!));
    }).catchError((error) {
      emit(DeletedSensorsErrorState(error.toString()));
    });
  }

  restoreDeletedSensor(int id) {
    emit(RestoreSensorLoadingState());
    DioHelper.postData(url: 'devices/restore/$id').then((value) {
      final responseMessage = value?.data['message'] ?? "Restored successfully";

      getSensorsData();
      getAllDeletedSensors();

      emit(RestoreSensorSuccessState(responseMessage));
    }).catchError((error) {
      emit(RestoreSensorErrorState(error.toString()));
    });
  }

  String getLastReadText(DateTime? lastSeenAt) {
    if (lastSeenAt == null) return 'N/A';

    final now = DateTime.now();
    final difference = now.difference(lastSeenAt);

    if (difference.inDays >= 1) {
      return '${difference.inDays} Day${difference.inDays > 1 ? 's' : ''}';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} Hr';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} Min';
    } else {
      return 'Just now';
    }
  }
}
