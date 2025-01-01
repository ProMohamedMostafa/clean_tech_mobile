import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/floor_organization_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/points_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/logic/add_organization_state.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/users_model.dart';

class AddOrganizationCubit extends Cubit<AddOrganizationState> {
  AddOrganizationCubit() : super(AddOrganizationInitialState());

  static AddOrganizationCubit get(context) => BlocProvider.of(context);

  TextEditingController nationalityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController addAreaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addCityController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController addOrganizationController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController addBuildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController addFloorController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController addPointController = TextEditingController();
  TextEditingController managerNameController = TextEditingController();
  TextEditingController buildingNumberController = TextEditingController();
  TextEditingController buildingDiscriptionController = TextEditingController();
  TextEditingController floorNumberController = TextEditingController();
  TextEditingController floorDiscriptionController = TextEditingController();
  TextEditingController pointNumberController = TextEditingController();
  TextEditingController pointDiscriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formAddKey = GlobalKey<FormState>();

  // UserCreateModel? userCreateModel;
  // addUser() async {
  //   emit(AddUserLoadingState());
  //   Map<String, dynamic> formDataMap = {
  //     "userName": userNameController.text,
  //     "firstName": firstNameController.text,
  //     "lastName": lastNameController.text,
  //     "email": emailController.text,
  //     "phoneNumber": phoneController.text,
  //     "password": passwordController.text,
  //     "passwordConfirmation": passwordConfirmationController.text,
  //     "image": null,
  //     "birthdate": birthController.text,
  //     "iDNumber": idNumberController.text,
  //     "nationalityName": nationalityController.text,
  //     "countryName": countryController.text,
  //     "role": roleController.text,
  //     "managerId": managerIdNumberController.text,
  //     "gender": genderController.text,
  //     "providerId": providerIdController.text,
  //   };

  //   FormData formData = FormData.fromMap(formDataMap);
  //   try {
  //     final response = await DioHelper.postData2(
  //         url: ApiConstants.userCreateUrl, data: formData);
  //     userCreateModel = UserCreateModel.fromJson(response!.data);
  //     emit(AddUserSuccessState(userCreateModel!));
  //   } catch (error) {
  //     emit(AddUserErrorState(error.toString()));
  //   }
  // }

  OrganizationNationalityModel? nationalityModel;
  getNationality() {
    emit(GetOrganizationNationalityLoadingState());
    DioHelper.getData(url: ApiConstants.countriesUrl).then((value) {
      nationalityModel = OrganizationNationalityModel.fromJson(value!.data);
      emit(GetOrganizationNationalitySuccessState(nationalityModel!));
    }).catchError((error) {
      emit(GetOrganizationNationalityErrorState(error.toString()));
    });
  }

  AreaModel? areaModel;
  getArea(String countryName) {
    emit(GetOrganizationAreaLoadingState());
    DioHelper.getData(url: "areas/country/$countryName").then((value) {
      areaModel = AreaModel.fromJson(value!.data);
      emit(GetOrganizationAreaSuccessState(areaModel!));
    }).catchError((error) {
      emit(GetOrganizationAreaErrorState(error.toString()));
    });
  }

  CityModel? cityModel;
  getCity(int areaId) {
    emit(GetOrganizationCityLoadingState());
    DioHelper.getData(url: "cities/area/$areaId").then((value) {
      cityModel = CityModel.fromJson(value!.data);
      emit(GetOrganizationCitySuccessState(cityModel!));
    }).catchError((error) {
      emit(GetOrganizationCityErrorState(error.toString()));
    });
  }

  OrganizationModel? organizationModel;
  getOrganization(int cityId) {
    emit(GetOrganizationOrganizationsLoadingState());
    DioHelper.getData(url: "organizations/city/$cityId").then((value) {
      organizationModel = OrganizationModel.fromJson(value!.data);
      emit(GetOrganizationOrganizationsSuccessState(organizationModel!));
    }).catchError((error) {
      emit(GetOrganizationOrganizationsErrorState(error.toString()));
    });
  }

  BuildingModel? buildingModel;
  getBuilding(int id) {
    emit(GetOrganizationBuildingLoadingState());
    DioHelper.getData(url: 'buildings/organization/$id').then((value) {
      buildingModel = BuildingModel.fromJson(value!.data);
      emit(GetOrganizationBuildingSuccessState(buildingModel!));
    }).catchError((error) {
      emit(GetOrganizationBuildingErrorState(error.toString()));
    });
  }

  FloorModel? floorModel;
  getFloor(int id) {
    emit(GetOrganizationFloorLoadingState());
    DioHelper.getData(url: 'floors/building/$id').then((value) {
      floorModel = FloorModel.fromJson(value!.data);
      emit(GetOrganizationFloorSuccessState(floorModel!));
    }).catchError((error) {
      emit(GetOrganizationFloorErrorState(error.toString()));
    });
  }

