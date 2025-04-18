import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/data/models/attendance_history_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/data/models/attendance_leaves_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/data/models/all_tasks_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/area_users_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/building_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/city_users_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/floor_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/section_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/area_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/building_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/city_tree_model.dart';
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
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/floor_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/point_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/section_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/section_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_states.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/organization_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/point_users_details_model.dart';

class WorkLocationCubit extends Cubit<WorkLocationState> {
  WorkLocationCubit() : super(OrganizationsInitialState());

  static WorkLocationCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  ScrollController scrollController = ScrollController();

  final formKey = GlobalKey<FormState>();
  int currentPage = 1;

  AreaListModel? areaModel;
  getArea({String? country}) {
    emit(AreaLoadingState());
    DioHelper.getData(url: ApiConstants.areaUrl, query: {
      'PageNumber': currentPage,
      'PageSize': 10,
      "search": searchController.text,
      "country": countryController.text
    }).then((value) {
      final newAreas = AreaListModel.fromJson(value!.data);

      if (areaModel == null) {
        areaModel = newAreas;
      } else {
        areaModel?.data?.areas?.addAll(newAreas.data?.areas ?? []);
        areaModel?.data?.currentPage = newAreas.data?.currentPage;
        areaModel?.data?.totalPages = newAreas.data?.totalPages;
      }
      emit(AreaSuccessState(areaModel!));
    }).catchError((error) {
      emit(AreaErrorState(error.toString()));
    });
  }

