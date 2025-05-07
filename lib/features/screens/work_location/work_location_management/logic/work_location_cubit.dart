import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/widgets/filter/data/model/filter_dialog_data_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_area_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_city_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_organization_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_point_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_section_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/deleted_area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/deleted_building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/deleted_city_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/deleted_floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/deleted_organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/deleted_point_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/deleted_section_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/point_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/section_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_states.dart';

class WorkLocationCubit extends Cubit<WorkLocationState> {
  WorkLocationCubit() : super(OrganizationsInitialState());

  static WorkLocationCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  final formKey = GlobalKey<FormState>();

  int tapIndex = 0;
  int currentPage = 1;
  FilterDialogDataModel? filterModel;
  AreaListModel? areaModel;
  getArea() {
    emit(AreaLoadingState());
    DioHelper.getData(url: ApiConstants.areaUrl, query: {
      'PageNumber': currentPage,
      'PageSize': 15,
      "SearchQuery": searchController.text,
      "Country": filterModel?.country
    }).then((value) {
      final newAreas = AreaListModel.fromJson(value!.data);

      if (currentPage == 1 || areaModel == null) {
        areaModel = newAreas;
      } else {
        areaModel?.data?.data?.addAll(newAreas.data?.data ?? []);
        areaModel?.data?.currentPage = newAreas.data?.currentPage;
        areaModel?.data?.totalPages = newAreas.data?.totalPages;
      }
      emit(AreaSuccessState(areaModel!));
    }).catchError((error) {
      emit(AreaErrorState(error.toString()));
    });
  }

  CityListModel? cityModel;
  getCity() {
    emit(CityLoadingState());
    DioHelper.getData(url: ApiConstants.cityUrl, query: {
      'PageNumber': currentPage,
      'PageSize': 15,
      "SearchQuery": searchController.text,
      "Country": filterModel?.country,
      "Area": filterModel?.areaId
    }).then((value) {
      final newCities = CityListModel.fromJson(value!.data);

      if (currentPage == 1 || cityModel == null) {
        cityModel = newCities;
      } else {
        cityModel?.data?.data?.addAll(newCities.data?.data ?? []);
        cityModel?.data?.currentPage = newCities.data?.currentPage;
        cityModel?.data?.totalPages = newCities.data?.totalPages;
      }
      emit(CitySuccessState(cityModel!));
    }).catchError((error) {
      emit(CityErrorState(error.toString()));
    });
  }

  OrganizationListModel? organizationModel;
  getOrganization() {
    emit(OrganizationLoadingState());
    DioHelper.getData(url: ApiConstants.organizationUrl, query: {
      'PageNumber': currentPage,
      'PageSize': 15,
      "SearchQuery": searchController.text,
      "Area": filterModel?.areaId,
      "City": filterModel?.cityId,
    }).then((value) {
      final newOrganizations = OrganizationListModel.fromJson(value!.data);

      if (currentPage == 1 || organizationModel == null) {
        organizationModel = newOrganizations;
      } else {
        organizationModel?.data?.data
            ?.addAll(newOrganizations.data?.data ?? []);
        organizationModel?.data?.currentPage =
            newOrganizations.data?.currentPage;
        organizationModel?.data?.totalPages = newOrganizations.data?.totalPages;
      }
      emit(OrganizationSuccessState(organizationModel!));
    }).catchError((error) {
      emit(OrganizationErrorState(error.toString()));
    });
  }

  BuildingListModel? buildingModel;
  getBuilding() {
    emit(BuildingLoadingState());
    DioHelper.getData(url: ApiConstants.buildingUrl, query: {
      'PageNumber': currentPage,
      'PageSize': 15,
      "SearchQuery": searchController.text,
      "CityId": filterModel?.cityId,
      "OrganizationId": filterModel?.organizationId,
    }).then((value) {
      final newBuildings = BuildingListModel.fromJson(value!.data);

      if (currentPage == 1 || buildingModel == null) {
        buildingModel = newBuildings;
      } else {
        buildingModel?.data?.data?.addAll(newBuildings.data?.data ?? []);
        buildingModel?.data?.currentPage = newBuildings.data?.currentPage;
        buildingModel?.data?.totalPages = newBuildings.data?.totalPages;
      }
      emit(BuildingSuccessState(buildingModel!));
    }).catchError((error) {
      emit(BuildingErrorState(error.toString()));
    });
  }

