import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/edit_profile/data/model/edit_profile_model.dart';
import 'package:smart_cleaning_application/features/screens/edit_profile/logic/edit_profile_state.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/gallary_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/settings/data/model/profile_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/providers_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/data/models/user_shift_details_model.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitialState());

  static EditProfileCubit get(context) => BlocProvider.of(context);
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController countryNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController genderIdController = TextEditingController();
  final shiftController = MultiSelectController<ShiftItem>();

  EditProfileModel? editProfileModel;
  editProfile(String? image) async {
    emit(EditProfileLoadingState());

    Map<String, dynamic> formDataMap = {
      "UserName": userNameController.text.isEmpty
          ? profileModel!.data!.userName
          : userNameController.text,
      "FirstName": firstNameController.text.isEmpty
          ? profileModel!.data!.firstName
          : firstNameController.text,
      "LastName": lastNameController.text.isEmpty
          ? profileModel!.data!.lastName
          : lastNameController.text,
      "Email": emailController.text.isEmpty
          ? profileModel!.data!.email
          : emailController.text,
      "PhoneNumber": phoneController.text.isEmpty
          ? profileModel!.data!.phoneNumber
          : phoneController.text,
      "Image": image != null && image.isNotEmpty
          ? await MultipartFile.fromFile(image, filename: image.split('/').last)
          : profileModel!.data!.image,
      "Birthdate": birthController.text.isEmpty
          ? profileModel!.data!.birthdate
          : birthController.text,
      "IDNumber": idNumberController.text.isEmpty
          ? profileModel!.data!.idNumber
          : idNumberController.text,
      "NationalityName": nationalityController.text.isEmpty
          ? profileModel!.data!.nationalityName
          : nationalityController.text,
      "CountryName": nationalityController.text.isEmpty
          ? profileModel!.data!.countryName
          : countryNameController.text,
      "Gender": genderController.text.isEmpty
          ? (profileModel!.data!.gender == "Male" ? "0" : "1")
          : genderIdController.text,
    };

    FormData formData = FormData.fromMap(formDataMap);
    try {
      final response =
          await DioHelper.putData2(url: 'auth/profile/edit', data: formData);
      editProfileModel = EditProfileModel.fromJson(response!.data);
      emit(EditProfileSuccessState(editProfileModel!));
    } catch (error) {
      emit(EditProfileErrorState(error.toString()));
    }
  }

  ProfileModel? profileModel;
  getUserProfileDetails() {
    emit(UserProfileDetailsLoadingState());
    DioHelper.getData(url: 'auth/profile').then((value) {
      profileModel = ProfileModel.fromJson(value!.data);
      emit(UserProfileDetailsSuccessState(profileModel!));
    }).catchError((error) {
      emit(UserProfileDetailsErrorState(error.toString()));
    });
  }

  UserShiftDetailsModel? userShiftDetailsModel;
  getProfileShiftDetails(int? id) {
    emit(UserShiftDetailsLoadingState());
    DioHelper.getData(url: 'user/shift/$id').then((value) {
      userShiftDetailsModel = UserShiftDetailsModel.fromJson(value!.data);
      emit(UserShiftDetailsSuccessState(userShiftDetailsModel!));
    }).catchError((error) {
      emit(UserShiftDetailsErrorState(error.toString()));
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

  NationalityListModel? nationalityModel;
  getNationality() {
    emit(GetNationalityLoadingState());
    DioHelper.getData(url: ApiConstants.countriesUrl).then((value) {
      nationalityModel = NationalityListModel.fromJson(value!.data);
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
}
