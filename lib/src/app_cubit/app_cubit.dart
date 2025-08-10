import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/notification/data/model/notification_model.dart';
import 'package:smart_cleaning_application/src/app_cubit/app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(BuildContext context) =>
      BlocProvider.of<AppCubit>(context);

  Locale locale = Locale('en');

  Future<void> getSavedLanguage() async {
    final String cachedLanguageCode =
        await LanguageCacheHelper().getCachedLanguageCode();
    locale = Locale(cachedLanguageCode);
    emit(ChangeLocaleState(locale: locale));
  }

  Future<void> changeLanguage(String languageCode) async {
    await LanguageCacheHelper().cacheLanguageCode(languageCode);
    locale = Locale(languageCode);
    emit(ChangeLocaleState(locale: locale));
  }

  Future<void> initNotifications(BuildContext context) async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    deviceToken = await FirebaseMessaging.instance.getToken();
  }

  NotificationModel? notificationModel;

  void getUnReadNotification() {
    emit(UnReadNotificationLoadingState());
    DioHelper.getData(url: 'notifications', query: {'IsRead': false})
        .then((value) {
      notificationModel = NotificationModel.fromJson(value!.data);
      emit(UnReadNotificationSuccessState(notificationModel!));
    }).catchError((error) {
      emit(UnReadNotificationErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  void changeCarouselIndex(int index) {
    currentIndex = index;
    emit(ChangeCarouselIndexState());
  }
}

class LanguageCacheHelper {
  Future<void> cacheLanguageCode(String languageCode) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("LOCALE", languageCode);
  }

  Future<String> getCachedLanguageCode() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("LOCALE") ?? "en";
  }
}