  FloorListModel? floorModel;
  getFloor() {
    emit(FloorLoadingState());
    DioHelper.getData(url: ApiConstants.floorUrl, query: {
      'PageNumber': currentPage,
      'PageSize': 15,
      "SearchQuery": searchController.text,
      "OrganizationId": filterModel?.organizationId,
      "BuildingId": filterModel?.buildingId,
    }).then((value) {
      final newFloors = FloorListModel.fromJson(value!.data);

      if (currentPage == 1 || floorModel == null) {
        floorModel = newFloors;
      } else {
        floorModel?.data?.data?.addAll(newFloors.data?.data ?? []);
        floorModel?.data?.currentPage = newFloors.data?.currentPage;
        floorModel?.data?.totalPages = newFloors.data?.totalPages;
      }
      emit(FloorSuccessState(floorModel!));
    }).catchError((error) {
      emit(FloorErrorState(error.toString()));
    });
  }

  SectionListModel? sectionModel;
  getSection() {
    emit(SectionLoadingState());
    DioHelper.getData(url: ApiConstants.sectionUrl, query: {
      'PageNumber': currentPage,
      'PageSize': 15,
      "SearchQuery": searchController.text,
      "BuildingId": filterModel?.buildingId,
      "FloorId": filterModel?.floorId,
    }).then((value) {
      final newSections = SectionListModel.fromJson(value!.data);

      if (currentPage == 1 || sectionModel == null) {
        sectionModel = newSections;
      } else {
        sectionModel?.data?.data?.addAll(newSections.data?.data ?? []);
        sectionModel?.data?.currentPage = newSections.data?.currentPage;
        sectionModel?.data?.totalPages = newSections.data?.totalPages;
      }
      emit(SectionSuccessState(sectionModel!));
    }).catchError((error) {
      emit(SectionErrorState(error.toString()));
    });
  }

  PointListModel? pointModel;
  getPoint() {
    emit(PointLoadingState());
    DioHelper.getData(url: ApiConstants.pointUrl, query: {
      'PageNumber': currentPage,
      'PageSize': 15,
      "SearchQuery": searchController.text,
      "FloorId": filterModel?.floorId,
      "SectionId": filterModel?.sectionId,
    }).then((value) {
      final newPoints = PointListModel.fromJson(value!.data);

      if (currentPage == 1 || pointModel == null) {
        pointModel = newPoints;
      } else {
        pointModel?.data?.data?.addAll(newPoints.data?.data ?? []);
        pointModel?.data?.currentPage = newPoints.data?.currentPage;
        pointModel?.data?.totalPages = newPoints.data?.totalPages;
      }
      emit(PointSuccessState(pointModel!));
    }).catchError((error) {
      emit(PointErrorState(error.toString()));
    });
  }

