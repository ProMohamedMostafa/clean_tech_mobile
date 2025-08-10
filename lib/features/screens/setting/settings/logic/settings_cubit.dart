import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/helpers/cache_helper/cache_helper.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/setting/settings/data/model/profile_model.dart';
import 'package:smart_cleaning_application/features/screens/setting/settings/logic/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitialState());

  static SettingsCubit get(context) => BlocProvider.of(context);

  bool isNotificationEnabled = true;

  Future<void> toggleNotification() async {
    isNotificationEnabled = !isNotificationEnabled;
    await CacheHelper.setData(
        key: 'notification', value: isNotificationEnabled);

    if (isNotificationEnabled) {
      await FirebaseMessaging.instance.subscribeToTopic('notifications');
    } else {
      await FirebaseMessaging.instance.unsubscribeFromTopic('notifications');
    }

    emit(NotificationToggleChangedState());
  }

  Future<void> initializeNotificationStatus() async {
    isNotificationEnabled = await CacheHelper.getBool('notification') ?? true;

    if (!isNotificationEnabled) {
      await FirebaseMessaging.instance.unsubscribeFromTopic('notifications');
    }

    emit(NotificationToggleChangedState());
  }

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

  logout() async {
    emit(LogOutLoadingState());
    try {
      await deleteToken();
      final response = await DioHelper.getData(url: 'auth/logout');
      final message = response?.data['message'] ?? "Logged out successfully";

      await CacheHelper.clearAllSecuredData();
      await clearSessionData();

      emit(LogOutSuccessState(message));
    } catch (error) {
      emit(LogOutErrorState(error.toString()));
    }
  }

  deleteToken() {
    emit(DeleteTokenLoadingState());
    DioHelper.deleteData(
        url: 'device/token/delete', data: {'token': deviceToken}).then((value) {
      final message = value?.data['message'] ?? "deleted successfully";
      emit(DeleteTokenSuccessState(message));
    }).catchError((error) {
      emit(DeleteTokenErrorState(error.toString()));
    });
  }

  static Future<void> clearSessionData() async {
    token = null;
    uId = null;
    role = null;
    await CacheHelper.removeData(SharedPrefKeys.userToken);
    await CacheHelper.removeData(SharedPrefKeys.userId);
    await CacheHelper.removeData(SharedPrefKeys.userRole);
  }

  bool isEnglish() {
    return Intl.getCurrentLocale() == 'en';
  }
}

class NotificationSettings {
  static bool isNotificationEnabled = true;
}