  CityListModel? cityModel;
  getCity({String? country, int? areaId}) {
    emit(CityLoadingState());
    DioHelper.getData(url: ApiConstants.cityUrl, query: {
      'PageNumber': currentPage,
      'PageSize': 10,
      "search": searchController.text,
      "country": countryController.text,
      "area": areaId
    }).then((value) {
      final newCities = CityListModel.fromJson(value!.data);

      if (cityModel == null) {
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
  getOrganization({int? areaId, int? cityId}) {
    emit(OrganizationLoadingState());
    DioHelper.getData(url: ApiConstants.organizationUrl, query: {
      'PageNumber': currentPage,
      'PageSize': 10,
      "search": searchController.text,
      "area": areaId,
      "city": cityId,
    }).then((value) {
      final newOrganizations = OrganizationListModel.fromJson(value!.data);

      if (organizationModel == null) {
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
  getBuilding({int? cityId, int? organizationId}) {
    emit(BuildingLoadingState());
    DioHelper.getData(url: ApiConstants.buildingUrl, query: {
      'PageNumber': currentPage,
      'PageSize': 10,
      "search": searchController.text,
      "city": cityId,
      "organization": organizationId,
    }).then((value) {
      final newBuildings = BuildingListModel.fromJson(value!.data);

      if (buildingModel == null) {
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
  getFloor({int? organizationId, int? buildingId}) {
    emit(FloorLoadingState());
    DioHelper.getData(url: ApiConstants.floorUrl, query: {
      'PageNumber': currentPage,
      'PageSize': 10,
      "search": searchController.text,
      "organization": organizationId,
      "building": buildingId,
    }).then((value) {
      final newFloors = FloorListModel.fromJson(value!.data);

      if (floorModel == null) {
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
  getSection({int? buildingId, int? floorId}) {
    emit(SectionLoadingState());
    DioHelper.getData(url: ApiConstants.sectionUrl, query: {
      'PageNumber': currentPage,
      'PageSize': 10,
      "search": searchController.text,
      "building": buildingId,
      "floor": floorId,
    }).then((value) {
      final newSections = SectionListModel.fromJson(value!.data);

      if (sectionModel == null) {
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
  getPoint({int? sectionId, int? floorId}) {
    emit(PointLoadingState());
    DioHelper.getData(url: ApiConstants.pointUrl, query: {
      'PageNumber': currentPage,
      'PageSize': 10,
      "search": searchController.text,
      "floor": floorId,
      "section": sectionId,
    }).then((value) {
      final newPoints = PointListModel.fromJson(value!.data);

      if (pointModel == null) {
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
  }

  AreaUsersDetailsModel? areaUsersDetailsModel;
  getAreaUsersDetails(int areaId) {
    emit(AreaUsersDetailsLoadingState());
    DioHelper.getData(url: 'areas/with-user/$areaId').then((value) {
      areaUsersDetailsModel = AreaUsersDetailsModel.fromJson(value!.data);
      emit(AreaUsersDetailsSuccessState(areaUsersDetailsModel!));
    }).catchError((error) {
      emit(AreaUsersDetailsErrorState(error.toString()));
    });
  }

  CityUsersDetailsModel? cityUsersDetailsModel;
  getCityUsersDetails(int cityId) {
    emit(CityUsersDetailsLoadingState());
    DioHelper.getData(url: 'cities/with-user/$cityId').then((value) {
      cityUsersDetailsModel = CityUsersDetailsModel.fromJson(value!.data);
      emit(CityUsersDetailsSuccessState(cityUsersDetailsModel!));
    }).catchError((error) {
      emit(CityUsersDetailsErrorState(error.toString()));
    });
  }

  OrganizationUsersShiftsDetailsModel? organizationUsersShiftDetailsModel;
  getOrganizationUsersDetails(int organizationId) {
    emit(OrganizationUsersDetailsLoadingState());
    DioHelper.getData(url: 'organizations/with-user-shift/$organizationId')
        .then((value) {
      organizationUsersShiftDetailsModel =
          OrganizationUsersShiftsDetailsModel.fromJson(value!.data);
      emit(OrganizationUsersDetailsSuccessState(
          organizationUsersShiftDetailsModel!));
    }).catchError((error) {
      emit(OrganizationUsersDetailsErrorState(error.toString()));
    });
  }

  BuildingUsersShiftsDetailsModel? buildingUsersShiftDetailsModel;
  getBuildingUsersDetails(int buildingId) {
    emit(BuildingUsersDetailsLoadingState());
    DioHelper.getData(url: 'buildings/with-user-shift/$buildingId')
        .then((value) {
      buildingUsersShiftDetailsModel =
          BuildingUsersShiftsDetailsModel.fromJson(value!.data);
      emit(BuildingUsersDetailsSuccessState(buildingUsersShiftDetailsModel!));
    }).catchError((error) {
      emit(BuildingUsersDetailsErrorState(error.toString()));
    });
  }

  FloorUsersShiftsDetailsModel? floorUsersShiftDetailsModel;
  getFloorUsersDetails(int floorId) {
    emit(FloorUsersDetailsLoadingState());
    DioHelper.getData(url: 'floors/with-user-shift/$floorId').then((value) {
      floorUsersShiftDetailsModel =
          FloorUsersShiftsDetailsModel.fromJson(value!.data);
      emit(FloorUsersDetailsSuccessState(floorUsersShiftDetailsModel!));
    }).catchError((error) {
      emit(FloorUsersDetailsErrorState(error.toString()));
    });
  }

  SectionUsersShiftsDetailsModel? sectionUsersShiftDetailsModel;
  getSectionUsersDetails(int sectionId) {
    emit(SectionUserDetailsLoadingState());
    DioHelper.getData(url: 'sections/with-user-shift/$sectionId').then((value) {
      sectionUsersShiftDetailsModel =
          SectionUsersShiftsDetailsModel.fromJson(value!.data);
      emit(SectionUserDetailsSuccessState(sectionUsersShiftDetailsModel!));
    }).catchError((error) {
      emit(SectionUserDetailsErrorState(error.toString()));
    });
  }

  PointUsersDetailsModel? pointUsersDetailsModel;
  getPointUsersDetails(int pointId) {
    emit(PointUsersDetailsLoadingState());
    DioHelper.getData(url: 'points/with-user/$pointId').then((value) {
      pointUsersDetailsModel = PointUsersDetailsModel.fromJson(value!.data);
      emit(PointUsersDetailsSuccessState(pointUsersDetailsModel!));
    }).catchError((error) {
      emit(PointUsersDetailsErrorState(error.toString()));
    });
  }

  DeleteAreaModel? deleteAreaModel;
  List<Area> deletedAreas = [];
  deleteArea(int id) {
    emit(AreaDeleteLoadingState());
    DioHelper.postData(url: 'areas/delete/$id', data: {'id': id}).then((value) {
      deleteAreaModel = DeleteAreaModel.fromJson(value!.data);

      final deletedArea = areaModel?.data?.areas?.firstWhere(
        (user) => user.id == id,
      );

      if (deletedArea != null) {
        // Remove from main list
        areaModel?.data?.areas?.removeWhere((user) => user.id == id);

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
  List<City> deletedCitys = [];
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
  List<BuildingDataDetails> deletedBuildings = [];
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
  List<FloorDataItem> deletedFloors = [];
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
  List<SectionDataItem> deletedSections = [];
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
  List<PointDataItem> deletedPoints = [];
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
        areaModel?.data?.areas ??= [];

        // Convert to User object
        final restoredUser = Area.fromJson(restoredData.toJson());

        // Find the correct position to insert (sorted by ID)
        int insertIndex = areaModel!.data!.areas!
            .indexWhere((user) => user.id! > restoredUser.id!);

        // If not found, add to end
        if (insertIndex == -1) insertIndex = areaModel!.data!.areas!.length;

        // Insert at correct position
        areaModel?.data?.areas?.insert(insertIndex, restoredUser);

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
        final restoredUser = City.fromJson(restoredData.toJson());

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
        final restoredUser =
            BuildingDataDetails.fromJson(restoredData.toJson());

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
        final restoredUser = FloorDataItem.fromJson(restoredData.toJson());

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
        final restoredUser = SectionDataItem.fromJson(restoredData.toJson());

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
        final restoredUser = PointDataItem.fromJson(restoredData.toJson());

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

//********************* */

  NationalityModel? nationalityModel;
  getNationality() {
    emit(GetNationalityLoadingState());
    DioHelper.getData(
        url: ApiConstants.countriesUrl,
        query: {'userUsedOnly': false, 'areaUsedOnly': true}).then((value) {
      nationalityModel = NationalityModel.fromJson(value!.data);
      emit(GetNationalitySuccessState(nationalityModel!));
    }).catchError((error) {
      emit(GetNationalityErrorState(error.toString()));
    });
  }

  AreaListModel? areasModel;
  getAreas(String countryName) {
    emit(GetAreaLoadingState());
    DioHelper.getData(url: "areas/pagination", query: {'country': countryName})
        .then((value) {
      areasModel = AreaListModel.fromJson(value!.data);
      emit(GetAreaSuccessState(areasModel!));
    }).catchError((error) {
      emit(GetAreaErrorState(error.toString()));
    });
  }

  CityListModel? cityyModel;
  getCityy(int areaId) {
    emit(GetCityLoadingState());
    DioHelper.getData(url: "cities/pagination", query: {'area': areaId})
        .then((value) {
      cityyModel = CityListModel.fromJson(value!.data);
      emit(GetCitySuccessState(cityyModel!));
    }).catchError((error) {
      emit(GetCityErrorState(error.toString()));
    });
  }

  OrganizationListModel? organizationsModel;
  getOrganizations(int cityId) {
    emit(GetOrganizationLoadingState());
    DioHelper.getData(url: "organizations/pagination", query: {'city': cityId})
        .then((value) {
      organizationsModel = OrganizationListModel.fromJson(value!.data);
      emit(GetOrganizationSuccessState(organizationsModel!));
    }).catchError((error) {
      emit(GetOrganizationErrorState(error.toString()));
    });
  }

  BuildingListModel? buildingsModel;
  getBuildings(int organizationId) {
    emit(GetBuildingLoadingState());
    DioHelper.getData(
        url: 'buildings/pagination',
        query: {'organization': organizationId}).then((value) {
      buildingsModel = BuildingListModel.fromJson(value!.data);
      emit(GetBuildingSuccessState(buildingsModel!));
    }).catchError((error) {
      emit(GetBuildingErrorState(error.toString()));
    });
  }

  FloorListModel? floorsModel;
  getFloors(int buildingId) {
    emit(GetFloorLoadingState());
    DioHelper.getData(url: 'floors/pagination', query: {'building': buildingId})
        .then((value) {
      floorsModel = FloorListModel.fromJson(value!.data);
      emit(GetFloorSuccessState(floorsModel!));
    }).catchError((error) {
      emit(GetFloorErrorState(error.toString()));
    });
  }

  SectionListModel? sectionsModel;
  getSections(int floorId) {
    emit(GetSectionLoadingState());
    DioHelper.getData(url: 'sections/pagination', query: {'floor': floorId})
        .then((value) {
      sectionsModel = SectionListModel.fromJson(value!.data);
      emit(GetSectionSuccessState(sectionsModel!));
    }).catchError((error) {
      emit(GetSectionErrorState(error.toString()));
    });
  }

  PointListModel? pointsModel;
  getPoints(int sectionId) {
    emit(GetPointsLoadingState());
    DioHelper.getData(url: 'points/pagination', query: {'section': sectionId})
        .then((value) {
      pointsModel = PointListModel.fromJson(value!.data);
      emit(GetPointsSuccessState(pointsModel!));
    }).catchError((error) {
      emit(GetPointsErrorState(error.toString()));
    });
  }

//******************************** */
  AreaTreeModel? areaTreeModel;
  getAreatree(int id) {
    emit(AreaTreeLoadingState());
    DioHelper.getData(url: 'areas/tree/$id').then((value) {
      areaTreeModel = AreaTreeModel.fromJson(value!.data);
      emit(AreaTreeSuccessState(areaTreeModel!));
    }).catchError((error) {
      emit(AreaTreeErrorState(error.toString()));
    });
  }

  CityTreeModel? cityTreeModel;
  getCitytree(int id) {
    emit(CityTreeLoadingState());
    DioHelper.getData(url: 'cities/tree/$id').then((value) {
      cityTreeModel = CityTreeModel.fromJson(value!.data);
      emit(CityTreeSuccessState(cityTreeModel!));
    }).catchError((error) {
      emit(CityTreeErrorState(error.toString()));
    });
  }

  OrganizationTreeModel? organizationTreeModel;
  getOrganizationtree(int id) {
    emit(OrganizationTreeLoadingState());
    DioHelper.getData(url: 'organizations/tree/$id').then((value) {
      organizationTreeModel = OrganizationTreeModel.fromJson(value!.data);
      emit(OrganizationTreeSuccessState(organizationTreeModel!));
    }).catchError((error) {
      emit(OrganizationTreeErrorState(error.toString()));
    });
  }

  BuildingTreeModel? buildingTreeModel;
  getBuildingtree(int id) {
    emit(BuildingTreeLoadingState());
    DioHelper.getData(url: 'buildings/tree/$id').then((value) {
      buildingTreeModel = BuildingTreeModel.fromJson(value!.data);
      emit(BuildingTreeSuccessState(buildingTreeModel!));
    }).catchError((error) {
      emit(BuildingTreeErrorState(error.toString()));
    });
  }

  FloorTreeModel? floorTreeModel;
  getFloortree(int id) {
    emit(FloorTreeLoadingState());
    DioHelper.getData(url: 'floors/tree/$id').then((value) {
      floorTreeModel = FloorTreeModel.fromJson(value!.data);
      emit(FloorTreeSuccessState(floorTreeModel!));
    }).catchError((error) {
      emit(FloorTreeErrorState(error.toString()));
    });
  }

  SectionTreeModel? sectionTreeModel;
  getSectiontree(int id) {
    emit(SectionTreeLoadingState());
    DioHelper.getData(url: 'sections/tree/$id').then((value) {
      sectionTreeModel = SectionTreeModel.fromJson(value!.data);
      emit(SectionTreeSuccessState(sectionTreeModel!));
    }).catchError((error) {
      emit(SectionTreeErrorState(error.toString()));
    });
  }

//********************** */
  AllTasksModel? allareaTasksModel;
  getareaTasks(
    int? areaId,
  ) {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'area': areaId,
    }).then((value) {
      allareaTasksModel = AllTasksModel.fromJson(value!.data);
      emit(GetAllTasksSuccessState(allareaTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }

  AllTasksModel? allcityTasksModel;
  getCityTasks(int? cityId) {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'city': cityId,
    }).then((value) {
      allcityTasksModel = AllTasksModel.fromJson(value!.data);
      emit(GetAllTasksSuccessState(allcityTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }

  AllTasksModel? allorganizationTasksModel;
  getorganizationTasks(int? organizationId) {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'organization': organizationId,
    }).then((value) {
      allorganizationTasksModel = AllTasksModel.fromJson(value!.data);
      emit(GetAllTasksSuccessState(allorganizationTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }

  AllTasksModel? allbuildingTasksModel;
  getbuildingTasks(int? buildingId) {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'building': buildingId,
    }).then((value) {
      allbuildingTasksModel = AllTasksModel.fromJson(value!.data);
      emit(GetAllTasksSuccessState(allbuildingTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }

  AllTasksModel? allfloorTasksModel;
  getfloorTasks(int? floorId) {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'floor': floorId,
    }).then((value) {
      allfloorTasksModel = AllTasksModel.fromJson(value!.data);
      emit(GetAllTasksSuccessState(allfloorTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }

  AllTasksModel? allSectionTasksModel;
  getSectionTasks(int? sectionId) {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'section': sectionId,
    }).then((value) {
      allSectionTasksModel = AllTasksModel.fromJson(value!.data);
      emit(GetAllTasksSuccessState(allSectionTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }

  AllTasksModel? allPointTasksModel;
  getPointTasks(int? pointId) {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'point': pointId,
    }).then((value) {
      allPointTasksModel = AllTasksModel.fromJson(value!.data);
      emit(GetAllTasksSuccessState(allPointTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }

//*********************** */

  AttendanceHistoryModel? attendanceHistoryAreaModel;
  getAttendanceHistoryArea(int id) {
    emit(AttendanceHistoryAreaLoadingState());
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'areaId': id,
    }).then((value) {
      attendanceHistoryAreaModel = AttendanceHistoryModel.fromJson(value!.data);
      emit(AttendanceHistoryAreaSuccessState(attendanceHistoryAreaModel!));
    }).catchError((error) {
      emit(AttendanceHistoryAreaErrorState(error.toString()));
    });
  }

  AttendanceHistoryModel? attendanceHistoryCityModel;
  getAttendanceHistoryCity(int id) {
    emit(AttendanceHistoryCityLoadingState());
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'cityId': id,
    }).then((value) {
      attendanceHistoryCityModel = AttendanceHistoryModel.fromJson(value!.data);
      emit(AttendanceHistoryCitySuccessState(attendanceHistoryCityModel!));
    }).catchError((error) {
      emit(AttendanceHistoryCityErrorState(error.toString()));
    });
  }

  AttendanceHistoryModel? attendanceHistoryOrganizationModel;
  getAttendanceHistoryOrganization(int id) {
    emit(AttendanceHistoryOrganizationLoadingState());
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'OrganizationId': id,
    }).then((value) {
      attendanceHistoryOrganizationModel =
          AttendanceHistoryModel.fromJson(value!.data);
      emit(AttendanceHistoryOrganizationSuccessState(
          attendanceHistoryOrganizationModel!));
    }).catchError((error) {
      emit(AttendanceHistoryOrganizationErrorState(error.toString()));
    });
  }

  AttendanceHistoryModel? attendanceHistoryBuildingModel;
  getAttendanceHistoryBuilding(int id) {
    emit(AttendanceHistoryBuildingLoadingState());
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'buildingId': id,
    }).then((value) {
      attendanceHistoryBuildingModel =
          AttendanceHistoryModel.fromJson(value!.data);
      emit(AttendanceHistoryBuildingSuccessState(
          attendanceHistoryBuildingModel!));
    }).catchError((error) {
      emit(AttendanceHistoryBuildingErrorState(error.toString()));
    });
  }

  AttendanceHistoryModel? attendanceHistoryFloorModel;
  getAttendanceHistoryFloor(int id) {
    emit(AttendanceHistoryFloorLoadingState());
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'floorId': id,
    }).then((value) {
      attendanceHistoryFloorModel =
          AttendanceHistoryModel.fromJson(value!.data);
      emit(AttendanceHistoryFloorSuccessState(attendanceHistoryFloorModel!));
    }).catchError((error) {
      emit(AttendanceHistoryFloorErrorState(error.toString()));
    });
  }

  AttendanceHistoryModel? attendanceHistorySectionModel;
  getAttendanceHistorySection(int id) {
    emit(AttendanceHistorySectionLoadingState());
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'SectionId': id,
    }).then((value) {
      attendanceHistorySectionModel =
          AttendanceHistoryModel.fromJson(value!.data);
      emit(
          AttendanceHistorySectionSuccessState(attendanceHistorySectionModel!));
    }).catchError((error) {
      emit(AttendanceHistorySectionErrorState(error.toString()));
    });
  }

  AttendanceHistoryModel? attendanceHistoryPointModel;
  getAttendanceHistoryPoint(int id) {
    emit(AttendanceHistoryPointLoadingState());
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'pointId': id,
    }).then((value) {
      attendanceHistoryPointModel =
          AttendanceHistoryModel.fromJson(value!.data);
      emit(AttendanceHistoryPointSuccessState(attendanceHistoryPointModel!));
    }).catchError((error) {
      emit(AttendanceHistoryPointErrorState(error.toString()));
    });
  }

//*********************************** */

  AttendanceLeavesModel? attendanceLeavesAreaModel;
  getAllLeavesArea(int id) {
    emit(LeavesLoadingState());
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'AreaId': id,
    }).then((value) {
      attendanceLeavesAreaModel = AttendanceLeavesModel.fromJson(value!.data);
      emit(LeavesSuccessState(attendanceLeavesAreaModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
    });
  }

  AttendanceLeavesModel? attendanceLeavesCityModel;
  getAllLeavesCity(int id) {
    emit(LeavesLoadingState());
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'CityId': id,
    }).then((value) {
      attendanceLeavesCityModel = AttendanceLeavesModel.fromJson(value!.data);
      emit(LeavesSuccessState(attendanceLeavesCityModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
    });
  }

  AttendanceLeavesModel? attendanceLeavesOrganizationModel;
  getAllLeavesOrganization(int id) {
    emit(LeavesLoadingState());
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'OrganizationId': id,
    }).then((value) {
      attendanceLeavesOrganizationModel =
          AttendanceLeavesModel.fromJson(value!.data);
      emit(LeavesSuccessState(attendanceLeavesOrganizationModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
    });
  }

  AttendanceLeavesModel? attendanceLeavesBuildingModel;
  getAllLeavesBuilding(int id) {
    emit(LeavesLoadingState());
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'BuildingId': id,
    }).then((value) {
      attendanceLeavesBuildingModel =
          AttendanceLeavesModel.fromJson(value!.data);
      emit(LeavesSuccessState(attendanceLeavesBuildingModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
    });
  }

  AttendanceLeavesModel? attendanceLeavesFloorModel;
  getAllLeavesFloor(int id) {
    emit(LeavesLoadingState());
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'FloorId': id,
    }).then((value) {
      attendanceLeavesFloorModel = AttendanceLeavesModel.fromJson(value!.data);
      emit(LeavesSuccessState(attendanceLeavesFloorModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
    });
  }

  AttendanceLeavesModel? attendanceLeavesSectionModel;
  getAllLeavesSection(int id) {
    emit(LeavesLoadingState());
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'SectionId': id,
    }).then((value) {
      attendanceLeavesSectionModel =
          AttendanceLeavesModel.fromJson(value!.data);
      emit(LeavesSuccessState(attendanceLeavesSectionModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
    });
  }

  AttendanceLeavesModel? attendanceLeavesPointModel;
  getAllLeavesPoint(int id) {
    emit(LeavesLoadingState());
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'PointId': id,
    }).then((value) {
      attendanceLeavesPointModel = AttendanceLeavesModel.fromJson(value!.data);
      emit(LeavesSuccessState(attendanceLeavesPointModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
    });
  }
}