  initialize(int? selectedIndex) {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          currentPage++;
          if (selectedIndex == 0) {
            getArea();
          } else if (selectedIndex == 1) {
            getCity();
          } else if (selectedIndex == 2) {
            getOrganization();
          } else if (selectedIndex == 3) {
            getBuilding();
          } else if (selectedIndex == 4) {
            getFloor();
          } else if (selectedIndex == 5) {
            getSection();
          } else {
            getPoint();
          }
        }
      });
    if (selectedIndex == 0) {
      getArea();
      getAllDeletedArea();
    } else if (selectedIndex == 1) {
      getCity();
      getAllDeletedCity();
    } else if (selectedIndex == 2) {
      getOrganization();
      getAllDeletedOrganization();
    } else if (selectedIndex == 3) {
      getBuilding();
      getAllDeletedBuilding();
    } else if (selectedIndex == 4) {
      getFloor();
      getAllDeletedFloor();
    } else if (selectedIndex == 5) {
      getSection();
      getAllDeletedSection();
    } else {
      getPoint();
      getAllDeletedPoint();
    }
  }

  int selectedIndex = 0;
  void changeTap(int index) {
    tapIndex = index;

    if (selectedIndex == 0) {
      if (index == 0) {
        if (areaModel == null) {
          currentPage = 1;
          areaModel = null;
          getArea();
        } else {
          emit(AreaSuccessState(areaModel!));
        }
      } else {
        if (deletedAreaList == null) {
          getAllDeletedArea();
        } else {
          emit(DeletedAreaSuccessState(deletedAreaList!));
        }
      }
    } else if (selectedIndex == 1) {
      if (index == 0) {
        if (cityModel == null) {
          currentPage = 1;
          cityModel = null;
          getCity();
        } else {
          emit(CitySuccessState(cityModel!));
        }
      } else {
        if (deletedCityList == null) {
          getAllDeletedCity();
        } else {
          emit(DeletedCitySuccessState(deletedCityList!));
        }
      }
    } else if (selectedIndex == 2) {
      if (index == 0) {
        if (organizationModel == null) {
          currentPage = 1;
          organizationModel = null;
          getOrganization();
        } else {
          emit(OrganizationSuccessState(organizationModel!));
        }
      } else {
        if (deletedOrganizationList == null) {
          getAllDeletedOrganization();
        } else {
          emit(DeletedOrganizationSuccessState(deletedOrganizationList!));
        }
      }
    } else if (selectedIndex == 3) {
      if (index == 0) {
        if (buildingModel == null) {
          currentPage = 1;
          buildingModel = null;
          getBuilding();
        } else {
          emit(BuildingSuccessState(buildingModel!));
        }
      } else {
        if (deletedBuildingList == null) {
          getAllDeletedBuilding();
        } else {
          emit(DeletedBuildingSuccessState(deletedBuildingList!));
        }
      }
    } else if (selectedIndex == 4) {
      if (index == 0) {
        if (floorModel == null) {
          currentPage = 1;
          floorModel = null;
          getFloor();
        } else {
          emit(FloorSuccessState(floorModel!));
        }
      } else {
        if (deletedFloorList == null) {
          getAllDeletedFloor();
        } else {
          emit(DeletedFloorSuccessState(deletedFloorList!));
        }
      }
    } else if (selectedIndex == 5) {
      if (index == 0) {
        if (sectionModel == null) {
          currentPage = 1;
          sectionModel = null;
          getSection();
        } else {
          emit(SectionSuccessState(sectionModel!));
        }
      } else {
        if (deletedSectionList == null) {
          getAllDeletedSection();
        } else {
          emit(DeletedSectionSuccessState(deletedSectionList!));
        }
      }
    } else if (selectedIndex == 6) {
      if (index == 0) {
        if (pointModel == null) {
          currentPage = 1;
          pointModel = null;
          getPoint();
        } else {
          emit(PointSuccessState(pointModel!));
        }
      } else {
        if (deletedPointList == null) {
          getAllDeletedPoint();
        } else {
          emit(DeletedPointSuccessState(deletedPointList!));
        }
      }
    }
  }

  int getActiveCount(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return areaModel?.data?.totalCount ?? 0;
      case 1:
        return cityModel?.data?.totalCount ?? 0;
      case 2:
        return organizationModel?.data?.totalCount ?? 0;
      case 3:
        return buildingModel?.data?.totalCount ?? 0;
      case 4:
        return floorModel?.data?.totalCount ?? 0;
      case 5:
        return sectionModel?.data?.totalCount ?? 0;
      case 6:
        return pointModel?.data?.totalCount ?? 0;
      default:
        return 0;
    }
  }

  int getDeletedCount(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return deletedAreaList?.data?.length ?? 0;
      case 1:
        return deletedCityList?.data?.length ?? 0;
      case 2:
        return deletedOrganizationList?.data?.length ?? 0;
      case 3:
        return deletedBuildingList?.data?.length ?? 0;
      case 4:
        return deletedFloorList?.data?.length ?? 0;
      case 5:
        return deletedSectionList?.data?.length ?? 0;
      case 6:
        return deletedPointList?.data?.length ?? 0;
      default:
        return 0;
    }
  }

