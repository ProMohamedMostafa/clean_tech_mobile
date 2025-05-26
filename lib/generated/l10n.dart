// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get loginTitle1 {
    return Intl.message('Login', name: 'loginTitle1', desc: '', args: []);
  }

  /// `Login to access your Clean Tech  account`
  String get loginTitle2 {
    return Intl.message(
      'Login to access your Clean Tech  account',
      name: 'loginTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Email or userName`
  String get labelEmail {
    return Intl.message(
      'Email or userName',
      name: 'labelEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get labelPassword {
    return Intl.message('Password', name: 'labelPassword', desc: '', args: []);
  }

  /// `Invalid email address`
  String get validationEmail {
    return Intl.message(
      'Invalid email address',
      name: 'validationEmail',
      desc: '',
      args: [],
    );
  }

  /// `Invalid code`
  String get validationVerify {
    return Intl.message(
      'Invalid code',
      name: 'validationVerify',
      desc: '',
      args: [],
    );
  }

  /// `User name is required`
  String get validationUserName {
    return Intl.message(
      'User name is required',
      name: 'validationUserName',
      desc: '',
      args: [],
    );
  }

  /// `First name is required`
  String get validationFirstName {
    return Intl.message(
      'First name is required',
      name: 'validationFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Last name is required`
  String get validationLastName {
    return Intl.message(
      'Last name is required',
      name: 'validationLastName',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get validationAddEmail {
    return Intl.message(
      'Email is required',
      name: 'validationAddEmail',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email format`
  String get validationAddEmail2 {
    return Intl.message(
      'Invalid email format',
      name: 'validationAddEmail2',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get validationAddPassword {
    return Intl.message(
      'Password is required',
      name: 'validationAddPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password confirmation is required`
  String get validationAddPasswordConfirmation {
    return Intl.message(
      'Password confirmation is required',
      name: 'validationAddPasswordConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `ID number is required`
  String get validationIdNumber {
    return Intl.message(
      'ID number is required',
      name: 'validationIdNumber',
      desc: '',
      args: [],
    );
  }

  /// `Country is required`
  String get validationNationality {
    return Intl.message(
      'Country is required',
      name: 'validationNationality',
      desc: '',
      args: [],
    );
  }

  /// `Selected Country is required`
  String get validationCountry {
    return Intl.message(
      'Selected Country is required',
      name: 'validationCountry',
      desc: '',
      args: [],
    );
  }

  /// `Selected Role is required`
  String get validationRole {
    return Intl.message(
      'Selected Role is required',
      name: 'validationRole',
      desc: '',
      args: [],
    );
  }

  /// `Selected Manager is required`
  String get validationManager {
    return Intl.message(
      'Selected Manager is required',
      name: 'validationManager',
      desc: '',
      args: [],
    );
  }

  /// `Gender is required`
  String get validationGender {
    return Intl.message(
      'Gender is required',
      name: 'validationGender',
      desc: '',
      args: [],
    );
  }

  /// `Provider is required`
  String get validationProvider {
    return Intl.message(
      'Provider is required',
      name: 'validationProvider',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is required`
  String get validationPhoneNumber {
    return Intl.message(
      'Phone number is required',
      name: 'validationPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Choose Birthdate is required`
  String get validationBirthdate {
    return Intl.message(
      'Choose Birthdate is required',
      name: 'validationBirthdate',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassButton {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassButton',
      desc: '',
      args: [],
    );
  }

  /// `Password not matched`
  String get validationRepeatPassword {
    return Intl.message(
      'Password not matched',
      name: 'validationRepeatPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginButton {
    return Intl.message('Login', name: 'loginButton', desc: '', args: []);
  }

  /// `Terms & Conditions and Conditions`
  String get termsConditions {
    return Intl.message(
      'Terms & Conditions and Conditions',
      name: 'termsConditions',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get forgotPassScreenTitle1 {
    return Intl.message(
      'Forgot your password?',
      name: 'forgotPassScreenTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Don’t worry, happens to all of us. Enter your email below to recover your password`
  String get forgotPassScreenTitle2 {
    return Intl.message(
      'Don’t worry, happens to all of us. Enter your email below to recover your password',
      name: 'forgotPassScreenTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get forgotPassScreenTextField {
    return Intl.message(
      'Email',
      name: 'forgotPassScreenTextField',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submitButton {
    return Intl.message('Submit', name: 'submitButton', desc: '', args: []);
  }

  /// `Verify code`
  String get verifyAccountScreenTitle1 {
    return Intl.message(
      'Verify code',
      name: 'verifyAccountScreenTitle1',
      desc: '',
      args: [],
    );
  }

  /// `An authentication code has been sent to your email.`
  String get verifyAccountScreenTitle2 {
    return Intl.message(
      'An authentication code has been sent to your email.',
      name: 'verifyAccountScreenTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Didn’t receive a code?`
  String get verifyAccountScreenTitle3 {
    return Intl.message(
      'Didn’t receive a code?',
      name: 'verifyAccountScreenTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Enter Code`
  String get verifyAccountScreenTextField {
    return Intl.message(
      'Enter Code',
      name: 'verifyAccountScreenTextField',
      desc: '',
      args: [],
    );
  }

  /// ` Resend`
  String get resendButton {
    return Intl.message(' Resend', name: 'resendButton', desc: '', args: []);
  }

  /// `Verify`
  String get verifyButton {
    return Intl.message('Verify', name: 'verifyButton', desc: '', args: []);
  }

  /// `Set a new password`
  String get setPassTitle1 {
    return Intl.message(
      'Set a new password',
      name: 'setPassTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Your new password must be unique from those previously used.`
  String get setPassTitle2 {
    return Intl.message(
      'Your new password must be unique from those previously used.',
      name: 'setPassTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Create New Password`
  String get setPassTextField1 {
    return Intl.message(
      'Create New Password',
      name: 'setPassTextField1',
      desc: '',
      args: [],
    );
  }

  /// `Re-enter Password`
  String get setPassTextField2 {
    return Intl.message(
      'Re-enter Password',
      name: 'setPassTextField2',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get setButton {
    return Intl.message(
      'Reset Password',
      name: 'setButton',
      desc: '',
      args: [],
    );
  }

  /// `At least 1 lowercase letter`
  String get createPass1 {
    return Intl.message(
      'At least 1 lowercase letter',
      name: 'createPass1',
      desc: '',
      args: [],
    );
  }

  /// `At least 1 uppercase letter`
  String get createPass2 {
    return Intl.message(
      'At least 1 uppercase letter',
      name: 'createPass2',
      desc: '',
      args: [],
    );
  }

  /// `At least 1 special character`
  String get createPass3 {
    return Intl.message(
      'At least 1 special character',
      name: 'createPass3',
      desc: '',
      args: [],
    );
  }

  /// `At least 1 number`
  String get createPass4 {
    return Intl.message(
      'At least 1 number',
      name: 'createPass4',
      desc: '',
      args: [],
    );
  }

  /// `At least 8 characters long`
  String get createPass5 {
    return Intl.message(
      'At least 8 characters long',
      name: 'createPass5',
      desc: '',
      args: [],
    );
  }

  /// `Password Changed!`
  String get doneTitl1 {
    return Intl.message(
      'Password Changed!',
      name: 'doneTitl1',
      desc: '',
      args: [],
    );
  }

  /// `Your password has been changed successfully.`
  String get doneTitl2 {
    return Intl.message(
      'Your password has been changed successfully.',
      name: 'doneTitl2',
      desc: '',
      args: [],
    );
  }

  /// `Back to login`
  String get donebutton {
    return Intl.message(
      'Back to login',
      name: 'donebutton',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get botNavTitle1 {
    return Intl.message('Home', name: 'botNavTitle1', desc: '', args: []);
  }

  /// `Analytics`
  String get botNavTitle2 {
    return Intl.message('Analytics', name: 'botNavTitle2', desc: '', args: []);
  }

  /// `Calendar`
  String get botNavTitle3 {
    return Intl.message('Calendar', name: 'botNavTitle3', desc: '', args: []);
  }

  /// `Integrations`
  String get botNavTitle4 {
    return Intl.message(
      'Integrations',
      name: 'botNavTitle4',
      desc: '',
      args: [],
    );
  }

  /// `User Management`
  String get integ1 {
    return Intl.message('User Management', name: 'integ1', desc: '', args: []);
  }

  /// `Organizations`
  String get integ2 {
    return Intl.message('Organizations', name: 'integ2', desc: '', args: []);
  }

  /// `Add Task`
  String get integ3 {
    return Intl.message('Add Task', name: 'integ3', desc: '', args: []);
  }

  /// `Reports`
  String get integ4 {
    return Intl.message('Reports', name: 'integ4', desc: '', args: []);
  }

  /// `Settings`
  String get integ5 {
    return Intl.message('Settings', name: 'integ5', desc: '', args: []);
  }

  /// `Change personal information`
  String get settingTitle1 {
    return Intl.message(
      'Change personal information',
      name: 'settingTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get settingTitle2 {
    return Intl.message(
      'Change password',
      name: 'settingTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Sharing App`
  String get settingTitle3 {
    return Intl.message(
      'Sharing App',
      name: 'settingTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Technical Support`
  String get settingTitle4 {
    return Intl.message(
      'Technical Support',
      name: 'settingTitle4',
      desc: '',
      args: [],
    );
  }

  /// `Our Website`
  String get settingTitle5 {
    return Intl.message(
      'Our Website',
      name: 'settingTitle5',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get settingTitle6 {
    return Intl.message('Languages', name: 'settingTitle6', desc: '', args: []);
  }

  /// `Notification`
  String get settingTitle7 {
    return Intl.message(
      'Notification',
      name: 'settingTitle7',
      desc: '',
      args: [],
    );
  }

  /// `Night Mode`
  String get settingTitle8 {
    return Intl.message(
      'Night Mode',
      name: 'settingTitle8',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get settingTitle9 {
    return Intl.message('Log out', name: 'settingTitle9', desc: '', args: []);
  }

  /// `Add User`
  String get addUserTitle {
    return Intl.message('Add User', name: 'addUserTitle', desc: '', args: []);
  }

  /// `First Name`
  String get addUserText1 {
    return Intl.message('First Name', name: 'addUserText1', desc: '', args: []);
  }

  /// `Last Name`
  String get addUserText2 {
    return Intl.message('Last Name', name: 'addUserText2', desc: '', args: []);
  }

  /// `Email`
  String get addUserText3 {
    return Intl.message('Email', name: 'addUserText3', desc: '', args: []);
  }

  /// `Birthdate`
  String get addUserText4 {
    return Intl.message('Birthdate', name: 'addUserText4', desc: '', args: []);
  }

  /// `User Name`
  String get addUserText5 {
    return Intl.message('User Name', name: 'addUserText5', desc: '', args: []);
  }

  /// `Password`
  String get addUserText6 {
    return Intl.message('Password', name: 'addUserText6', desc: '', args: []);
  }

  /// `ID Number`
  String get addUserText7 {
    return Intl.message('ID Number', name: 'addUserText7', desc: '', args: []);
  }

  /// `Nationality`
  String get addUserText8 {
    return Intl.message(
      'Nationality',
      name: 'addUserText8',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get addUserText9 {
    return Intl.message('Gender', name: 'addUserText9', desc: '', args: []);
  }

  /// `Phone Number`
  String get addUserText10 {
    return Intl.message(
      'Phone Number',
      name: 'addUserText10',
      desc: '',
      args: [],
    );
  }

  /// `Password Confirmation`
  String get addUserText11 {
    return Intl.message(
      'Password Confirmation',
      name: 'addUserText11',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get addUserText12 {
    return Intl.message('Country', name: 'addUserText12', desc: '', args: []);
  }

  /// `Role`
  String get addUserText13 {
    return Intl.message('Role', name: 'addUserText13', desc: '', args: []);
  }

  /// `Manager`
  String get addUserText14 {
    return Intl.message('Manager', name: 'addUserText14', desc: '', args: []);
  }

  /// `Provider`
  String get addUserText15 {
    return Intl.message('Provider', name: 'addUserText15', desc: '', args: []);
  }

  /// `Add User`
  String get addUserButton {
    return Intl.message('Add User', name: 'addUserButton', desc: '', args: []);
  }

  /// `Add Another`
  String get addAnotherButton {
    return Intl.message(
      'Add Another',
      name: 'addAnotherButton',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get saveButtton {
    return Intl.message('Save', name: 'saveButtton', desc: '', args: []);
  }

  /// `NO`
  String get noButtton {
    return Intl.message('NO', name: 'noButtton', desc: '', args: []);
  }

  /// `Yes, i’m sure`
  String get yesButtton {
    return Intl.message(
      'Yes, i’m sure',
      name: 'yesButtton',
      desc: '',
      args: [],
    );
  }

  /// `Are You Sure You Want To Remove This User ?`
  String get deleteMessage {
    return Intl.message(
      'Are You Sure You Want To Remove This User ?',
      name: 'deleteMessage',
      desc: '',
      args: [],
    );
  }

  /// `Edit User`
  String get editUserTitle {
    return Intl.message('Edit User', name: 'editUserTitle', desc: '', args: []);
  }

  /// `User Details`
  String get userDetailsTitle {
    return Intl.message(
      'User Details',
      name: 'userDetailsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get deleteButton {
    return Intl.message('Delete', name: 'deleteButton', desc: '', args: []);
  }

  /// `Edit`
  String get editButton {
    return Intl.message('Edit', name: 'editButton', desc: '', args: []);
  }

  /// `Welcome!`
  String get welcome {
    return Intl.message('Welcome!', name: 'welcome', desc: '', args: []);
  }

  /// `Experience a seamless way to manage\ncleaning services with just a few taps on your phone!`
  String get experienceDescription {
    return Intl.message(
      'Experience a seamless way to manage\ncleaning services with just a few taps on your phone!',
      name: 'experienceDescription',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get nextButton {
    return Intl.message('Next', name: 'nextButton', desc: '', args: []);
  }

  /// `Login to access your Clean Tech\naccount`
  String get loginMessage {
    return Intl.message(
      'Login to access your Clean Tech\naccount',
      name: 'loginMessage',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email address or userName`
  String get validationEmailAndUser {
    return Intl.message(
      'Invalid email address or userName',
      name: 'validationEmailAndUser',
      desc: '',
      args: [],
    );
  }

  /// `Username or email is too long`
  String get validationUsernameTooLong {
    return Intl.message(
      'Username or email is too long',
      name: 'validationUsernameTooLong',
      desc: '',
      args: [],
    );
  }

  /// `Username or email is too short`
  String get validationUsernameTooShort {
    return Intl.message(
      'Username or email is too short',
      name: 'validationUsernameTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Invalid password`
  String get validationPassword {
    return Intl.message(
      'Invalid password',
      name: 'validationPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password is incorrect`
  String get validationPasswordIncorrect {
    return Intl.message(
      'Password is incorrect',
      name: 'validationPasswordIncorrect',
      desc: '',
      args: [],
    );
  }

  /// `Email is too long`
  String get validationEmailTooLong {
    return Intl.message(
      'Email is too long',
      name: 'validationEmailTooLong',
      desc: '',
      args: [],
    );
  }

  /// `Email is too short`
  String get validationEmailTooShort {
    return Intl.message(
      'Email is too short',
      name: 'validationEmailTooShort',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'ur'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
