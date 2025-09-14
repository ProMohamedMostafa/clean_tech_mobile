import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/helpers/regx_validations/regx_validations.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/city_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/country_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/nationality_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/point_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/section_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/provider/provider_management/data/models/providers_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/add_user/data/model/user_create.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/add_user/logic/add_user_state.dart';

import '../../../integrations/data/models/role_model.dart';

class AddUserCubit extends Cubit<AddUserState> {
  AddUserCubit() : super(AddUserInitialState());

  static AddUserCubit get(context) => BlocProvider.of(context);
  TextEditingController userNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController genderIdController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController roleIdController = TextEditingController();
  TextEditingController managerController = TextEditingController();
  TextEditingController managerIdController = TextEditingController();
  TextEditingController providerController = TextEditingController();
  TextEditingController providerIdController = TextEditingController();
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
  TextEditingController levelController = TextEditingController();

  final allShiftsController = MultiSelectController<ShiftItem>();

  List<int> selectedShiftsIds = [];
  int? selectedLocation;

  final formKey = GlobalKey<FormState>();
  String fullPhoneNumber = '';
  UserCreateModel? userCreateModel;
  addUser({String? image, required String phone}) async {
    emit(AddUserLoadingState());

    MultipartFile? imageFile;
    if (image != null && image.isNotEmpty) {
      imageFile = await MultipartFile.fromFile(
        image,
        filename: image.split('/').last,
      );
    }

    final selectedType = getSelectedType();
    final selectedTypeIds = getSelectedTypeIds();
    Map<String, dynamic> formDataMap = {
      "UserName": userNameController.text,
      "FirstName": firstNameController.text,
      "LastName": lastNameController.text,
      "Email": emailController.text,
      "PhoneNumber": phone,
      "Password": passwordController.text,
      "PasswordConfirmation": passwordConfirmationController.text,
      "Image": imageFile,
      "Birthdate": birthController.text,
      "IDNumber": idNumberController.text,
      "NationalityName": nationalityController.text,
      "CountryName": countryController.text,
      "ManagerId": managerIdController.text,
      "ProviderId": providerIdController.text,
      "Gender": genderIdController.text,
      "RoleId": roleIdController.text,
      "Type": selectedType,
      "TypeIds": selectedTypeIds,
      "ShiftIds": selectedShiftsIds
    };

    FormData formData = FormData.fromMap(formDataMap);
    try {
      final response = await DioHelper.postData2(
          url: ApiConstants.userCreateUrl, data: formData);
      userCreateModel = UserCreateModel.fromJson(response!.data);
      emit(AddUserSuccessState(userCreateModel!));
    } catch (error) {
      emit(AddUserErrorState(error.toString()));
    }
  }

  ProvidersModel? providersModel;
  List<ProviderItem> providerItem = [
    ProviderItem(name: 'No providers available')
  ];
  getProviders() {
    emit(AllProvidersLoadingState());
    DioHelper.getData(url: ApiConstants.allProvidersUrl).then((value) {
      providersModel = ProvidersModel.fromJson(value!.data);
      providerItem = providersModel?.data?.data ??
          [ProviderItem(name: 'No providers available')];
      emit(AllProvidersSuccessState(providersModel!));
    }).catchError((error) {
      emit(AllProvidersErrorState(error.toString()));
    });
  }

  CountryListModel? countryModel;
  List<CountryModel> countryData = [CountryModel(name: 'No countries')];
  NationalityListModel? nationalityListModel;
  List<NationalityDataModel> nationalityData = [
    NationalityDataModel(name: 'No nationalities')
  ];
  getNationality() {
    emit(GetNationalityLoadingState());
    DioHelper.getData(url: ApiConstants.countriesUrl).then((value) {
      countryModel = CountryListModel.fromJson(value!.data);
      countryData = countryModel?.data ?? [CountryModel(name: 'No countries')];
      nationalityListModel = NationalityListModel.fromJson(value.data);
      nationalityData = nationalityListModel?.data ??
          [NationalityDataModel(name: 'No nationalities')];
      emit(GetNationalitySuccessState(nationalityListModel!));
    }).catchError((error) {
      emit(GetNationalityErrorState(error.toString()));
    });
  }

  RoleModel? roleModel;
  List<RoleDataItem> roleDataItem = [RoleDataItem(name: 'No roles available')];
  getRole() {
    emit(RoleLoadingState());
    DioHelper.getData(url: ApiConstants.rolesUrl).then((value) {
      roleModel = RoleModel.fromJson(value!.data);
      roleDataItem =
          roleModel?.data ?? [RoleDataItem(name: 'No roles available')];
      emit(RoleSuccessState(roleModel!));
    }).catchError((error) {
      emit(RoleErrorState(error.toString()));
    });
  }

