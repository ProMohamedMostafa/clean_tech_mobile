import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_cleaning_application/core/helpers/regx_validations/regx_validations.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/country_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/provider/provider_management/data/models/providers_model.dart';
import 'package:smart_cleaning_application/features/screens/user/edit_user/data/model/edit_model.dart';
import 'package:smart_cleaning_application/features/screens/user/edit_user/logic/edit_user_state.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/data/models/user_details_model.dart';

import '../../../integrations/data/models/gallary_model.dart';

class EditUserCubit extends Cubit<EditUserState> {
  EditUserCubit() : super(EditUserInitialState());

  static EditUserCubit get(context) => BlocProvider.of(context);

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController roleIdController = TextEditingController();
  TextEditingController managerController = TextEditingController();
  TextEditingController managerIdController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController genderIdController = TextEditingController();
  TextEditingController providerController = TextEditingController();
  TextEditingController providerIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  EditModel? editModel;
  editUser(int? id, String? image) async {
    emit(EditUserLoadingState());
    int getRoleId(String role) {
      switch (role.toLowerCase()) {
        case 'admin':
          return 1;
        case 'manager':
          return 2;
        case 'supervisor':
          return 3;
        case 'cleaner':
          return 4;
        default:
          return -1;
      }
    }

    MultipartFile? imageFile;
    if (image != null && image.isNotEmpty) {
      imageFile = await MultipartFile.fromFile(
        image,
        filename: image.split('/').last,
      );
    }
    Map<String, dynamic> formDataMap = {
      "Id": id,
      "UserName": userNameController.text.isEmpty
          ? userDetailsModel!.data!.userName
          : userNameController.text,
      "FirstName": firstNameController.text.isEmpty
          ? userDetailsModel!.data!.firstName
          : firstNameController.text,
      "LastName": lastNameController.text.isEmpty
          ? userDetailsModel!.data!.lastName
          : lastNameController.text,
      "Email": emailController.text.isEmpty
          ? userDetailsModel!.data!.email
          : emailController.text,
      "PhoneNumber": phoneController.text.isEmpty
          ? userDetailsModel!.data!.phoneNumber
          : '+966${phoneController.text}',
      "Password": passwordController.text,
      "PasswordConfirmation": passwordConfirmationController.text,
      "Image": imageFile ?? userDetailsModel!.data!.image,
      "Birthdate": birthController.text.isEmpty
          ? userDetailsModel!.data!.birthdate
          : birthController.text,
      "ManagerId": managerIdController.text.isEmpty
          ? userDetailsModel!.data!.managerId
          : managerIdController.text,
      "IDNumber": idNumberController.text.isEmpty
          ? userDetailsModel!.data!.idNumber
          : idNumberController.text,
      "NationalityName": nationalityController.text.isEmpty
          ? userDetailsModel!.data!.nationalityName
          : nationalityController.text,
      "CountryName": countryController.text.isEmpty
          ? userDetailsModel!.data!.countryName
          : countryController.text,
      "ProviderId": providerController.text.isEmpty
          ? userDetailsModel!.data!.providerId
          : providerIdController.text,
      "Gender": genderController.text.isEmpty
          ? (userDetailsModel!.data!.gender == "Male" ? "0" : "1")
          : genderIdController.text,
      "RoleId": roleController.text.isEmpty
          ? getRoleId(userDetailsModel!.data!.role!)
          : roleIdController.text,
    };

    FormData formData = FormData.fromMap(formDataMap);
    try {
      final response = await DioHelper.putData2(
          url: ApiConstants.editUserUrl, data: formData);
      editModel = EditModel.fromJson(response!.data);
      emit(EditUserSuccessState(editModel!));
    } catch (error) {
      emit(EditUserErrorState(error.toString()));
    }
  }

  UserDetailsModel? userDetailsModel;
  getUserDetailsInEdit(int id) {
    emit(UserLoadingState());
    DioHelper.getData(url: 'users/$id').then((value) {
      userDetailsModel = UserDetailsModel.fromJson(value!.data);
      emit(UserSuccessState(userDetailsModel!));
    }).catchError((error) {
      emit(UserErrorState(error.toString()));
    });
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

  GalleryModel? gellaryModel;
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

  IconData suffixIcon = Icons.visibility_outlined;
  bool ispassword = true;
  changeSuffixIconVisiability() {
    ispassword = !ispassword;
    suffixIcon =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeSuffixIconVisiabiltyState());
  }
}