  PointsModel? pointsModel;
  getPoints(int id) {
    emit(GetOrganizationPointsLoadingState());
    DioHelper.getData(url: 'points/floor/$id').then((value) {
      pointsModel = PointsModel.fromJson(value!.data);
      emit(GetOrganizationPointsSuccessState(pointsModel!));
    }).catchError((error) {
      emit(GetOrganizationPointsErrorState(error.toString()));
    });
  }

  UsersModel? usersModel;
  getAllUsersInOrganization() {
    emit(AllUsersLoadingState());
    DioHelper.getData(url: ApiConstants.allUsersUrl).then((value) {
      usersModel = UsersModel.fromJson(value!.data);
      emit(AllUsersSuccessState(usersModel!));
    }).catchError((error) {
      emit(AllUsersErrorState(error.toString()));
    });
  }

  createArea(String countryName) {
    emit(CreateAreaLoadingState());

    DioHelper.postData(url: ApiConstants.createAreaUrl, data: {
      "name": addAreaController.text,
      "countryName": countryName,
    }).then((value) {
      final message = value?.data['message'] ?? "Created successfully";
      emit(CreateAreaSuccessState(message));
      nationalityController.clear();
      addAreaController.clear();
    }).catchError((error) {
      emit(CreateAreaErrorState(error.toString()));
    });
  }

  createCity(int areaId) {
    emit(CreateCityLoadingState());

    DioHelper.postData(url: ApiConstants.createCityUrl, data: {
      "name": addCityController.text,
      "areaId": areaId,
    }).then((value) {
      final message = value?.data['message'] ?? "Created successfully";
      emit(CreateCitySuccessState(message));
      nationalityController.clear();
      addCityController.clear();
      areaController.clear();
    }).catchError((error) {
      emit(CreateCityErrorState(error.toString()));
    });
  }

  createOrganization(int cityId) {
    emit(CreateOrganizationLoadingState());

    DioHelper.postData(url: ApiConstants.createOrganizationUrl, data: {
      "name": addOrganizationController.text,
      "cityId": cityId,
    }).then((value) {
      final message = value?.data['message'] ?? "Created successfully";
      emit(CreateOrganizationSuccessState(message));
      nationalityController.clear();
      areaController.clear();
      cityController.clear();
      addOrganizationController.clear();
    }).catchError((error) {
      emit(CreateOrganizationErrorState(error.toString()));
    });
  }

  createBuilding(int organizationId) {
    emit(CreateBuildingLoadingState());

    DioHelper.postData(url: ApiConstants.createBuildingUrl, data: {
      "name": addBuildingController.text,
      "number": buildingNumberController.text,
      "description": buildingDiscriptionController.text,
      "organizationId": organizationId,
    }).then((value) {
      final message = value?.data['message'] ?? "Created successfully";
      emit(CreateBuildingSuccessState(message));
      nationalityController.clear();
      areaController.clear();
      cityController.clear();
      organizationController.clear();
      buildingNumberController.clear();
      buildingDiscriptionController.clear();
      addBuildingController.clear();
    }).catchError((error) {
      emit(CreateBuildingErrorState(error.toString()));
    });
  }

  createFloor(int buildingId) {
    emit(CreateFloorLoadingState());

    DioHelper.postData(url: ApiConstants.createFloorUrl, data: {
      "name": addFloorController.text,
      "number": floorNumberController.text,
      "description": floorDiscriptionController.text,
      "buildingId": buildingId,
    }).then((value) {
      final message = value?.data['message'] ?? "Created successfully";
      emit(CreateFloorSuccessState(message));
      nationalityController.clear();
      areaController.clear();
      cityController.clear();
      organizationController.clear();
      buildingController.clear();
      floorNumberController.clear();
      floorDiscriptionController.clear();
      addFloorController.clear();
    }).catchError((error) {
      emit(CreateFloorErrorState(error.toString()));
    });
  }

  createpoint(int floorId) {
    emit(CreatePointLoadingState());

    DioHelper.postData(url: ApiConstants.createPointUrl, data: {
      "name": addPointController.text,
      "number": pointNumberController.text,
      "description": pointDiscriptionController.text,
      "floorId": floorId,
    }).then((value) {
      final message = value?.data['message'] ?? "Created successfully";
      emit(CreatePointSuccessState(message));
      nationalityController.clear();
      areaController.clear();
      cityController.clear();
      organizationController.clear();
      buildingController.clear();
      floorController.clear();
      pointNumberController.clear();
      pointDiscriptionController.clear();
      addPointController.clear();
    }).catchError((error) {
      emit(CreatePointErrorState(error.toString()));
    });
  }
}
