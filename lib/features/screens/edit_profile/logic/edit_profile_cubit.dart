import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/edit_profile/data/model/edit_profile_model.dart';
import 'package:smart_cleaning_application/features/screens/edit_profile/logic/edit_profile_state.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/country_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/gallary_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_list_model.dart';
import 'package:smart_cleaning_application/features/screens/settings/data/model/profile_model.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitialState());

  static EditProfileCubit get(context) => BlocProvider.of(context);
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController genderIdController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  List<int> selectedShiftsIds = [];
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
          : countryController.text,
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
