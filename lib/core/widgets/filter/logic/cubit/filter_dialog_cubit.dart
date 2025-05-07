import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/country_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/data/model/all_shifts_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/data/model/category_management_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/providers_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/point_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/section_list_model.dart';
part 'filter_dialog_state.dart';

class FilterDialogCubit extends Cubit<FilterDialogState> {
  FilterDialogCubit() : super(FilterDialogInitial());

  TextEditingController nationalityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController areaIdController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController cityIdController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController organizationIdController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController buildingIdController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController floorIdController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  TextEditingController sectionIdController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController pointIdController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController roleIdController = TextEditingController();
  TextEditingController shiftController = TextEditingController();
  TextEditingController shiftIdController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController providerController = TextEditingController();
  TextEditingController providerIdController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController typeIdController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController statusIdController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController genderIdController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  TextEditingController createdByController = TextEditingController();
  TextEditingController createdByIdController = TextEditingController();
  TextEditingController assignToController = TextEditingController();
  TextEditingController assignToIdController = TextEditingController();
  TextEditingController taskStatusController = TextEditingController();
  TextEditingController taskStatusIdController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController priorityIdController = TextEditingController();
  TextEditingController actionController = TextEditingController();
  TextEditingController actionIdController = TextEditingController();
  TextEditingController moduleController = TextEditingController();
  TextEditingController moduleIdController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController unitIdController = TextEditingController();
  TextEditingController parentCategoryController = TextEditingController();
  TextEditingController parentCategoryIdController = TextEditingController();
  TextEditingController transactionController = TextEditingController();
  TextEditingController transactionIdController = TextEditingController();

  CountryListModel? countryModel;
  List<CountryModel> countryData = [CountryModel(name: 'No countries')];
  NationalityListModel? nationalityListModel;
  List<NationalityDataModel> nationalityData = [
    NationalityDataModel(name: 'No nationalities')
  ];
  getCountry(bool? userUsedOnly, bool? areaUsedOnly) {
    emit(FilterDialogLoading<CountryListModel>());
    DioHelper.getData(
            url: ApiConstants.countriesUrl,
            query: {'UserUsedOnly': userUsedOnly, 'AreaUsedOnly': areaUsedOnly})
        .then((value) {
      countryModel = CountryListModel.fromJson(value!.data);
      countryData = countryModel?.data ?? [CountryModel(name: 'No countries')];

      nationalityListModel = NationalityListModel.fromJson(value.data);
      nationalityData = nationalityListModel?.data ??
          [NationalityDataModel(name: 'No nationalities')];
      emit(FilterDialogSuccess<CountryListModel>());
    }).catchError((error) {
      emit(FilterDialogError<CountryListModel>());
    });
  }

  AreaListModel? areaListModel;
  List<AreaItem> areaItem = [AreaItem(name: 'No Areas')];
  getArea() {
    emit(FilterDialogLoading<AreaListModel>());
    DioHelper.getData(
        url: "areas/pagination",
        query: {'Country': countryController.text}).then((value) {
      areaListModel = AreaListModel.fromJson(value!.data);
      areaItem = areaListModel?.data?.data ?? [AreaItem(name: 'No Areas')];
      emit(FilterDialogSuccess<AreaListModel>());
    }).catchError((error) {
      emit(FilterDialogError<AreaListModel>());
    });
  }

  CityListModel? cityModel;
  List<CityItem> cityItem = [CityItem(name: 'No Cities')];
  getCity() {
    emit(FilterDialogLoading<CityListModel>());
    DioHelper.getData(
        url: "cities/pagination",
        query: {'Area': areaIdController.text}).then((value) {
      cityModel = CityListModel.fromJson(value!.data);
      cityItem = cityModel?.data?.data ?? [CityItem(name: 'No Cities')];
      emit(FilterDialogSuccess<CityListModel>());
    }).catchError((error) {
      emit(FilterDialogError<CityListModel>());
    });
  }

  OrganizationListModel? organizationModel;
  List<OrganizationItem> organizationItem = [
    OrganizationItem(name: 'No organizations')
  ];
  getOrganization() {
    emit(FilterDialogLoading<OrganizationListModel>());
    DioHelper.getData(
        url: "organizations/pagination",
        query: {'City': cityIdController.text}).then((value) {
      organizationModel = OrganizationListModel.fromJson(value!.data);
      organizationItem = organizationModel?.data?.data ??
          [OrganizationItem(name: 'No organizations')];
      emit(FilterDialogSuccess<OrganizationListModel>());
    }).catchError((error) {
      emit(FilterDialogError<OrganizationListModel>());
    });
  }

