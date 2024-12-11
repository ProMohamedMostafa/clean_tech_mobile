import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_cleaning_application/core/helpers/cache_helper/cache_helper.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_factory/dio_factory.dart';
import 'package:smart_cleaning_application/features/screens/auth/login/logic/login_cubit_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  // SignInModel? signInModel;

  userLogin() async {
    emit(LoginLoadingState());
    // final response = await _loginRepo.login(
    //   LoginRequestBody(
    //     email: emailController.text,
    //     password: passwordController.text,
    //   ),
    // );
    // response.when(success: (loginResponse) async {
    //   await saveUserToken(loginResponse.userData?.token ?? '');
    //   emit(LoginSuccessState());
    // }, failure: (error) {
    //   emit(LoginErrorState(error));
    // });
  }

  Future<void> saveUserToken(String token) async {
    await CacheHelper.setSecuredString(SharedPrefKeys.userToken, token);
    DioFactory.setTokenIntoHeaderAfterLogin(token);
  }

  IconData suffixIcon = Icons.visibility_outlined;
  bool ispassword = true;
  changeSuffixIconVisiability() {
    ispassword = !ispassword;
    suffixIcon =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeSuffixIconVisiabiltyState());
  }

  // Locale functionality
  Locale locale = const Locale('en');

  Future<void> getSavedLanguage() async {
    final String cachedLanguageCode =
        await LanguageCacheHelper().getCachedLanguageCode();
    locale = Locale(cachedLanguageCode);
    emit(ChangeLocaleState(locale: locale));
  }

  Future<void> changeLanguage(String languageCode) async {
    await LanguageCacheHelper()
        .cacheLanguageCode(languageCode); // Save the new language
    locale = Locale(languageCode); // Update the current locale
    emit(ChangeLocaleState(locale: locale)); // Emit the state change
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
