import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_cleaning_application/core/helpers/regx_validations/regx_validations.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/country_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/nationality_list_model.dart';
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
}
