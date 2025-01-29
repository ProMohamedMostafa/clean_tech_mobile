import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_user_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/providers_model.dart';
import 'package:smart_cleaning_application/features/screens/user/edit_user/data/model/edit_model.dart';
import 'package:smart_cleaning_application/features/screens/user/edit_user/logic/edit_user_state.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_shift_details_model.dart';

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
  final shiftController = MultiSelectController<ShiftDetails>();

  EditModel? editModel;
  editUser(int? id, String? image, List<int>? selectedShiftsIds) async {
    emit(EditUserLoadingState());
    MultipartFile? imageFile;
    if (image != null && image.isNotEmpty) {
      imageFile = await MultipartFile.fromFile(
        image,
        filename: image.split('/').last,
      );
    }
    Map<String, dynamic> formDataMap = {
      "id": id,
      "userName": userNameController.text.isEmpty
          ? userDetailsModel!.data!.userName
          : userNameController.text,
      "firstName": firstNameController.text.isEmpty
          ? userDetailsModel!.data!.firstName
          : firstNameController.text,
      "lastName": lastNameController.text.isEmpty
          ? userDetailsModel!.data!.lastName
          : lastNameController.text,
      "email": emailController.text.isEmpty
          ? userDetailsModel!.data!.email
          : emailController.text,
      "phoneNumber": phoneController.text.isEmpty
          ? userDetailsModel!.data!.phoneNumber
          : phoneController.text,
      "image": imageFile ?? userDetailsModel!.data!.image,
      "birthdate": birthController.text.isEmpty
          ? userDetailsModel!.data!.birthdate
          : birthController.text,
      "iDNumber": idNumberController.text.isEmpty
          ? userDetailsModel!.data!.idNumber
          : idNumberController.text,
      "nationalityName": nationalityController.text.isEmpty
          ? userDetailsModel!.data!.nationalityName
          : nationalityController.text,
      "countryName": countryController.text.isEmpty
          ? userDetailsModel!.data!.countryName
          : countryController.text,
      "role": roleController.text.isEmpty
          ? userDetailsModel!.data!.role
          : roleIdController.text,
      "managerId": managerIdController.text.isEmpty
          ? userDetailsModel!.data!.managerId
          : managerIdController.text,
      "gender": genderController.text.isEmpty
          ? userDetailsModel!.data!.gender
          : genderIdController.text,
      "providerId": providerController.text.isEmpty
          ? userDetailsModel!.data!.providerId
          : providerIdController.text,
      "ShiftsIds": selectedShiftsIds ?? userShiftDetailsModel!.data!.shifts,
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

  UserShiftDetailsModel? userShiftDetailsModel;
  getUserShiftDetails(int? id) {
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

  RoleUserModel? roleUserModel;
  getRoleUser(int id) {
    emit(RoleUserLoadingState());
    roleUserModel = null;
    DioHelper.getData(url: 'users/role/$id').then((value) {
      roleUserModel = RoleUserModel.fromJson(value!.data);
      emit(RoleUserSuccessState(roleUserModel!));
    }).catchError((error) {
      emit(RoleUserErrorState(error.toString()));
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
