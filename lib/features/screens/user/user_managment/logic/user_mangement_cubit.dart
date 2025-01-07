import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/users_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/delete_user_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/deleted_list_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_state.dart';

class UserManagementCubit extends Cubit<UserManagementState> {
  UserManagementCubit() : super(UserManagementInitialState());

  static UserManagementCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  UserModel? userModel;
  getUserDetails(int? id) {
    emit(UserLoadingState());
    DioHelper.getData(url: 'users/$id').then((value) {
      userModel = UserModel.fromJson(value!.data);
      emit(UserSuccessState(userModel!));
    }).catchError((error) {
      emit(UserErrorState(error.toString()));
    });
  }

  UsersModel? usersModel;
  getAllUsersInUserManage() {
    emit(AllUsersLoadingState());
    DioHelper.getData(url: "users/pagination").then((value) {
      usersModel = UsersModel.fromJson(value!.data);
      deletedListModel;
      emit(AllUsersSuccessState(usersModel!));
    }).catchError((error) {
      emit(AllUsersErrorState(error.toString()));
    });
  }

  DeleteUserModel? deleteUserDetailsModel;
  userDeleteInDetails(int id) {
    emit(UserDeleteInDetailsLoadingState());
    DioHelper.postData(url: 'users/delete/$id', data: {'id': id}).then((value) {
      deleteUserDetailsModel = DeleteUserModel.fromJson(value!.data);
      emit(UserDeleteInDetailsSuccessState(deleteUserDetailsModel!));
    }).catchError((error) {
      emit(UserDeleteInDetailsErrorState(error.toString()));
    });
  }

  DeleteUserModel? deleteUserModel;
  userDelete(int id) {
    emit(UserDeleteLoadingState());
    DioHelper.postData(url: 'users/delete/$id', data: {'id': id}).then((value) {
      deleteUserModel = DeleteUserModel.fromJson(value!.data);
      emit(UserDeleteSuccessState(deleteUserModel!));
    }).catchError((error) {
      emit(UserDeleteErrorState(error.toString()));
    });
  }

  DeletedListModel? deletedListModel;
  getAllDeletedUser() {
    emit(DeletedUsersLoadingState());
    DioHelper.getData(url: ApiConstants.deleteUserListUrl).then((value) {
      deletedListModel = DeletedListModel.fromJson(value!.data);
      emit(DeletedUsersSuccessState(deletedListModel!));
    }).catchError((error) {
      emit(DeletedUsersErrorState(error.toString()));
    });
  }

  restoreDeletedUser(int id) {
    emit(RestoreUsersLoadingState());
    DioHelper.postData(url: 'users/restore/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(RestoreUsersSuccessState(message));
    }).catchError((error) {
      emit(RestoreUsersErrorState(error.toString()));
    });
  }

  forcedDeletedUser(int id) {
    emit(ForceDeleteUsersLoadingState());
    DioHelper.deleteData(url: 'users/forcedelete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(ForceDeleteUsersSuccessState(message));
    }).catchError((error) {
      emit(ForceDeleteUsersErrorState(error.toString()));
    });
  }
}
