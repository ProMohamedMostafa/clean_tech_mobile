import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/features/screens/edit_user/logic/edit_user_state.dart';

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
  final formKey = GlobalKey<FormState>();

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
}