//**************************** */
  DeleteAreaModel? deleteAreaModel;
  List<AreaItem> deletedAreas = [];
  deleteArea(int id) {
    emit(AreaDeleteLoadingState());
    DioHelper.postData(url: 'areas/delete/$id', data: {'id': id}).then((value) {
      deleteAreaModel = DeleteAreaModel.fromJson(value!.data);

      final deletedArea = areaModel?.data?.data?.firstWhere(
        (user) => user.id == id,
      );

      if (deletedArea != null) {
        // Remove from main list
        areaModel?.data?.data?.removeWhere((user) => user.id == id);

        // Add to deleted list
        deletedAreas.insert(0, deletedArea);

        //  Reload current page to refill to 10 users
        if (currentPage == 1) {
          areaModel = null;
          getArea();
        }
      }
      emit(AreaDeleteSuccessState(deleteAreaModel!));
    }).catchError((error) {
      emit(AreaDeleteErrorState(error.toString()));
    });
  }

  DeleteCityModel? deleteCityModel;
  List<CityItem> deletedCitys = [];
  deleteCity(int id) {
    emit(CityDeleteLoadingState());
    DioHelper.postData(url: 'cities/delete/$id', data: {'id': id})
        .then((value) {
      deleteCityModel = DeleteCityModel.fromJson(value!.data);

      final deletedCity = cityModel?.data?.data?.firstWhere(
        (user) => user.id == id,
      );

      if (deletedCity != null) {
        // Remove from main list
        cityModel?.data?.data?.removeWhere((user) => user.id == id);

        // Add to deleted list
        deletedCitys.insert(0, deletedCity);

        //  Reload current page to refill to 10 users
        if (currentPage == 1) {
          cityModel = null;
          getCity();
        }
      }
      emit(CityDeleteSuccessState(deleteCityModel!));
    }).catchError((error) {
      emit(CityDeleteErrorState(error.toString()));
    });
  }

  DeleteOrganizationModel? deleteOrganizationModel;
  List<OrganizationItem> deletedOrganizations = [];
  deleteOrganization(int id) {
    emit(OrganizationDeleteLoadingState());
    DioHelper.postData(url: 'organizations/delete/$id', data: {'id': id})
        .then((value) {
      deleteOrganizationModel = DeleteOrganizationModel.fromJson(value!.data);

      final deletedOrganization = organizationModel?.data?.data?.firstWhere(
        (user) => user.id == id,
      );

      if (deletedOrganization != null) {
        // Remove from main list
        organizationModel?.data?.data?.removeWhere((user) => user.id == id);

        // Add to deleted list
        deletedOrganizations.insert(0, deletedOrganization);

        //  Reload current page to refill to 10 users
        if (currentPage == 1) {
          organizationModel = null;
          getOrganization();
        }
      }
      emit(OrganizationDeleteSuccessState(deleteOrganizationModel!));
    }).catchError((error) {
      emit(OrganizationDeleteErrorState(error.toString()));
    });
  }

  DeleteBuildingModel? deleteBuildingModel;
  List<BuildingItem> deletedBuildings = [];
  deleteBuilding(int id) {
    emit(BuildingDeleteLoadingState());
    DioHelper.postData(url: 'buildings/delete/$id', data: {'id': id})
        .then((value) {
      deleteBuildingModel = DeleteBuildingModel.fromJson(value!.data);

      final deletedBuilding = buildingModel?.data?.data?.firstWhere(
        (user) => user.id == id,
      );

      if (deletedBuilding != null) {
        // Remove from main list
        buildingModel?.data?.data?.removeWhere((user) => user.id == id);

        // Add to deleted list
        deletedBuildings.insert(0, deletedBuilding);

        //  Reload current page to refill to 10 users
        if (currentPage == 1) {
          buildingModel = null;
          getBuilding();
        }
      }
      emit(BuildingDeleteSuccessState(deleteBuildingModel!));
    }).catchError((error) {
      emit(BuildingDeleteErrorState(error.toString()));
    });
  }

  DeleteFloorModel? deleteFloorModel;
  List<FloorItem> deletedFloors = [];
  deleteFloor(int id) {
    emit(FloorDeleteLoadingState());
    DioHelper.postData(url: 'floors/delete/$id', data: {'id': id})
        .then((value) {
      deleteFloorModel = DeleteFloorModel.fromJson(value!.data);

      final deletedFloor = floorModel?.data?.data?.firstWhere(
        (user) => user.id == id,
      );

      if (deletedFloor != null) {
        // Remove from main list
        floorModel?.data?.data?.removeWhere((user) => user.id == id);

        // Add to deleted list
        deletedFloors.insert(0, deletedFloor);

        //  Reload current page to refill to 10 users
        if (currentPage == 1) {
          floorModel = null;
          getFloor();
        }
      }
      emit(FloorDeleteSuccessState(deleteFloorModel!));
    }).catchError((error) {
      emit(FloorDeleteErrorState(error.toString()));
    });
  }

  DeleteSectionModel? deleteSectionModel;
  List<SectionItem> deletedSections = [];
  deleteSection(int id) {
    emit(SectionDeleteLoadingState());
    DioHelper.postData(url: 'sections/delete/$id', data: {'id': id})
        .then((value) {
      deleteSectionModel = DeleteSectionModel.fromJson(value!.data);

      final deletedSection = sectionModel?.data?.data?.firstWhere(
        (user) => user.id == id,
      );

      if (deletedSection != null) {
        // Remove from main list
        sectionModel?.data?.data?.removeWhere((user) => user.id == id);

        // Add to deleted list
        deletedSections.insert(0, deletedSection);

        //  Reload current page to refill to 10 users
        if (currentPage == 1) {
          sectionModel = null;
          getSection();
        }
      }
      emit(SectionDeleteSuccessState(deleteSectionModel!));
    }).catchError((error) {
      emit(SectionDeleteErrorState(error.toString()));
    });
  }

  DeletePointModel? deletePointModel;
  List<PointItem> deletedPoints = [];
  deletePoint(int id) {
    emit(PointDeleteLoadingState());
    DioHelper.postData(url: 'points/delete/$id', data: {'id': id})
        .then((value) {
      deletePointModel = DeletePointModel.fromJson(value!.data);

      final deletedPoint = pointModel?.data?.data?.firstWhere(
        (user) => user.id == id,
      );

      if (deletedPoint != null) {
        // Remove from main list
        pointModel?.data?.data?.removeWhere((user) => user.id == id);

        // Add to deleted list
        deletedPoints.insert(0, deletedPoint);

        //  Reload current page to refill to 10 users
        if (currentPage == 1) {
          pointModel = null;
          getPoint();
        }
      }
      emit(PointDeleteSuccessState(deletePointModel!));
    }).catchError((error) {
      emit(PointDeleteErrorState(error.toString()));
    });
  }

