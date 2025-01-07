import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/manager_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/providers_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/role_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/user_create.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/logic/add_user_state.dart';

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
  TextEditingController roleController = TextEditingController();
  TextEditingController managerIdNumberController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController providerIdController = TextEditingController();
  TextEditingController providerController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formAddKey = GlobalKey<FormState>();

  UserCreateModel? userCreateModel;
  addUser() async {
    emit(AddUserLoadingState());
    Map<String, dynamic> formDataMap = {
      "userName": userNameController.text,
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "email": emailController.text,
      "phoneNumber": phoneController.text,
      "password": passwordController.text,
      "passwordConfirmation": passwordConfirmationController.text,
      "image": null,
      "birthdate": birthController.text,
      "iDNumber": idNumberController.text,
      "nationalityName": nationalityController.text,
      "countryName": countryController.text,
      "role": roleController.text,
      "managerId": managerIdNumberController.text,
      "gender": genderController.text,
      "providerId": providerIdController.text,
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

  addProvider() {
    emit(AddProviderLoadingState());
    DioHelper.postData(url: ApiConstants.userCreateProviderUrl, data: {
      "name": providerController.text,
    }).then((value) {
      final message = value?.data['message'] ?? "Created Successfully";
      emit(AddProviderSuccessState(message!));
    }).catchError((error) {
      emit(AddProviderErrorState(error.toString()));
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

  RoleModel? roleModel;
  getRole() {
    emit(RoleLoadingState());
    DioHelper.getData(url: ApiConstants.rolesUrl).then((value) {
      roleModel = RoleModel.fromJson(value!.data);
      emit(RoleSuccessState(roleModel!));
    }).catchError((error) {
      emit(RoleErrorState(error.toString()));
    });
  }

  ManagerModel? managerModel;
  getManagers() {
    emit(ManagerLoadingState());
    DioHelper.getData(url: "users/role/2").then((value) {
      managerModel = ManagerModel.fromJson(value!.data);
      emit(ManagerSuccessState(managerModel!));
    }).catchError((error) {
      emit(ManagerErrorState(error.toString()));
    });
  }

  ProvidersModel? providersModel;
  getProviders() {
    emit(AllProvidersLoadingState());
    DioHelper.getData(url: ApiConstants.allProvidersUrl).then((value) {
      providersModel = ProvidersModel.fromJson(value!.data);
      emit(AllProvidersSuccessState(providersModel!));
    }).catchError((error) {
      emit(AllProvidersErrorState(error.toString()));
    });
  }
}
