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
  bool isNotOpenNotif = true;
  bool isNotDark = true;

  Future<void> toggleNotification() async {
    isNotOpenNotif = !isNotOpenNotif;
    await CacheHelper.setData(key: 'notification', value: isNotOpenNotif);

    // Only manage Firebase subscription here
    if (isNotOpenNotif) {
      await FirebaseMessaging.instance.unsubscribeFromTopic('notifications');
    } else {
      await FirebaseMessaging.instance.subscribeToTopic('notifications');
    }

    emit(NotificationToggleChangedState());
  }

  // Initialize notification status
  Future<void> initializeNotificationStatus() async {
    isNotOpenNotif = await CacheHelper.getBool('notification') ?? false;
    // Set initial subscription state
    if (isNotOpenNotif) {
      await FirebaseMessaging.instance.unsubscribeFromTopic('notifications');
    }
    emit(NotificationToggleChangedState());
  }

  getDarkModeStatus() async {
    isNotDark = await CacheHelper.getBool('darkMode') ?? false;
    emit(DarkModeToggleChangedState());
  }

  toggleDarkMode() async {
    isNotDark = !isNotDark;
    await CacheHelper.setData(key: 'darkMode', value: isNotDark);
    emit(DarkModeToggleChangedState());
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

  logout() {
    emit(LogOutLoadingState());
    DioHelper.getData(url: 'auth/logout').then((value) async {
      final message = value?.data['message'] ?? "logout successfully";

      await CacheHelper.clearAllSecuredData();
      await clearSessionData();
      emit(LogOutSuccessState(message));
    }).catchError((error) {
      emit(LogOutErrorState(error.toString()));
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
