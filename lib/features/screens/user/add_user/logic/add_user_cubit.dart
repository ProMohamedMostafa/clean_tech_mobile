import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/all_deleted_providers_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/providers_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/user_create.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/logic/add_user_state.dart';

import '../../../integrations/data/models/gallary_model.dart';
import '../../../integrations/data/models/role_model.dart';
import '../../../integrations/data/models/shift_model.dart';

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
  TextEditingController genderIdController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController roleIdController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController managerController = TextEditingController();
  TextEditingController managerIdController = TextEditingController();
  TextEditingController providerIdController = TextEditingController();
  TextEditingController providerController = TextEditingController();
  TextEditingController deletedProviderController = TextEditingController();
  TextEditingController restoreProviderController = TextEditingController();
  final shiftController = MultiSelectController<ShiftDetails>();

  final formKey = GlobalKey<FormState>();
  final formAddKey = GlobalKey<FormState>();

  UserCreateModel? userCreateModel;
  addUser({String? image, List<int>? selectedShiftsIds}) async {
    emit(AddUserLoadingState());

    MultipartFile? imageFile;
    if (image != null && image.isNotEmpty) {
      imageFile = await MultipartFile.fromFile(
        image,
        filename: image.split('/').last,
      );
    }
    Map<String, dynamic> formDataMap = {
      "userName": userNameController.text,
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "email": emailController.text,
      "phoneNumber": '+966${phoneController.text}',
      "password": passwordController.text,
      "passwordConfirmation": passwordConfirmationController.text,
      "Image": imageFile,
      "birthdate": birthController.text,
      "iDNumber": idNumberController.text,
      "nationalityName": nationalityController.text,
      "countryName": countryController.text,
      "RoleId": roleIdController.text,
      "managerId": managerIdController.text,
      "gender": genderIdController.text,
      "providerId": providerIdController.text,
      "ShiftsIds": selectedShiftsIds,
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
      providerController.clear();
      providerIdController.clear();
      emit(AddProviderSuccessState(message!));
    }).catchError((error) {
      emit(AddProviderErrorState(error.toString()));
    });
  }

  deleteProvider(String id) {
    emit(DeletedProviderLoadingState());
    DioHelper.postData(url: 'providers/delete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "deleted successfully";
      deletedProviderController.clear();
      emit(DeletedProviderSuccessState(message!));
    }).catchError((error) {
      emit(DeletedProviderErrorState(error.toString()));
    });
  }

  restoreDeletedProvider(String id) {
    emit(RestoreProviderLoadingState());
    DioHelper.postData(url: 'providers/restore/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      restoreProviderController.clear();
      emit(RestoreProviderSuccessState(message));
    }).catchError((error) {
      emit(RestoreProviderErrorState(error.toString()));
    });
  }

  AllDeletedProvidersModel? allDeletedProvidersModel;
  getAllDeletedProviders() {
    emit(AllDeletedrovidersLoadingState());
    DioHelper.getData(url: ApiConstants.deletedProvidersListUrl).then((value) {
      allDeletedProvidersModel = AllDeletedProvidersModel.fromJson(value!.data);
      emit(AllDeletedrovidersSuccessState(allDeletedProvidersModel!));
    }).catchError((error) {
      emit(AllDeletedrovidersErrorState(error.toString()));
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
 UsersModel? usersModel;
  getAllUsers(int id) {
    emit(AllUsersLoadingState());
    DioHelper.getData(url: "users/pagination",query: {'role':id}).then((value) {
      usersModel = UsersModel.fromJson(value!.data);
      emit(AllUsersSuccessState(usersModel!));
    }).catchError((error) {
      emit(AllUsersErrorState(error.toString()));
    });
  }

  IconData suffixIcon = Icons.visibility_outlined;
  bool ispassword = true;
  changeSuffixIconVisiability() {
    ispassword = !ispassword;
    suffixIcon =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeSuffixIconVisiabiltyState());
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
