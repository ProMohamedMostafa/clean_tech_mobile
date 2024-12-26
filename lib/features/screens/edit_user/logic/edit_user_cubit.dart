import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/edit_user/data/model/edit_model.dart';
import 'package:smart_cleaning_application/features/screens/edit_user/logic/edit_user_state.dart';
import 'package:smart_cleaning_application/features/screens/user_managment/data/model/user_model.dart';

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
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController managerIdNumberController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController providerIdController = TextEditingController();

  // Future<void> updateUser() async {
  //   emit(EditUserLoadingState());
  //   Map<String, dynamic> formDataMap = {
  //     "userName": userNameController.text,
  //     "firstName": firstNameController.text,
  //     "lastName": lastNameController.text,
  //     "Email": emailController.text,
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
  //     "providerId ": providerIdController.text,
  //   };

  //   // FormData formData = FormData.fromMap(formDataMap);
  //   try {
  //     final response = await DioHelper.postData(
  //         url:ApiConstants.userCreateUrl,data: formDataMap);
  //     updateProfileModel = UpdateProfileModel.fromJson(response.data);
  //     emit(EditUserSuccessState(updateProfileModel!));
  //   } catch (error) {
  //     emit(EditUserErrorState(error.toString()));
  //   }
  // }
  EditModel? editModel;
  editUser(int? id) async {
    emit(EditUserLoadingState());
    Map<String, dynamic> formDataMap = {
      "id": id,
      "userName": userNameController.text.isEmpty
          ? userModel!.data!.userName
          : userNameController.text,
      "firstName": firstNameController.text.isEmpty
          ? userModel!.data!.firstName
          : firstNameController.text,
      "lastName": lastNameController.text.isEmpty
          ? userModel!.data!.lastName
          : lastNameController.text,
      "email": emailController.text.isEmpty
          ? userModel!.data!.email
          : emailController.text,
      "phoneNumber": phoneController.text.isEmpty
          ? userModel!.data!.phoneNumber
          : phoneController.text,
      "image": null,
      "birthdate": birthController.text.isEmpty
          ? userModel!.data!.birthdate
          : birthController.text,
      "iDNumber": idNumberController.text.isEmpty
          ? userModel!.data!.idNumber
          : idNumberController.text,
      "nationalityName": nationalityController.text.isEmpty
          ? userModel!.data!.nationalityName
          : nationalityController.text,
      "countryName": countryController.text.isEmpty
          ? userModel!.data!.countryName
          : countryController.text,
      "role": roleController.text.isEmpty ? 1 : roleController.text,
      "managerId": null,
      "gender": genderController.text.isEmpty
          ? userModel!.data!.gender
          : genderController.text,
      "providerId":
          providerIdController.text.isEmpty ? 1 : providerIdController.text,
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

  UserModel? userModel;
  getUserDetailsInEdit(int id) {
    emit(UserLoadingState());
    DioHelper.getData(url: 'users/$id').then((value) {
      userModel = UserModel.fromJson(value!.data);
      emit(UserSuccessState(userModel!));
    }).catchError((error) {
      emit(UserErrorState(error.toString()));
    });
  }
}