  BuildingListModel? buildingModel;
  List<BuildingItem> buildingItem = [BuildingItem(name: 'No building')];
  getBuilding() {
    emit(FilterDialogLoading<BuildingListModel>());
    DioHelper.getData(
        url: 'buildings/pagination',
        query: {'OrganizationId': organizationIdController.text}).then((value) {
      buildingModel = BuildingListModel.fromJson(value!.data);
      buildingItem =
          buildingModel?.data?.data ?? [BuildingItem(name: 'No building')];
      emit(FilterDialogSuccess<BuildingListModel>());
    }).catchError((error) {
      emit(FilterDialogError<BuildingListModel>());
    });
  }

  FloorListModel? floorModel;
  List<FloorItem> floorItem = [FloorItem(name: 'No floors')];
  getFloor() {
    emit(FilterDialogLoading<FloorListModel>());
    DioHelper.getData(
        url: 'floors/pagination',
        query: {'BuildingId': buildingIdController.text}).then((value) {
      floorModel = FloorListModel.fromJson(value!.data);
      floorItem = floorModel?.data?.data ?? [FloorItem(name: 'No floors')];
      emit(FilterDialogSuccess<FloorListModel>());
    }).catchError((error) {
      emit(FilterDialogError<FloorListModel>());
    });
  }

  SectionListModel? sectionModel;
  List<SectionItem> sectionItem = [SectionItem(name: 'No sections')];
  getSection() {
    emit(FilterDialogLoading<SectionListModel>());
    DioHelper.getData(
        url: 'sections/pagination',
        query: {'FloorId': floorIdController.text}).then((value) {
      sectionModel = SectionListModel.fromJson(value!.data);
      sectionItem =
          sectionModel?.data?.data ?? [SectionItem(name: 'No sections')];
      emit(FilterDialogSuccess<SectionListModel>());
    }).catchError((error) {
      emit(FilterDialogError<SectionListModel>());
    });
  }

  PointListModel? pointModel;
  List<PointItem> pointItem = [PointItem(name: 'No points')];
  getPoint() {
    emit(FilterDialogLoading<PointListModel>());
    DioHelper.getData(
        url: 'points/pagination',
        query: {'SectionId': sectionIdController.text}).then((value) {
      pointModel = PointListModel.fromJson(value!.data);
      pointItem = pointModel?.data?.data ?? [PointItem(name: 'No points')];
      emit(FilterDialogSuccess<PointListModel>());
    }).catchError((error) {
      emit(FilterDialogError<PointListModel>());
    });
  }

  RoleModel? roleModel;
  List<RoleDataItem> roleDataItem = [RoleDataItem(name: 'No roles available')];
  getRole() {
    emit(FilterDialogLoading<RoleModel>());
    DioHelper.getData(url: ApiConstants.rolesUrl).then((value) {
      roleModel = RoleModel.fromJson(value!.data);
      roleDataItem =
          roleModel?.data ?? [RoleDataItem(name: 'No roles available')];
      emit(FilterDialogSuccess<RoleModel>());
    }).catchError((error) {
      emit(FilterDialogError<RoleModel>());
    });
  }

  AllShiftsModel? shiftsModel;
  List<ShiftData> shiftData = [ShiftData(name: 'No shifts available')];
  getShifts() {
    emit(FilterDialogLoading<AllShiftsModel>());
    DioHelper.getData(url: ApiConstants.allShiftsUrl).then((value) {
      shiftsModel = AllShiftsModel.fromJson(value!.data);
      shiftData =
          shiftsModel?.data?.shifts ?? [ShiftData(name: 'No shifts available')];
      emit(FilterDialogSuccess<AllShiftsModel>());
    }).catchError((error) {
      emit(FilterDialogError<AllShiftsModel>());
    });
  }

  UsersModel? usersModel;
  List<UserItem> userItem = [UserItem(userName: 'No users available')];
  getUsers() {
    emit(FilterDialogLoading<UsersModel>());
    DioHelper.getData(url: "users/pagination").then((value) {
      usersModel = UsersModel.fromJson(value!.data);
      userItem =
          usersModel?.data?.users ?? [UserItem(userName: 'No users available')];
      emit(FilterDialogSuccess<UsersModel>());
    }).catchError((error) {
      emit(FilterDialogError<UsersModel>());
    });
  }

