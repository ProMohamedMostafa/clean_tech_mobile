import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/settings/logic/settings_state.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_status_model.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitialState());

  static SettingsCubit get(context) => BlocProvider.of(context);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  UserDetailsModel? userDetailsModel;
  getUserDetails() {
    emit(UserDetailsLoadingState());
    DioHelper.getData(url: 'users/$uId').then((value) {
      userDetailsModel = UserDetailsModel.fromJson(value!.data);
      emit(UserDetailsSuccessState(userDetailsModel!));
    }).catchError((error) {
      emit(UserDetailsErrorState(error.toString()));
    });
  }

  UserStatusModel? userStatusModel;
  getUserStatus() {
    emit(UserStatusLoadingState());
    DioHelper.getData(url: 'attendance/status', query: {'userId': uId})
        .then((value) {
      userStatusModel = UserStatusModel.fromJson(value!.data);
      emit(UserStatusSuccessState(userStatusModel!));
    }).catchError((error) {
      emit(UserStatusErrorState(error.toString()));
    });
  }
}