//****************************** */
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

  DeletedSectionList? deletedSectionList;
  getAllDeletedSection() {
    emit(DeletedSectionLoadingState());
    DioHelper.getData(url: ApiConstants.allDeletedSectionList).then((value) {
      deletedSectionList = DeletedSectionList.fromJson(value!.data);
      emit(DeletedSectionSuccessState(deletedSectionList!));
    }).catchError((error) {
      emit(DeletedSectionErrorState(error.toString()));
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
      // Find and process the restored user
      final restoredData = deletedAreaList?.data?.firstWhere(
        (data) => data.id == id,
      );

      if (restoredData != null) {
        // Remove from deleted list
        deletedAreaList?.data?.removeWhere((data) => data.id == id);

        // Initialize users list if null
        areaModel?.data?.data ??= [];

        // Convert to User object
        final restoredUser = AreaItem.fromJson(restoredData.toJson());

        // Find the correct position to insert (sorted by ID)
        int insertIndex = areaModel!.data!.data!
            .indexWhere((user) => user.id! > restoredUser.id!);

        // If not found, add to end
        if (insertIndex == -1) insertIndex = areaModel!.data!.data!.length;

        // Insert at correct position
        areaModel?.data?.data?.insert(insertIndex, restoredUser);

        // Update pagination metadata
        areaModel?.data?.totalCount = (areaModel?.data?.totalCount ?? 0) + 1;
        areaModel?.data?.totalPages = ((areaModel?.data?.totalCount ?? 0) /
                (areaModel?.data?.pageSize ?? 10))
            .ceil();
      }
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
      // Find and process the restored user
      final restoredData = deletedCityList?.data?.firstWhere(
        (data) => data.id == id,
      );

      if (restoredData != null) {
        // Remove from deleted list
        deletedCityList?.data?.removeWhere((data) => data.id == id);

        // Initialize users list if null
        cityModel?.data?.data ??= [];

        // Convert to User object
        final restoredUser = CityItem.fromJson(restoredData.toJson());

        // Find the correct position to insert (sorted by ID)
        int insertIndex = cityModel!.data!.data!
            .indexWhere((user) => user.id! > restoredUser.id!);

        // If not found, add to end
        if (insertIndex == -1) insertIndex = cityModel!.data!.data!.length;

        // Insert at correct position
        cityModel?.data?.data?.insert(insertIndex, restoredUser);

        // Update pagination metadata
        cityModel?.data?.totalCount = (cityModel?.data?.totalCount ?? 0) + 1;
        cityModel?.data?.totalPages = ((cityModel?.data?.totalCount ?? 0) /
                (cityModel?.data?.pageSize ?? 10))
            .ceil();
      }
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
      // Find and process the restored user
      final restoredData = deletedOrganizationList?.data?.firstWhere(
        (data) => data.id == id,
      );

      if (restoredData != null) {
        // Remove from deleted list
        deletedOrganizationList?.data?.removeWhere((data) => data.id == id);

        // Initialize users list if null
        organizationModel?.data?.data ??= [];

        // Convert to User object
        final restoredUser = OrganizationItem.fromJson(restoredData.toJson());

        // Find the correct position to insert (sorted by ID)
        int insertIndex = organizationModel!.data!.data!
            .indexWhere((user) => user.id! > restoredUser.id!);

        // If not found, add to end
        if (insertIndex == -1)
          insertIndex = organizationModel!.data!.data!.length;

        // Insert at correct position
        organizationModel?.data?.data?.insert(insertIndex, restoredUser);

        // Update pagination metadata
        organizationModel?.data?.totalCount =
            (organizationModel?.data?.totalCount ?? 0) + 1;
        organizationModel?.data?.totalPages =
            ((organizationModel?.data?.totalCount ?? 0) /
                    (organizationModel?.data?.pageSize ?? 10))
                .ceil();
      }
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
      // Find and process the restored user
      final restoredData = deletedBuildingList?.data?.firstWhere(
        (data) => data.id == id,
      );

      if (restoredData != null) {
        // Remove from deleted list
        deletedBuildingList?.data?.removeWhere((data) => data.id == id);

        // Initialize users list if null
        buildingModel?.data?.data ??= [];

        // Convert to User object
        final restoredUser = BuildingItem.fromJson(restoredData.toJson());

        // Find the correct position to insert (sorted by ID)
        int insertIndex = buildingModel!.data!.data!
            .indexWhere((user) => user.id! > restoredUser.id!);

        // If not found, add to end
        if (insertIndex == -1) insertIndex = buildingModel!.data!.data!.length;

        // Insert at correct position
        buildingModel?.data?.data?.insert(insertIndex, restoredUser);

        // Update pagination metadata
        buildingModel?.data?.totalCount =
            (buildingModel?.data?.totalCount ?? 0) + 1;
        buildingModel?.data?.totalPages =
            ((buildingModel?.data?.totalCount ?? 0) /
                    (buildingModel?.data?.pageSize ?? 10))
                .ceil();
      }
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
      // Find and process the restored user
      final restoredData = deletedFloorList?.data?.firstWhere(
        (data) => data.id == id,
      );

      if (restoredData != null) {
        // Remove from deleted list
        deletedFloorList?.data?.removeWhere((data) => data.id == id);

        // Initialize users list if null
        floorModel?.data?.data ??= [];

        // Convert to User object
        final restoredUser = FloorItem.fromJson(restoredData.toJson());

        // Find the correct position to insert (sorted by ID)
        int insertIndex = floorModel!.data!.data!
            .indexWhere((user) => user.id! > restoredUser.id!);

        // If not found, add to end
        if (insertIndex == -1) insertIndex = floorModel!.data!.data!.length;

        // Insert at correct position
        floorModel?.data?.data?.insert(insertIndex, restoredUser);

        // Update pagination metadata
        floorModel?.data?.totalCount = (floorModel?.data?.totalCount ?? 0) + 1;
        floorModel?.data?.totalPages = ((floorModel?.data?.totalCount ?? 0) /
                (floorModel?.data?.pageSize ?? 10))
            .ceil();
      }
      emit(DeleteRestoreFloorSuccessState(message));
    }).catchError((error) {
      emit(DeleteRestoreFloorErrorState(error.toString()));
    });
  }

  restoreDeletedSection(int id) {
    emit(DeleteRestoreSectionLoadingState());
    DioHelper.postData(url: 'sections/restore/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      // Find and process the restored user
      final restoredData = deletedSectionList?.data?.firstWhere(
        (data) => data.id == id,
      );

      if (restoredData != null) {
        // Remove from deleted list
        deletedSectionList?.data?.removeWhere((data) => data.id == id);

        // Initialize users list if null
        sectionModel?.data?.data ??= [];

        // Convert to User object
        final restoredUser = SectionItem.fromJson(restoredData.toJson());

        // Find the correct position to insert (sorted by ID)
        int insertIndex = sectionModel!.data!.data!
            .indexWhere((user) => user.id! > restoredUser.id!);

        // If not found, add to end
        if (insertIndex == -1) insertIndex = sectionModel!.data!.data!.length;

        // Insert at correct position
        sectionModel?.data?.data?.insert(insertIndex, restoredUser);

        // Update pagination metadata
        sectionModel?.data?.totalCount =
            (sectionModel?.data?.totalCount ?? 0) + 1;
        sectionModel?.data?.totalPages =
            ((sectionModel?.data?.totalCount ?? 0) /
                    (sectionModel?.data?.pageSize ?? 10))
                .ceil();
      }
      emit(DeleteRestoreSectionSuccessState(message));
    }).catchError((error) {
      emit(DeleteRestoreSectionErrorState(error.toString()));
    });
  }

  restoreDeletedPoint(int id) {
    emit(DeleteRestorePointLoadingState());
    DioHelper.postData(url: 'points/restore/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      // Find and process the restored user
      final restoredData = deletedPointList?.data?.firstWhere(
        (data) => data.id == id,
      );

      if (restoredData != null) {
        // Remove from deleted list
        deletedPointList?.data?.removeWhere((data) => data.id == id);

        // Initialize users list if null
        pointModel?.data?.data ??= [];

        // Convert to User object
        final restoredUser = PointItem.fromJson(restoredData.toJson());

        // Find the correct position to insert (sorted by ID)
        int insertIndex = pointModel!.data!.data!
            .indexWhere((user) => user.id! > restoredUser.id!);

        // If not found, add to end
        if (insertIndex == -1) insertIndex = pointModel!.data!.data!.length;

        // Insert at correct position
        pointModel?.data?.data?.insert(insertIndex, restoredUser);

        // Update pagination metadata
        pointModel?.data?.totalCount = (pointModel?.data?.totalCount ?? 0) + 1;
        pointModel?.data?.totalPages = ((pointModel?.data?.totalCount ?? 0) /
                (pointModel?.data?.pageSize ?? 10))
            .ceil();
      }
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

  forcedDeletedSection(int id) {
    emit(DeleteForceSectionLoadingState());
    DioHelper.deleteData(url: 'sections/forcedelete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "forced deleted successfully";
      emit(DeleteForceSectionSuccessState(message));
    }).catchError((error) {
      emit(DeleteForceSectionErrorState(error.toString()));
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

  List<String> tapList = [
    "Areas",
    "Cities",
    "Organizations",
    "Buildings",
    "Floors",
    "Sections",
    "Points",
  ];
}
