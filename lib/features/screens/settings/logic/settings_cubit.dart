import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/settings/data/model/profile_model.dart';
import 'package:smart_cleaning_application/features/screens/settings/logic/settings_state.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/data/models/user_status_model.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitialState());

  static SettingsCubit get(context) => BlocProvider.of(context);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  ProfileModel? profileModel;
  getUserDetails() {
    emit(UserDetailsLoadingState());
    DioHelper.getData(url: 'auth/profile').then((value) {
      profileModel = ProfileModel.fromJson(value!.data);
      emit(UserDetailsSuccessState(profileModel!));
    }).catchError((error) {
      emit(UserDetailsErrorState(error.toString()));
    });
  }

  UserStatusModel? userStatusModel;
  getUserStatus() {
    emit(UserStatusLoadingState());
    DioHelper.getData(url: 'attendance/status').then((value) {
      userStatusModel = UserStatusModel.fromJson(value!.data);
      emit(UserStatusSuccessState(userStatusModel!));
    }).catchError((error) {
      emit(UserStatusErrorState(error.toString()));
    });
  }

  logout() {
    emit(LogOutLoadingState());
    DioHelper.getData(url: 'auth/logout').then((value) {
      final message = value?.data['message'] ?? "logout successfully";
      emit(LogOutSuccessState(message));
    }).catchError((error) {
      emit(LogOutErrorState(error.toString()));
    });
  }
}