  ProvidersModel? providersModel;
  List<ProviderItem> providerItem = [
    ProviderItem(name: 'No providers available')
  ];
  getProviders() {
    emit(FilterDialogLoading<ProvidersModel>());
    DioHelper.getData(url: ApiConstants.allProvidersUrl).then((value) {
      providersModel = ProvidersModel.fromJson(value!.data);
      providerItem = providersModel?.data?.data ??
          [ProviderItem(name: 'No providers available')];
      emit(FilterDialogSuccess<ProvidersModel>());
    }).catchError((error) {
      emit(FilterDialogError<ProvidersModel>());
    });
  }

  CategoryManagementModel? categoryManagementModel;
  List<CategoryModel> categoryModel = [
    CategoryModel(name: 'No category available')
  ];
  getCategory() {
    emit(FilterDialogLoading<CategoryManagementModel>());
    DioHelper.getData(url: ApiConstants.categoryUrl).then((value) {
      categoryManagementModel = CategoryManagementModel.fromJson(value!.data);
      categoryModel = categoryManagementModel?.data?.categories ??
          [CategoryModel(name: 'No category available')];
      emit(FilterDialogSuccess<CategoryManagementModel>());
    }).catchError((error) {
      emit(FilterDialogError<CategoryManagementModel>());
    });
  }

  final List<String> levelOrder = [
    'Country',
    'Area',
    'City',
    'Organization',
    'Building',
    'Floor',
    'Section',
    'Point',
  ];

  String selectedLevel = '';
  void setSelectedLevel(String level) {
    selectedLevel = level;
    emit(FilterDialogLevelChanged());
  }

  bool shouldShow(String level) {
    final selectedIndex = levelOrder.indexOf(selectedLevel);
    final levelIndex = levelOrder.indexOf(level);
    return selectedIndex >= levelIndex;
  }

  Map<String, List<String>> moduleActions = {
    'Provider': ['Create', 'Edit', 'Delete', 'Restore', 'ForceDelete'],
    'User': [
      'Create',
      'Edit',
      'Delete',
      'Restore',
      'ForceDelete',
      'Login',
      'Logout',
      'ClockIn',
      'ClockOut',
      'ChangePassword',
      'EditProfile',
      'Assign',
      'RemoveAssign',
      'EditSetting'
    ],
    'UserSetting': ['EditSetting'],
    'Area': [
      'Create',
      'Edit',
      'Delete',
      'Restore',
      'ForceDelete',
      'Assign',
      'RemoveAssign'
    ],
    'City': [
      'Create',
      'Edit',
      'Delete',
      'Restore',
      'ForceDelete',
      'Assign',
      'RemoveAssign'
    ],
    'Organization': [
      'Create',
      'Edit',
      'Delete',
      'Restore',
      'ForceDelete',
      'Assign',
      'RemoveAssign'
    ],
    'Building': [
      'Create',
      'Edit',
      'Delete',
      'Restore',
      'ForceDelete',
      'Assign',
      'RemoveAssign'
    ],
    'Floor': [
      'Create',
      'Edit',
      'Delete',
      'Restore',
      'ForceDelete',
      'Assign',
      'RemoveAssign'
    ],
    'Section': [
      'Create',
      'Edit',
      'Delete',
      'Restore',
      'ForceDelete',
      'Assign',
      'RemoveAssign'
    ],
    'Point': [
      'Create',
      'Edit',
      'Delete',
      'Restore',
      'ForceDelete',
      'Assign',
      'RemoveAssign'
    ],
    'Task': [
      'Create',
      'Edit',
      'Delete',
      'Restore',
      'ForceDelete',
      'ChangeStatus',
      'Comment'
    ],
    'Shift': [
      'Create',
      'Edit',
      'Delete',
      'Restore',
      'ForceDelete',
      'Assign',
      'RemoveAssign'
    ],
    'Attendacne': ['ClockIn', 'ClockOut'],
    'Leave': ['Create', 'Edit', 'Delete'],
    'Category': ['Create', 'Edit', 'Delete', 'Restore', 'ForceDelete'],
    'Material': ['Create', 'Edit', 'Delete', 'Restore', 'ForceDelete'],
    'Stock': ['StockIn', 'StockOut'],
  };
  List<String> get allModules => moduleActions.keys.toList();
  List<String> get allActions =>
      moduleActions.values.expand((actions) => actions).toSet().toList();
  List<String> currentActions = [];
  void updateActionsForModule(String module) {
    currentActions = moduleActions[module] ?? [];
    emit(ChangeActionsState());
  }
}
