import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/add_user/data/model/users_model.dart';
import 'package:smart_cleaning_application/features/screens/user_managment/data/model/delete_user_model.dart';
import 'package:smart_cleaning_application/features/screens/user_managment/logic/user_mangement_state.dart';

class UserManagementCubit extends Cubit<UserManagementState> {
  UserManagementCubit() : super(UserManagementInitialState());

  static UserManagementCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  DeleteUserModel? deleteUserModel;
  userDelete() {
    emit(UserDeleteLoadingState());
    DioHelper.getData(url: 'users/delete/1').then((value) {
      deleteUserModel = DeleteUserModel.fromJson(value!.data);
      emit(UserDeleteSuccessState(deleteUserModel!));
    }).catchError((error) {
      emit(UserDeleteErrorState(error.toString()));
    });
  }

  UsersModel? usersModel;
  getAllUsersInUserManage() {
    emit(AllUsersLoadingState());
    DioHelper.getData(url: ApiConstants.allUsersUrl).then((value) {
      usersModel = UsersModel.fromJson(value!.data);
      emit(AllUsersSuccessState(usersModel!));
    }).catchError((error) {
      emit(AllUsersErrorState(error.toString()));
    });
  }
}