  UsersModel? usersModel;
  List<UserItem> userItem = [UserItem(userName: 'No users available')];
  getAllUsers(int id) {
    emit(AllUsersLoadingState());
    DioHelper.getData(url: "users/pagination", query: {'RoleId': id})
        .then((value) {
      usersModel = UsersModel.fromJson(value!.data);
      userItem =
          usersModel?.data?.users ?? [UserItem(userName: 'No users available')];
      emit(AllUsersSuccessState(usersModel!));
    }).catchError((error) {
      emit(AllUsersErrorState(error.toString()));
    });
  }

  bool isShow = false;
  // Password validation flags
  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  void validatePassword(String password) {
    hasLowercase = AppRegex.hasLowerCase(password);
    hasUppercase = AppRegex.hasUpperCase(password);
    hasSpecialCharacters = AppRegex.hasSpecialCharacter(password);
    hasNumber = AppRegex.hasNumber(password);
    hasMinLength = AppRegex.hasMinLength(password);
    isShow = password.isNotEmpty;
    emit(PasswordValidationChangedState());
  }

  IconData suffixIcon = Icons.visibility_outlined;
  bool ispassword = true;
  changeSuffixIconVisiability() {
    ispassword = !ispassword;
    suffixIcon =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeSuffixIconVisiabiltyState());
  }

  XFile? image;
  Future<void> galleryFile() async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      image = selectedImage;
      emit(ImageSelectedState(image!));
    }
  }

  AreaListModel? areaListModel;
  List<AreaItem> areaItem = [AreaItem(name: 'No Areas')];
  getArea() {
    emit(GetAreaLoadingState());
    DioHelper.getData(url: "areas/pagination").then((value) {
      areaListModel = AreaListModel.fromJson(value!.data);
      areaItem = areaListModel?.data?.data ?? [AreaItem(name: 'No Areas')];
      emit(GetAreaSuccessState(areaListModel!));
    }).catchError((error) {
      emit(GetAreaErrorState(error.toString()));
    });
  }

  CityListModel? cityModel;
  List<CityItem> cityItem = [CityItem(name: 'No Cities')];
  getCity() {
    emit(GetCityLoadingState());
    DioHelper.getData(
        url: "cities/pagination",
        query: {'Area': areaIdController.text}).then((value) {
      cityModel = CityListModel.fromJson(value!.data);
      cityItem = cityModel?.data?.data ?? [CityItem(name: 'No Cities')];
      emit(GetCitySuccessState(cityModel!));
    }).catchError((error) {
      emit(GetCityErrorState(error.toString()));
    });
  }

  OrganizationListModel? organizationModel;
  List<OrganizationItem> organizationItem = [
    OrganizationItem(name: 'No organizations')
  ];
  getOrganization() {
    emit(GetOrganizationLoadingState());
    DioHelper.getData(
        url: "organizations/pagination",
        query: {'City': cityIdController.text}).then((value) {
      organizationModel = OrganizationListModel.fromJson(value!.data);
      organizationItem = organizationModel?.data?.data ??
          [OrganizationItem(name: 'No organizations')];
      emit(GetOrganizationSuccessState(organizationModel!));
    }).catchError((error) {
      emit(GetOrganizationErrorState(error.toString()));
    });
  }

  BuildingListModel? buildingModel;
  List<BuildingItem> buildingItem = [BuildingItem(name: 'No building')];
  getBuilding() {
    emit(GetBuildingLoadingState());
    DioHelper.getData(
        url: 'buildings/pagination',
        query: {'OrganizationId': organizationIdController.text}).then((value) {
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
    DioHelper.getData(
        url: 'floors/pagination',
        query: {'BuildingId': buildingIdController.text}).then((value) {
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
    DioHelper.getData(
        url: 'sections/pagination',
        query: {'FloorId': floorIdController.text}).then((value) {
      sectionModel = SectionListModel.fromJson(value!.data);
      sectionItem =
          sectionModel?.data?.data ?? [SectionItem(name: 'No sections')];
      emit(GetSectionSuccessState(sectionModel!));
    }).catchError((error) {
      emit(GetSectionErrorState(error.toString()));
    });
  }

  PointListModel? pointModel;
  List<PointItem> pointItem = [PointItem(name: 'No points')];
  getPoint() {
    emit(GetPointLoadingState());
    DioHelper.getData(
        url: 'points/pagination',
        query: {'SectionId': sectionIdController.text}).then((value) {
      pointModel = PointListModel.fromJson(value!.data);
      pointItem = pointModel?.data?.data ?? [PointItem(name: 'No points')];
      emit(GetPointSuccessState(pointModel!));
    }).catchError((error) {
      emit(GetPointErrorState(error.toString()));
    });
  }

  ShiftModel? shiftModel;
  List<ShiftItem> shiftData = [ShiftItem(name: 'No shifts available')];
  getShifts() {
    emit(ShiftLoadingState());
    DioHelper.getData(url: ApiConstants.allShiftsUrl, query: {
      'AreaId': areaIdController.text,
      'CityId': cityIdController.text,
      'OrganizationId': organizationIdController.text,
      'BuildingId': buildingIdController.text,
      'FloorId': floorIdController.text,
      'SectionId': sectionIdController.text,
      'PointId': pointIdController.text
    }).then((value) {
      shiftModel = ShiftModel.fromJson(value!.data);
      shiftData =
          shiftModel?.data?.data ?? [ShiftItem(name: 'No shifts available')];
      if (selectedLevel == 'Area') {
        initializeAreaControllers();
      } else if (selectedLevel == 'City') {
        initializeCityControllers();
      } else if (selectedLevel == 'Organization') {
        initializeOrganizationControllers();
      } else if (selectedLevel == 'Building') {
        initializeBuildingControllers();
      } else if (selectedLevel == 'Floor') {
        initializeFloorControllers();
      } else if (selectedLevel == 'Section') {
        initializeSectionControllers();
      } else if (selectedLevel == 'Point') {
        initializePointControllers();
      }
      emit(ShiftSuccessState(shiftModel!));
    }).catchError((error) {
      emit(ShiftErrorState(error.toString()));
    });
  }

  void initializeAreaControllers() {
    if (areaListModel != null && shiftModel != null) {
      final shifts = shiftModel!.data!.data!
          .map((shift) => DropdownItem(
                label: shift.name ?? '',
                value: ShiftItem(
                  id: shift.id,
                  name: shift.name,
                  startDate: shift.startDate,
                  endDate: shift.endDate,
                  startTime: shift.startTime,
                  endTime: shift.endTime,
                ),
              ))
          .toList();

      allShiftsController.setItems(shifts);

      final assignedShifts = areaListModel!.data?.data;

      selectedShiftsIds = assignedShifts
              ?.where((shift) => shift.id != null)
              .map((shift) => shift.id!)
              .toList() ??
          [];

      allShiftsController.selectWhere(
        (item) => selectedShiftsIds.contains(item.value.id),
      );
    }
  }

  void initializeCityControllers() {
    if (cityModel != null && shiftModel != null) {
      final shifts = shiftModel!.data!.data!
          .map((shift) => DropdownItem(
                label: shift.name ?? '',
                value: ShiftItem(
                  id: shift.id,
                  name: shift.name,
                  startDate: shift.startDate,
                  endDate: shift.endDate,
                  startTime: shift.startTime,
                  endTime: shift.endTime,
                ),
              ))
          .toList();

      allShiftsController.setItems(shifts);

      final assignedShifts = cityModel!.data?.data;

      selectedShiftsIds = assignedShifts
              ?.where((shift) => shift.id != null)
              .map((shift) => shift.id!)
              .toList() ??
          [];

      allShiftsController.selectWhere(
        (item) => selectedShiftsIds.contains(item.value.id),
      );
    }
  }

  void initializeOrganizationControllers() {
    if (organizationModel != null && shiftModel != null) {
      final shifts = shiftModel!.data!.data!
          .map((shift) => DropdownItem(
                label: shift.name ?? '',
                value: ShiftItem(
                  id: shift.id,
                  name: shift.name,
                  startDate: shift.startDate,
                  endDate: shift.endDate,
                  startTime: shift.startTime,
                  endTime: shift.endTime,
                ),
              ))
          .toList();

      allShiftsController.setItems(shifts);

      final assignedShifts = organizationModel!.data?.data;

      selectedShiftsIds = assignedShifts
              ?.where((shift) => shift.id != null)
              .map((shift) => shift.id!)
              .toList() ??
          [];

      allShiftsController.selectWhere(
        (item) => selectedShiftsIds.contains(item.value.id),
      );
    }
  }

  void initializeBuildingControllers() {
    if (buildingModel != null && shiftModel != null) {
      final shifts = shiftModel!.data!.data!
          .map((shift) => DropdownItem(
                label: shift.name ?? '',
                value: ShiftItem(
                  id: shift.id,
                  name: shift.name,
                  startDate: shift.startDate,
                  endDate: shift.endDate,
                  startTime: shift.startTime,
                  endTime: shift.endTime,
                ),
              ))
          .toList();

      allShiftsController.setItems(shifts);

      final assignedShifts = buildingModel!.data?.data;

      selectedShiftsIds = assignedShifts
              ?.where((shift) => shift.id != null)
              .map((shift) => shift.id!)
              .toList() ??
          [];

      allShiftsController.selectWhere(
        (item) => selectedShiftsIds.contains(item.value.id),
      );
    }
  }

  void initializeFloorControllers() {
    if (floorModel != null && shiftModel != null) {
      final shifts = shiftModel!.data!.data!
          .map((shift) => DropdownItem(
                label: shift.name ?? '',
                value: ShiftItem(
                  id: shift.id,
                  name: shift.name,
                  startDate: shift.startDate,
                  endDate: shift.endDate,
                  startTime: shift.startTime,
                  endTime: shift.endTime,
                ),
              ))
          .toList();

      allShiftsController.setItems(shifts);

      final assignedShifts = floorModel!.data?.data;

      selectedShiftsIds = assignedShifts
              ?.where((shift) => shift.id != null)
              .map((shift) => shift.id!)
              .toList() ??
          [];

      allShiftsController.selectWhere(
        (item) => selectedShiftsIds.contains(item.value.id),
      );
    }
  }

  void initializeSectionControllers() {
    if (sectionModel != null && shiftModel != null) {
      final shifts = shiftModel!.data!.data!
          .map((shift) => DropdownItem(
                label: shift.name ?? '',
                value: ShiftItem(
                  id: shift.id,
                  name: shift.name,
                  startDate: shift.startDate,
                  endDate: shift.endDate,
                  startTime: shift.startTime,
                  endTime: shift.endTime,
                ),
              ))
          .toList();

      allShiftsController.setItems(shifts);

      final assignedShifts = sectionModel!.data?.data;

      selectedShiftsIds = assignedShifts
              ?.where((shift) => shift.id != null)
              .map((shift) => shift.id!)
              .toList() ??
          [];

      allShiftsController.selectWhere(
        (item) => selectedShiftsIds.contains(item.value.id),
      );
    }
  }

  void initializePointControllers() {
    if (pointModel != null && shiftModel != null) {
      final shifts = shiftModel!.data!.data!
          .map((shift) => DropdownItem(
                label: shift.name ?? '',
                value: ShiftItem(
                  id: shift.id,
                  name: shift.name,
                  startDate: shift.startDate,
                  endDate: shift.endDate,
                  startTime: shift.startTime,
                  endTime: shift.endTime,
                ),
              ))
          .toList();

      allShiftsController.setItems(shifts);

      final assignedShifts = pointModel!.data?.data;

      selectedShiftsIds = assignedShifts
              ?.where((shift) => shift.id != null)
              .map((shift) => shift.id!)
              .toList() ??
          [];

      allShiftsController.selectWhere(
        (item) => selectedShiftsIds.contains(item.value.id),
      );
    }
  }

  String selectedLevel = '';
  void setSelectedLevel(String level) {
    selectedLevel = level;
    selectedLocation = levelOrder.indexOf(level);
    emit(LevelChanged());
  }

  List<String> get levelOrder {
    return [
      'Area',
      'City',
      'Organization',
      'Building',
      'Floor',
      'Section',
      'Point',
    ];
  }

  bool shouldShow(String level) {
    if (!levelOrder.contains(level)) return false;

    final selectedIndex = levelOrder.indexOf(selectedLevel);
    final levelIndex = levelOrder.indexOf(level);
    return selectedIndex >= levelIndex;
  }

  int getSelectedType() {
    switch (selectedLevel) {
      case 'Area':
        return 1;
      case 'City':
        return 2;
      case 'Organization':
        return 3;
      case 'Building':
        return 4;
      case 'Floor':
        return 5;
      case 'Section':
        return 6;
      case 'Point':
        return 7;
      default:
        return 0;
    }
  }

  List<int> getSelectedTypeIds() {
    switch (selectedLevel) {
      case 'Area':
        return areaIdController.text.isNotEmpty
            ? [int.parse(areaIdController.text)]
            : [];
      case 'City':
        return cityIdController.text.isNotEmpty
            ? [int.parse(cityIdController.text)]
            : [];
      case 'Organization':
        return organizationIdController.text.isNotEmpty
            ? [int.parse(organizationIdController.text)]
            : [];
      case 'Building':
        return buildingIdController.text.isNotEmpty
            ? [int.parse(buildingIdController.text)]
            : [];
      case 'Floor':
        return floorIdController.text.isNotEmpty
            ? [int.parse(floorIdController.text)]
            : [];
      case 'Section':
        return sectionIdController.text.isNotEmpty
            ? [int.parse(sectionIdController.text)]
            : [];
      case 'Point':
        return pointIdController.text.isNotEmpty
            ? [int.parse(pointIdController.text)]
            : [];
      default:
        return [];
    }
  }

 
}
