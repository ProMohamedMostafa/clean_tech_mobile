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

  /// `Integrations`
  String get botNavTitle2 {
    return Intl.message(
      'Integrations',
      name: 'botNavTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Calendar`
  String get botNavTitle3 {
    return Intl.message('Calendar', name: 'botNavTitle3', desc: '', args: []);
  }

  /// `Settings`
  String get botNavTitle4 {
    return Intl.message('Settings', name: 'botNavTitle4', desc: '', args: []);
  }

  /// `Users Management`
  String get integ1 {
    return Intl.message('Users Management', name: 'integ1', desc: '', args: []);
  }

  /// `Work Locations`
  String get integ2 {
    return Intl.message('Work Locations', name: 'integ2', desc: '', args: []);
  }

  /// `Assign Management`
  String get integ3 {
    return Intl.message(
      'Assign Management',
      name: 'integ3',
      desc: '',
      args: [],
    );
  }

  /// `Shifts`
  String get integ4 {
    return Intl.message('Shifts', name: 'integ4', desc: '', args: []);
  }

  /// `Tasks`
  String get integ5 {
    return Intl.message('Tasks', name: 'integ5', desc: '', args: []);
  }

  /// `Attendance`
  String get integ6 {
    return Intl.message('Attendance', name: 'integ6', desc: '', args: []);
  }

  /// `Stock`
  String get integ7 {
    return Intl.message('Stock', name: 'integ7', desc: '', args: []);
  }

  /// `Activities`
  String get integ8 {
    return Intl.message('Activities', name: 'integ8', desc: '', args: []);
  }

  /// `Sensors`
  String get integ9 {
    return Intl.message('Sensors', name: 'integ9', desc: '', args: []);
  }

  /// `Providers`
  String get integ10 {
    return Intl.message('Providers', name: 'integ10', desc: '', args: []);
  }

  /// `Integrations`
  String get integrations {
    return Intl.message(
      'Integrations',
      name: 'integrations',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get settingTitle1 {
    return Intl.message('Profile', name: 'settingTitle1', desc: '', args: []);
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

  /// `Please enter your pin code`
  String get validationPinCodeEmpty {
    return Intl.message(
      'Please enter your pin code',
      name: 'validationPinCodeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Hey, `
  String get hey {
    return Intl.message('Hey, ', name: 'hey', desc: '', args: []);
  }

  /// `Show Activity`
  String get showActivity {
    return Intl.message(
      'Show Activity',
      name: 'showActivity',
      desc: '',
      args: [],
    );
  }

  /// `My Activity`
  String get myActivity {
    return Intl.message('My Activity', name: 'myActivity', desc: '', args: []);
  }

  /// `My Team Activity`
  String get myTeamActivity {
    return Intl.message(
      'My Team Activity',
      name: 'myTeamActivity',
      desc: '',
      args: [],
    );
  }

  /// `See More`
  String get seeMoreButton {
    return Intl.message('See More', name: 'seeMoreButton', desc: '', args: []);
  }

  /// `Material Count`
  String get materialCount {
    return Intl.message(
      'Material Count',
      name: 'materialCount',
      desc: '',
      args: [],
    );
  }

  /// `In Cost`
  String get inCost {
    return Intl.message('In Cost', name: 'inCost', desc: '', args: []);
  }

  /// `Cancel`
  String get cancelButton {
    return Intl.message('Cancel', name: 'cancelButton', desc: '', args: []);
  }

  /// `Save`
  String get saveButton {
    return Intl.message('Save', name: 'saveButton', desc: '', args: []);
  }

  /// `Users`
  String get users {
    return Intl.message('Users', name: 'users', desc: '', args: []);
  }

  /// `Admin`
  String get admin {
    return Intl.message('Admin', name: 'admin', desc: '', args: []);
  }

  /// `Manager`
  String get manager {
    return Intl.message('Manager', name: 'manager', desc: '', args: []);
  }

  /// `Supervisor`
  String get supervisor {
    return Intl.message('Supervisor', name: 'supervisor', desc: '', args: []);
  }

  /// `Cleaner`
  String get cleaner {
    return Intl.message('Cleaner', name: 'cleaner', desc: '', args: []);
  }

  /// `Attendance`
  String get attendance {
    return Intl.message('Attendance', name: 'attendance', desc: '', args: []);
  }

  /// `Present`
  String get present {
    return Intl.message('Present', name: 'present', desc: '', args: []);
  }

  /// `Absent`
  String get absent {
    return Intl.message('Absent', name: 'absent', desc: '', args: []);
  }

  /// `Leaves`
  String get leaves {
    return Intl.message('Leaves', name: 'leaves', desc: '', args: []);
  }

  /// `Total Shifts`
  String get totalShifts {
    return Intl.message(
      'Total Shifts',
      name: 'totalShifts',
      desc: '',
      args: [],
    );
  }

  /// `InActive`
  String get inactive {
    return Intl.message('InActive', name: 'inactive', desc: '', args: []);
  }

  /// `Active`
  String get active {
    return Intl.message('Active', name: 'active', desc: '', args: []);
  }

  /// `High`
  String get high {
    return Intl.message('High', name: 'high', desc: '', args: []);
  }

  /// `Medium`
  String get medium {
    return Intl.message('Medium', name: 'medium', desc: '', args: []);
  }

  /// `Low`
  String get low {
    return Intl.message('Low', name: 'low', desc: '', args: []);
  }

  /// `Tasks`
  String get tasks {
    return Intl.message('Tasks', name: 'tasks', desc: '', args: []);
  }

  /// `Pending`
  String get pending {
    return Intl.message('Pending', name: 'pending', desc: '', args: []);
  }

  /// `In Progress`
  String get inProgress {
    return Intl.message('In Progress', name: 'inProgress', desc: '', args: []);
  }

  /// `Waiting for Approvable`
  String get waitingForApproval {
    return Intl.message(
      'Waiting for Approvable',
      name: 'waitingForApproval',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get complete {
    return Intl.message('Complete', name: 'complete', desc: '', args: []);
  }

  /// `Not Resolved`
  String get notResolved {
    return Intl.message(
      'Not Resolved',
      name: 'notResolved',
      desc: '',
      args: [],
    );
  }

  /// `Overdue`
  String get overdue {
    return Intl.message('Overdue', name: 'overdue', desc: '', args: []);
  }

  /// `Stock Quantity`
  String get stockQuantity {
    return Intl.message(
      'Stock Quantity',
      name: 'stockQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Line`
  String get chartLine {
    return Intl.message('Line', name: 'chartLine', desc: '', args: []);
  }

  /// `Bar`
  String get chartBar {
    return Intl.message('Bar', name: 'chartBar', desc: '', args: []);
  }

  /// `Pie`
  String get chartPie {
    return Intl.message('Pie', name: 'chartPie', desc: '', args: []);
  }

  /// `In side`
  String get inSide {
    return Intl.message('In side', name: 'inSide', desc: '', args: []);
  }

  /// `Out side`
  String get outSide {
    return Intl.message('Out side', name: 'outSide', desc: '', args: []);
  }

  /// `Task completion rate`
  String get taskCompletionRate {
    return Intl.message(
      'Task completion rate',
      name: 'taskCompletionRate',
      desc: '',
      args: [],
    );
  }

  /// `Total Task`
  String get totalTask {
    return Intl.message('Total Task', name: 'totalTask', desc: '', args: []);
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Already marked as read`
  String get alreadyMarkedAsRead {
    return Intl.message(
      'Already marked as read',
      name: 'alreadyMarkedAsRead',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Unread`
  String get unread {
    return Intl.message('Unread', name: 'unread', desc: '', args: []);
  }

  /// `Calendar`
  String get calendar {
    return Intl.message('Calendar', name: 'calendar', desc: '', args: []);
  }

  /// `No tasks available`
  String get noTasksAvailable {
    return Intl.message(
      'No tasks available',
      name: 'noTasksAvailable',
      desc: '',
      args: [],
    );
  }

  /// `User Management`
  String get userManagement {
    return Intl.message(
      'User Management',
      name: 'userManagement',
      desc: '',
      args: [],
    );
  }

  /// `Total Users`
  String get totalUsers {
    return Intl.message('Total Users', name: 'totalUsers', desc: '', args: []);
  }

  /// `Deleted Users`
  String get deletedUsers {
    return Intl.message(
      'Deleted Users',
      name: 'deletedUsers',
      desc: '',
      args: [],
    );
  }

  /// `Find someone`
  String get findSomeone {
    return Intl.message(
      'Find someone',
      name: 'findSomeone',
      desc: '',
      args: [],
    );
  }

  /// `There's no data`
  String get noData {
    return Intl.message('There\'s no data', name: 'noData', desc: '', args: []);
  }

  /// `Admin`
  String get roleAdmin {
    return Intl.message('Admin', name: 'roleAdmin', desc: '', args: []);
  }

  /// `Manager`
  String get roleManager {
    return Intl.message('Manager', name: 'roleManager', desc: '', args: []);
  }

  /// `Supervisor`
  String get roleSupervisor {
    return Intl.message(
      'Supervisor',
      name: 'roleSupervisor',
      desc: '',
      args: [],
    );
  }

  /// `Users`
  String get roleUsers {
    return Intl.message('Users', name: 'roleUsers', desc: '', args: []);
  }

  /// `No Admins available`
  String get noAdminsAvailable {
    return Intl.message(
      'No Admins available',
      name: 'noAdminsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `No Managers available`
  String get noManagersAvailable {
    return Intl.message(
      'No Managers available',
      name: 'noManagersAvailable',
      desc: '',
      args: [],
    );
  }

  /// `No Supervisors available`
  String get noSupervisorsAvailable {
    return Intl.message(
      'No Supervisors available',
      name: 'noSupervisorsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `No Users available`
  String get noUsersAvailable {
    return Intl.message(
      'No Users available',
      name: 'noUsersAvailable',
      desc: '',
      args: [],
    );
  }

  /// `First name must be less than 55 characters`
  String get validationFirstNameTooLong {
    return Intl.message(
      'First name must be less than 55 characters',
      name: 'validationFirstNameTooLong',
      desc: '',
      args: [],
    );
  }

  /// `First name must be at least 3 characters`
  String get validationFirstNameTooShort {
    return Intl.message(
      'First name must be at least 3 characters',
      name: 'validationFirstNameTooShort',
      desc: '',
      args: [],
    );
  }

  /// `First name must contain only letters`
  String get validationFirstNameOnlyLetters {
    return Intl.message(
      'First name must contain only letters',
      name: 'validationFirstNameOnlyLetters',
      desc: '',
      args: [],
    );
  }

  /// `Last name must be less than 55 characters`
  String get validationLastNameTooLong {
    return Intl.message(
      'Last name must be less than 55 characters',
      name: 'validationLastNameTooLong',
      desc: '',
      args: [],
    );
  }

  /// `Last name must be at least 3 characters`
  String get validationLastNameTooShort {
    return Intl.message(
      'Last name must be at least 3 characters',
      name: 'validationLastNameTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Last name must contain only letters`
  String get validationLastNameOnlyLetters {
    return Intl.message(
      'Last name must contain only letters',
      name: 'validationLastNameOnlyLetters',
      desc: '',
      args: [],
    );
  }

  /// `Username must be less than 55 characters`
  String get validationUserNameTooLong {
    return Intl.message(
      'Username must be less than 55 characters',
      name: 'validationUserNameTooLong',
      desc: '',
      args: [],
    );
  }

  /// `Username must be at least 3 characters`
  String get validationUserNameTooShort {
    return Intl.message(
      'Username must be at least 3 characters',
      name: 'validationUserNameTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get validationValidEmail {
    return Intl.message(
      'Please enter a valid email address',
      name: 'validationValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid mobile number`
  String get validationValidMobileNumber {
    return Intl.message(
      'Please enter a valid mobile number',
      name: 'validationValidMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `123456789`
  String get hintPhoneNumber {
    return Intl.message(
      '123456789',
      name: 'hintPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Select Country`
  String get hintSelectCountry {
    return Intl.message(
      'Select Country',
      name: 'hintSelectCountry',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get hintSelectGender {
    return Intl.message('Gender', name: 'hintSelectGender', desc: '', args: []);
  }

  /// `Male`
  String get genderMale {
    return Intl.message('Male', name: 'genderMale', desc: '', args: []);
  }

  /// `Female`
  String get genderFemale {
    return Intl.message('Female', name: 'genderFemale', desc: '', args: []);
  }

  /// `Select Nationality`
  String get hintSelectNationality {
    return Intl.message(
      'Select Nationality',
      name: 'hintSelectNationality',
      desc: '',
      args: [],
    );
  }

  /// `Select Role`
  String get hintSelectRole {
    return Intl.message(
      'Select Role',
      name: 'hintSelectRole',
      desc: '',
      args: [],
    );
  }

  /// `No roles available`
  String get noRolesAvailable {
    return Intl.message(
      'No roles available',
      name: 'noRolesAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Birth date is required`
  String get validationBirthDateRequired {
    return Intl.message(
      'Birth date is required',
      name: 'validationBirthDateRequired',
      desc: '',
      args: [],
    );
  }

  /// `ID number must be less than 20 characters`
  String get validationIdNumberTooLong {
    return Intl.message(
      'ID number must be less than 20 characters',
      name: 'validationIdNumberTooLong',
      desc: '',
      args: [],
    );
  }

  /// `ID number must be at least 5 characters`
  String get validationIdNumberTooShort {
    return Intl.message(
      'ID number must be at least 5 characters',
      name: 'validationIdNumberTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Select Provider`
  String get hintSelectProvider {
    return Intl.message(
      'Select Provider',
      name: 'hintSelectProvider',
      desc: '',
      args: [],
    );
  }

  /// ` (Optional)`
  String get labelOptional {
    return Intl.message(
      ' (Optional)',
      name: 'labelOptional',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to save the edit of this user?`
  String get confirmSaveEdit {
    return Intl.message(
      'Are you sure you want to save the edit of this user?',
      name: 'confirmSaveEdit',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to restore this user?`
  String get confirmRestoreUser {
    return Intl.message(
      'Are you sure to restore this user?',
      name: 'confirmRestoreUser',
      desc: '',
      args: [],
    );
  }

  /// `Force delete this user?`
  String get confirmForcedDelete {
    return Intl.message(
      'Force delete this user?',
      name: 'confirmForcedDelete',
      desc: '',
      args: [],
    );
  }

  /// `No Manager`
  String get noManager {
    return Intl.message('No Manager', name: 'noManager', desc: '', args: []);
  }

  /// `No Provider`
  String get noProvider {
    return Intl.message('No Provider', name: 'noProvider', desc: '', args: []);
  }

  /// `User Details`
  String get userDetails {
    return Intl.message(
      'User Details',
      name: 'userDetails',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get Filter {
    return Intl.message('Filter', name: 'Filter', desc: '', args: []);
  }

  /// `Area`
  String get Area {
    return Intl.message('Area', name: 'Area', desc: '', args: []);
  }

  /// `City`
  String get City {
    return Intl.message('City', name: 'City', desc: '', args: []);
  }

  /// `Organization`
  String get Organization {
    return Intl.message(
      'Organization',
      name: 'Organization',
      desc: '',
      args: [],
    );
  }

  /// `Building`
  String get Building {
    return Intl.message('Building', name: 'Building', desc: '', args: []);
  }

  /// `Floor`
  String get Floor {
    return Intl.message('Floor', name: 'Floor', desc: '', args: []);
  }

  /// `Section`
  String get Section {
    return Intl.message('Section', name: 'Section', desc: '', args: []);
  }

  /// `Point`
  String get Point {
    return Intl.message('Point', name: 'Point', desc: '', args: []);
  }

  /// `All sensors`
  String get sensorFirstLabel {
    return Intl.message(
      'All sensors',
      name: 'sensorFirstLabel',
      desc: '',
      args: [],
    );
  }

  /// `Deleted sensors`
  String get sensorSecondLabel {
    return Intl.message(
      'Deleted sensors',
      name: 'sensorSecondLabel',
      desc: '',
      args: [],
    );
  }

  /// `find sensor`
  String get sensorHint {
    return Intl.message('find sensor', name: 'sensorHint', desc: '', args: []);
  }

  /// `Last read `
  String get sensorTextLastRead {
    return Intl.message(
      'Last read ',
      name: 'sensorTextLastRead',
      desc: '',
      args: [],
    );
  }

  /// ` ago`
  String get sensorTextAgo {
    return Intl.message(' ago', name: 'sensorTextAgo', desc: '', args: []);
  }

  /// `restore`
  String get TitleRestore {
    return Intl.message('restore', name: 'TitleRestore', desc: '', args: []);
  }

  /// `sensor`
  String get sensorBody {
    return Intl.message('sensor', name: 'sensorBody', desc: '', args: []);
  }

  /// `Type`
  String get type {
    return Intl.message('Type', name: 'type', desc: '', args: []);
  }

  /// `Battery`
  String get battery {
    return Intl.message('Battery', name: 'battery', desc: '', args: []);
  }

  /// `Edit Location`
  String get editLocation {
    return Intl.message(
      'Edit Location',
      name: 'editLocation',
      desc: '',
      args: [],
    );
  }

  /// `Duration : `
  String get duration {
    return Intl.message('Duration : ', name: 'duration', desc: '', args: []);
  }

  /// `Shift : `
  String get shiftField {
    return Intl.message('Shift : ', name: 'shiftField', desc: '', args: []);
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Discription`
  String get discription {
    return Intl.message('Discription', name: 'discription', desc: '', args: []);
  }

  /// `Remove Location`
  String get RemoveLocationButton {
    return Intl.message(
      'Remove Location',
      name: 'RemoveLocationButton',
      desc: '',
      args: [],
    );
  }

  /// `Sensor details`
  String get sensorDetails {
    return Intl.message(
      'Sensor details',
      name: 'sensorDetails',
      desc: '',
      args: [],
    );
  }

  /// `Read more`
  String get ReadMoreButton {
    return Intl.message(
      'Read more',
      name: 'ReadMoreButton',
      desc: '',
      args: [],
    );
  }

  /// `Read less`
  String get ReadLessButton {
    return Intl.message(
      'Read less',
      name: 'ReadLessButton',
      desc: '',
      args: [],
    );
  }

  /// `edit`
  String get TitleEdit {
    return Intl.message('edit', name: 'TitleEdit', desc: '', args: []);
  }

  /// `remove location`
  String get TitleRemove {
    return Intl.message(
      'remove location',
      name: 'TitleRemove',
      desc: '',
      args: [],
    );
  }

  /// `Min`
  String get min {
    return Intl.message('Min', name: 'min', desc: '', args: []);
  }

  /// `Max`
  String get max {
    return Intl.message('Max', name: 'max', desc: '', args: []);
  }

  /// `add`
  String get TitleAdd {
    return Intl.message('add', name: 'TitleAdd', desc: '', args: []);
  }

  /// `limit`
  String get limitBody {
    return Intl.message('limit', name: 'limitBody', desc: '', args: []);
  }

  /// `Add`
  String get addButton {
    return Intl.message('Add', name: 'addButton', desc: '', args: []);
  }

  /// `delete`
  String get TitleDelete {
    return Intl.message('delete', name: 'TitleDelete', desc: '', args: []);
  }

  /// `There's no tasks`
  String get noTasks {
    return Intl.message(
      'There\'s no tasks',
      name: 'noTasks',
      desc: '',
      args: [],
    );
  }

  /// `Reload`
  String get reloadButton {
    return Intl.message('Reload', name: 'reloadButton', desc: '', args: []);
  }

  /// `All Tasks`
  String get allTasks {
    return Intl.message('All Tasks', name: 'allTasks', desc: '', args: []);
  }

  /// `Pending`
  String get pendingTask {
    return Intl.message('Pending', name: 'pendingTask', desc: '', args: []);
  }

  /// `In Progress`
  String get inProgressTask {
    return Intl.message(
      'In Progress',
      name: 'inProgressTask',
      desc: '',
      args: [],
    );
  }

  /// `Not Approval`
  String get notApproval {
    return Intl.message(
      'Not Approval',
      name: 'notApproval',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message('Completed', name: 'completed', desc: '', args: []);
  }

  /// `Rejected`
  String get rejected {
    return Intl.message('Rejected', name: 'rejected', desc: '', args: []);
  }

  /// `Not Resolved`
  String get notResolvedTask {
    return Intl.message(
      'Not Resolved',
      name: 'notResolvedTask',
      desc: '',
      args: [],
    );
  }

  /// `Overdue`
  String get overdueTask {
    return Intl.message('Overdue', name: 'overdueTask', desc: '', args: []);
  }

  /// `Total Shifts`
  String get totalShiftss {
    return Intl.message(
      'Total Shifts',
      name: 'totalShiftss',
      desc: '',
      args: [],
    );
  }

  /// `Deleted Shifts`
  String get deletedShifts {
    return Intl.message(
      'Deleted Shifts',
      name: 'deletedShifts',
      desc: '',
      args: [],
    );
  }

  /// `Find shift`
  String get findShift {
    return Intl.message('Find shift', name: 'findShift', desc: '', args: []);
  }

  /// `Shift`
  String get shiftBody {
    return Intl.message('Shift', name: 'shiftBody', desc: '', args: []);
  }

  /// `Create Shift`
  String get createShift {
    return Intl.message(
      'Create Shift',
      name: 'createShift',
      desc: '',
      args: [],
    );
  }

  /// `Shift Name`
  String get shiftName {
    return Intl.message('Shift Name', name: 'shiftName', desc: '', args: []);
  }

  /// `Enter Shift`
  String get enterShift {
    return Intl.message('Enter Shift', name: 'enterShift', desc: '', args: []);
  }

  /// `Shift Name is Required`
  String get shiftNameRequiredValidation {
    return Intl.message(
      'Shift Name is Required',
      name: 'shiftNameRequiredValidation',
      desc: '',
      args: [],
    );
  }

  /// `Shift name too long`
  String get shiftNameTooLongValidation {
    return Intl.message(
      'Shift name too long',
      name: 'shiftNameTooLongValidation',
      desc: '',
      args: [],
    );
  }

  /// `Shift name too short`
  String get shiftNameTooShortValidation {
    return Intl.message(
      'Shift name too short',
      name: 'shiftNameTooShortValidation',
      desc: '',
      args: [],
    );
  }

  /// `Start Date`
  String get startDate {
    return Intl.message('Start Date', name: 'startDate', desc: '', args: []);
  }

  /// `Start date is required`
  String get startDateRequiredValidation {
    return Intl.message(
      'Start date is required',
      name: 'startDateRequiredValidation',
      desc: '',
      args: [],
    );
  }

  /// `End Date`
  String get endDate {
    return Intl.message('End Date', name: 'endDate', desc: '', args: []);
  }

  /// `End date is required`
  String get endDateRequiredValidation {
    return Intl.message(
      'End date is required',
      name: 'endDateRequiredValidation',
      desc: '',
      args: [],
    );
  }

  /// `Start Time`
  String get startTime {
    return Intl.message('Start Time', name: 'startTime', desc: '', args: []);
  }

  /// `Start time is required`
  String get startTimeRequiredValidation {
    return Intl.message(
      'Start time is required',
      name: 'startTimeRequiredValidation',
      desc: '',
      args: [],
    );
  }

  /// `End Time`
  String get endTime {
    return Intl.message('End Time', name: 'endTime', desc: '', args: []);
  }

  /// `End Time is required`
  String get endTimeRequiredValidation {
    return Intl.message(
      'End Time is required',
      name: 'endTimeRequiredValidation',
      desc: '',
      args: [],
    );
  }

  /// `Select organization`
  String get selectOrganization {
    return Intl.message(
      'Select organization',
      name: 'selectOrganization',
      desc: '',
      args: [],
    );
  }

  /// `Select building`
  String get selectBuilding {
    return Intl.message(
      'Select building',
      name: 'selectBuilding',
      desc: '',
      args: [],
    );
  }

  /// `Select floor`
  String get selectFloor {
    return Intl.message(
      'Select floor',
      name: 'selectFloor',
      desc: '',
      args: [],
    );
  }

  /// `Select section`
  String get selectSection {
    return Intl.message(
      'Select section',
      name: 'selectSection',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get createButton {
    return Intl.message('Create', name: 'createButton', desc: '', args: []);
  }

  /// `Edit Shift`
  String get editShift {
    return Intl.message('Edit Shift', name: 'editShift', desc: '', args: []);
  }

  /// `Shift Details`
  String get shiftDetails {
    return Intl.message(
      'Shift Details',
      name: 'shiftDetails',
      desc: '',
      args: [],
    );
  }

  /// `Providers`
  String get providers {
    return Intl.message('Providers', name: 'providers', desc: '', args: []);
  }

  /// `Add Provider`
  String get addProvider {
    return Intl.message(
      'Add Provider',
      name: 'addProvider',
      desc: '',
      args: [],
    );
  }

  /// `Provider Name`
  String get providerName {
    return Intl.message(
      'Provider Name',
      name: 'providerName',
      desc: '',
      args: [],
    );
  }

  /// `Provider is required`
  String get providerRequiredValidation {
    return Intl.message(
      'Provider is required',
      name: 'providerRequiredValidation',
      desc: '',
      args: [],
    );
  }

  /// `Name is too long`
  String get providerNameTooLongValidation {
    return Intl.message(
      'Name is too long',
      name: 'providerNameTooLongValidation',
      desc: '',
      args: [],
    );
  }

  /// `Name is too short`
  String get providerNameTooShortValidation {
    return Intl.message(
      'Name is too short',
      name: 'providerNameTooShortValidation',
      desc: '',
      args: [],
    );
  }

  /// `Total providers`
  String get totalProviders {
    return Intl.message(
      'Total providers',
      name: 'totalProviders',
      desc: '',
      args: [],
    );
  }

  /// `Deleted providers`
  String get deletedProviders {
    return Intl.message(
      'Deleted providers',
      name: 'deletedProviders',
      desc: '',
      args: [],
    );
  }

  /// `Edit Provider`
  String get editProvider {
    return Intl.message(
      'Edit Provider',
      name: 'editProvider',
      desc: '',
      args: [],
    );
  }

  /// `Provider`
  String get providerBody {
    return Intl.message('Provider', name: 'providerBody', desc: '', args: []);
  }

  /// `Find provider`
  String get findProvider {
    return Intl.message(
      'Find provider',
      name: 'findProvider',
      desc: '',
      args: [],
    );
  }

  /// `Activities`
  String get activities {
    return Intl.message('Activities', name: 'activities', desc: '', args: []);
  }

  /// `My Activities`
  String get myActivities {
    return Intl.message(
      'My Activities',
      name: 'myActivities',
      desc: '',
      args: [],
    );
  }

  /// `My Team Activities`
  String get myTeamActivities {
    return Intl.message(
      'My Team Activities',
      name: 'myTeamActivities',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `Shift : `
  String get shift {
    return Intl.message('Shift : ', name: 'shift', desc: '', args: []);
  }

  /// `Reject`
  String get reject {
    return Intl.message('Reject', name: 'reject', desc: '', args: []);
  }

  /// `Approved`
  String get approved {
    return Intl.message('Approved', name: 'approved', desc: '', args: []);
  }

  /// `Leave details`
  String get leaveDetails {
    return Intl.message(
      'Leave details',
      name: 'leaveDetails',
      desc: '',
      args: [],
    );
  }

  /// `Reason`
  String get reason {
    return Intl.message('Reason', name: 'reason', desc: '', args: []);
  }

  /// `File`
  String get file {
    return Intl.message('File', name: 'file', desc: '', args: []);
  }

  /// `There's no file`
  String get noFile {
    return Intl.message('There\'s no file', name: 'noFile', desc: '', args: []);
  }

  /// `approve`
  String get Titleapprove {
    return Intl.message('approve', name: 'Titleapprove', desc: '', args: []);
  }

  /// `Approve`
  String get approveButton {
    return Intl.message('Approve', name: 'approveButton', desc: '', args: []);
  }

  /// `Leave`
  String get leaveBody {
    return Intl.message('Leave', name: 'leaveBody', desc: '', args: []);
  }

  /// `Reject`
  String get rejectButton {
    return Intl.message('Reject', name: 'rejectButton', desc: '', args: []);
  }

  /// `Reason for rejection`
  String get rejectionReason {
    return Intl.message(
      'Reason for rejection',
      name: 'rejectionReason',
      desc: '',
      args: [],
    );
  }

  /// `reason..`
  String get reasonHint {
    return Intl.message('reason..', name: 'reasonHint', desc: '', args: []);
  }

  /// `approve`
  String get approveBody {
    return Intl.message('approve', name: 'approveBody', desc: '', args: []);
  }

  /// `Create Leave`
  String get createLeave {
    return Intl.message(
      'Create Leave',
      name: 'createLeave',
      desc: '',
      args: [],
    );
  }

  /// `Employee Name`
  String get employeeName {
    return Intl.message(
      'Employee Name',
      name: 'employeeName',
      desc: '',
      args: [],
    );
  }

  /// `Select Employee`
  String get selectEmployee {
    return Intl.message(
      'Select Employee',
      name: 'selectEmployee',
      desc: '',
      args: [],
    );
  }

  /// `No employee available`
  String get noEmployeeValidation {
    return Intl.message(
      'No employee available',
      name: 'noEmployeeValidation',
      desc: '',
      args: [],
    );
  }

  /// `Employee name is required`
  String get employeeNameRequiredValidation {
    return Intl.message(
      'Employee name is required',
      name: 'employeeNameRequiredValidation',
      desc: '',
      args: [],
    );
  }

  /// `Sick`
  String get sick {
    return Intl.message('Sick', name: 'sick', desc: '', args: []);
  }

  /// `Annual`
  String get annual {
    return Intl.message('Annual', name: 'annual', desc: '', args: []);
  }

  /// `Ordinary`
  String get ordinary {
    return Intl.message('Ordinary', name: 'ordinary', desc: '', args: []);
  }

  /// `Select type`
  String get selectType {
    return Intl.message('Select type', name: 'selectType', desc: '', args: []);
  }

  /// `Type is required`
  String get typeRequired {
    return Intl.message(
      'Type is required',
      name: 'typeRequired',
      desc: '',
      args: [],
    );
  }

  /// `Write the reason for the leave`
  String get writeReason {
    return Intl.message(
      'Write the reason for the leave',
      name: 'writeReason',
      desc: '',
      args: [],
    );
  }

  /// `Reason is required`
  String get reasonRequiredValidation {
    return Intl.message(
      'Reason is required',
      name: 'reasonRequiredValidation',
      desc: '',
      args: [],
    );
  }

  /// `Upload file`
  String get uploadFile {
    return Intl.message('Upload file', name: 'uploadFile', desc: '', args: []);
  }

  /// `Edit Leave`
  String get editLeave {
    return Intl.message('Edit Leave', name: 'editLeave', desc: '', args: []);
  }

  /// `Category`
  String get category {
    return Intl.message('Category', name: 'category', desc: '', args: []);
  }

  /// `Material`
  String get material {
    return Intl.message('Material', name: 'material', desc: '', args: []);
  }

  /// `Transactions`
  String get transactions {
    return Intl.message(
      'Transactions',
      name: 'transactions',
      desc: '',
      args: [],
    );
  }

  /// `Stock`
  String get stock {
    return Intl.message('Stock', name: 'stock', desc: '', args: []);
  }

  /// `Transaction Management`
  String get transactionManagement {
    return Intl.message(
      'Transaction Management',
      name: 'transactionManagement',
      desc: '',
      args: [],
    );
  }

  /// `Inside`
  String get inside {
    return Intl.message('Inside', name: 'inside', desc: '', args: []);
  }

  /// `Outside`
  String get outside {
    return Intl.message('Outside', name: 'outside', desc: '', args: []);
  }

  /// `Find transaction`
  String get findTransaction {
    return Intl.message(
      'Find transaction',
      name: 'findTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Category: `
  String get categoryLabel {
    return Intl.message(
      'Category: ',
      name: 'categoryLabel',
      desc: '',
      args: [],
    );
  }

  /// `Quantity: `
  String get quantityLabel {
    return Intl.message(
      'Quantity: ',
      name: 'quantityLabel',
      desc: '',
      args: [],
    );
  }

  /// `Total Price: `
  String get totalPriceLabel {
    return Intl.message(
      'Total Price: ',
      name: 'totalPriceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Find activity`
  String get findActivity {
    return Intl.message(
      'Find activity',
      name: 'findActivity',
      desc: '',
      args: [],
    );
  }

  /// `Find history`
  String get findHistory {
    return Intl.message(
      'Find history',
      name: 'findHistory',
      desc: '',
      args: [],
    );
  }

  /// `Find leaves`
  String get findLeaves {
    return Intl.message('Find leaves', name: 'findLeaves', desc: '', args: []);
  }

  /// `Material details`
  String get materialDetails {
    return Intl.message(
      'Material details',
      name: 'materialDetails',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message('Quantity', name: 'quantity', desc: '', args: []);
  }

  /// `Minimum`
  String get minimum {
    return Intl.message('Minimum', name: 'minimum', desc: '', args: []);
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Transaction details`
  String get transactionDetails {
    return Intl.message(
      'Transaction details',
      name: 'transactionDetails',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get user {
    return Intl.message('User', name: 'user', desc: '', args: []);
  }

  /// `Total Quantity`
  String get totalQuantity {
    return Intl.message(
      'Total Quantity',
      name: 'totalQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Total Price`
  String get totalPrice {
    return Intl.message('Total Price', name: 'totalPrice', desc: '', args: []);
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Time`
  String get time {
    return Intl.message('Time', name: 'time', desc: '', args: []);
  }

  /// `Files uploaded`
  String get filesUploaded {
    return Intl.message(
      'Files uploaded',
      name: 'filesUploaded',
      desc: '',
      args: [],
    );
  }

  /// `Add material`
  String get addMaterial {
    return Intl.message(
      'Add material',
      name: 'addMaterial',
      desc: '',
      args: [],
    );
  }

  /// `Write quantity number`
  String get writeQuantity {
    return Intl.message(
      'Write quantity number',
      name: 'writeQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Quantity is required`
  String get quantityRequired {
    return Intl.message(
      'Quantity is required',
      name: 'quantityRequired',
      desc: '',
      args: [],
    );
  }

  /// `Quantity is too long`
  String get quantityTooLong {
    return Intl.message(
      'Quantity is too long',
      name: 'quantityTooLong',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  /// ` (unit)`
  String get unit {
    return Intl.message(' (unit)', name: 'unit', desc: '', args: []);
  }

  /// `Write price number`
  String get writePrice {
    return Intl.message(
      'Write price number',
      name: 'writePrice',
      desc: '',
      args: [],
    );
  }

  /// `Price is required`
  String get priceRequired {
    return Intl.message(
      'Price is required',
      name: 'priceRequired',
      desc: '',
      args: [],
    );
  }

  /// `Price is too long`
  String get priceTooLong {
    return Intl.message(
      'Price is too long',
      name: 'priceTooLong',
      desc: '',
      args: [],
    );
  }

  /// `Find material`
  String get findMaterial {
    return Intl.message(
      'Find material',
      name: 'findMaterial',
      desc: '',
      args: [],
    );
  }

  /// `material`
  String get materialBody {
    return Intl.message('material', name: 'materialBody', desc: '', args: []);
  }

  /// `Minimum: `
  String get minimumLabel {
    return Intl.message('Minimum: ', name: 'minimumLabel', desc: '', args: []);
  }

  /// `Material Management`
  String get materialManagement {
    return Intl.message(
      'Material Management',
      name: 'materialManagement',
      desc: '',
      args: [],
    );
  }

  /// `Total Materials`
  String get totalMaterials {
    return Intl.message(
      'Total Materials',
      name: 'totalMaterials',
      desc: '',
      args: [],
    );
  }

  /// `Deleted Materials`
  String get deletedMaterials {
    return Intl.message(
      'Deleted Materials',
      name: 'deletedMaterials',
      desc: '',
      args: [],
    );
  }

  /// `Reduce`
  String get reduceButton {
    return Intl.message('Reduce', name: 'reduceButton', desc: '', args: []);
  }

  /// `Reduce material`
  String get reduceMaterial {
    return Intl.message(
      'Reduce material',
      name: 'reduceMaterial',
      desc: '',
      args: [],
    );
  }

  /// `Edit Material`
  String get editMaterial {
    return Intl.message(
      'Edit Material',
      name: 'editMaterial',
      desc: '',
      args: [],
    );
  }

  /// `Material Name`
  String get materialName {
    return Intl.message(
      'Material Name',
      name: 'materialName',
      desc: '',
      args: [],
    );
  }

  /// `Material Name is Required`
  String get materialNameRequired {
    return Intl.message(
      'Material Name is Required',
      name: 'materialNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Material name too long`
  String get materialNameTooLong {
    return Intl.message(
      'Material name too long',
      name: 'materialNameTooLong',
      desc: '',
      args: [],
    );
  }

  /// `Material name too short`
  String get materialNameTooShort {
    return Intl.message(
      'Material name too short',
      name: 'materialNameTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Minimum is Required`
  String get minimumRequired {
    return Intl.message(
      'Minimum is Required',
      name: 'minimumRequired',
      desc: '',
      args: [],
    );
  }

  /// `Minimum is too long`
  String get minimumTooLong {
    return Intl.message(
      'Minimum is too long',
      name: 'minimumTooLong',
      desc: '',
      args: [],
    );
  }

  /// `Material description is Required`
  String get materialDescriptionRequired {
    return Intl.message(
      'Material description is Required',
      name: 'materialDescriptionRequired',
      desc: '',
      args: [],
    );
  }

  /// `Material description too short`
  String get materialDescriptionTooShort {
    return Intl.message(
      'Material description too short',
      name: 'materialDescriptionTooShort',
      desc: '',
      args: [],
    );
  }

  /// `description...`
  String get descriptionHint {
    return Intl.message(
      'description...',
      name: 'descriptionHint',
      desc: '',
      args: [],
    );
  }

  /// `Edit Category`
  String get editCategory {
    return Intl.message(
      'Edit Category',
      name: 'editCategory',
      desc: '',
      args: [],
    );
  }

  /// `Category Name`
  String get categoryName {
    return Intl.message(
      'Category Name',
      name: 'categoryName',
      desc: '',
      args: [],
    );
  }

  /// `Category Name is Required`
  String get categoryNameRequired {
    return Intl.message(
      'Category Name is Required',
      name: 'categoryNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Category name too long`
  String get categoryNameTooLong {
    return Intl.message(
      'Category name too long',
      name: 'categoryNameTooLong',
      desc: '',
      args: [],
    );
  }

  /// `Category name too short`
  String get categoryNameTooShort {
    return Intl.message(
      'Category name too short',
      name: 'categoryNameTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Unit`
  String get unitTitle {
    return Intl.message('Unit', name: 'unitTitle', desc: '', args: []);
  }

  /// `Ml`
  String get ml {
    return Intl.message('Ml', name: 'ml', desc: '', args: []);
  }

  /// `L`
  String get l {
    return Intl.message('L', name: 'l', desc: '', args: []);
  }

  /// `Kg`
  String get kg {
    return Intl.message('Kg', name: 'kg', desc: '', args: []);
  }

  /// `G`
  String get g {
    return Intl.message('G', name: 'g', desc: '', args: []);
  }

  /// `M`
  String get m {
    return Intl.message('M', name: 'm', desc: '', args: []);
  }

  /// `Cm`
  String get cm {
    return Intl.message('Cm', name: 'cm', desc: '', args: []);
  }

  /// `Pieces`
  String get pieces {
    return Intl.message('Pieces', name: 'pieces', desc: '', args: []);
  }

  /// `category`
  String get categoryBody {
    return Intl.message('category', name: 'categoryBody', desc: '', args: []);
  }

  /// `Parent Category`
  String get parentCategory {
    return Intl.message(
      'Parent Category',
      name: 'parentCategory',
      desc: '',
      args: [],
    );
  }

  /// `Find category`
  String get findCategory {
    return Intl.message(
      'Find category',
      name: 'findCategory',
      desc: '',
      args: [],
    );
  }

  /// `Unit: `
  String get unitLabel {
    return Intl.message('Unit: ', name: 'unitLabel', desc: '', args: []);
  }

  /// `Category Management`
  String get categoryManagement {
    return Intl.message(
      'Category Management',
      name: 'categoryManagement',
      desc: '',
      args: [],
    );
  }

  /// `Total Categories`
  String get totalCategories {
    return Intl.message(
      'Total Categories',
      name: 'totalCategories',
      desc: '',
      args: [],
    );
  }

  /// `Deleted Categories`
  String get deletedCategories {
    return Intl.message(
      'Deleted Categories',
      name: 'deletedCategories',
      desc: '',
      args: [],
    );
  }

  /// `Create Material`
  String get createMaterial {
    return Intl.message(
      'Create Material',
      name: 'createMaterial',
      desc: '',
      args: [],
    );
  }

  /// `Enter Material`
  String get enterMaterial {
    return Intl.message(
      'Enter Material',
      name: 'enterMaterial',
      desc: '',
      args: [],
    );
  }

  /// `Select category`
  String get selectCategory {
    return Intl.message(
      'Select category',
      name: 'selectCategory',
      desc: '',
      args: [],
    );
  }

  /// `Write minimum number`
  String get writeMinimum {
    return Intl.message(
      'Write minimum number',
      name: 'writeMinimum',
      desc: '',
      args: [],
    );
  }

  /// `Create Category`
  String get createCategory {
    return Intl.message(
      'Create Category',
      name: 'createCategory',
      desc: '',
      args: [],
    );
  }

  /// `Enter Category`
  String get enterCategory {
    return Intl.message(
      'Enter Category',
      name: 'enterCategory',
      desc: '',
      args: [],
    );
  }

  /// `Unit is Required`
  String get unitRequired {
    return Intl.message(
      'Unit is Required',
      name: 'unitRequired',
      desc: '',
      args: [],
    );
  }

  /// `Select unit`
  String get selectUnit {
    return Intl.message('Select unit', name: 'selectUnit', desc: '', args: []);
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `Materials`
  String get materials {
    return Intl.message('Materials', name: 'materials', desc: '', args: []);
  }

  /// `Work Location`
  String get workLocation {
    return Intl.message(
      'Work Location',
      name: 'workLocation',
      desc: '',
      args: [],
    );
  }

  /// `Add Area`
  String get addArea {
    return Intl.message('Add Area', name: 'addArea', desc: '', args: []);
  }

  /// `Select country`
  String get selectCountry {
    return Intl.message(
      'Select country',
      name: 'selectCountry',
      desc: '',
      args: [],
    );
  }

  /// `Area Name`
  String get areaName {
    return Intl.message('Area Name', name: 'areaName', desc: '', args: []);
  }

  /// `Area name is required`
  String get areaNameRequired {
    return Intl.message(
      'Area name is required',
      name: 'areaNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Area name too long`
  String get areaNameTooLong {
    return Intl.message(
      'Area name too long',
      name: 'areaNameTooLong',
      desc: '',
      args: [],
    );
  }

  /// `Area name too short`
  String get areaNameTooShort {
    return Intl.message(
      'Area name too short',
      name: 'areaNameTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Managers`
  String get managers {
    return Intl.message('Managers', name: 'managers', desc: '', args: []);
  }

  /// `No managers available`
  String get noManagers {
    return Intl.message(
      'No managers available',
      name: 'noManagers',
      desc: '',
      args: [],
    );
  }

  /// `Select managers`
  String get selectManagers {
    return Intl.message(
      'Select managers',
      name: 'selectManagers',
      desc: '',
      args: [],
    );
  }

  /// `Supervisors`
  String get supervisors {
    return Intl.message('Supervisors', name: 'supervisors', desc: '', args: []);
  }

  /// `No supervisors available`
  String get noSupervisors {
    return Intl.message(
      'No supervisors available',
      name: 'noSupervisors',
      desc: '',
      args: [],
    );
  }

  /// `Select supervisors`
  String get selectSupervisors {
    return Intl.message(
      'Select supervisors',
      name: 'selectSupervisors',
      desc: '',
      args: [],
    );
  }

  /// `Cleaners`
  String get cleaners {
    return Intl.message('Cleaners', name: 'cleaners', desc: '', args: []);
  }

  /// `No cleaners available`
  String get noCleaners {
    return Intl.message(
      'No cleaners available',
      name: 'noCleaners',
      desc: '',
      args: [],
    );
  }

  /// `Select cleaners`
  String get selectCleaners {
    return Intl.message(
      'Select cleaners',
      name: 'selectCleaners',
      desc: '',
      args: [],
    );
  }

  /// `No country`
  String get noCountry {
    return Intl.message('No country', name: 'noCountry', desc: '', args: []);
  }

  /// `Add City`
  String get addCity {
    return Intl.message('Add City', name: 'addCity', desc: '', args: []);
  }

  /// `City Name`
  String get cityName {
    return Intl.message('City Name', name: 'cityName', desc: '', args: []);
  }

  /// `City name is required`
  String get cityNameRequired {
    return Intl.message(
      'City name is required',
      name: 'cityNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `City name too long`
  String get cityNameTooLong {
    return Intl.message(
      'City name too long',
      name: 'cityNameTooLong',
      desc: '',
      args: [],
    );
  }

  /// `City name too short`
  String get cityNameTooShort {
    return Intl.message(
      'City name too short',
      name: 'cityNameTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Select area`
  String get selectArea {
    return Intl.message('Select area', name: 'selectArea', desc: '', args: []);
  }

  /// `Select city`
  String get selectCity {
    return Intl.message('Select city', name: 'selectCity', desc: '', args: []);
  }

  /// `Organization Name`
  String get organizationName {
    return Intl.message(
      'Organization Name',
      name: 'organizationName',
      desc: '',
      args: [],
    );
  }

  /// `Organization name is required`
  String get organizationNameRequired {
    return Intl.message(
      'Organization name is required',
      name: 'organizationNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Organization name too long`
  String get organizationNameTooLong {
    return Intl.message(
      'Organization name too long',
      name: 'organizationNameTooLong',
      desc: '',
      args: [],
    );
  }

  /// `Organization name too short`
  String get organizationNameTooShort {
    return Intl.message(
      'Organization name too short',
      name: 'organizationNameTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Add Organization`
  String get addOrganization {
    return Intl.message(
      'Add Organization',
      name: 'addOrganization',
      desc: '',
      args: [],
    );
  }

  /// `Add Building`
  String get addBuilding {
    return Intl.message(
      'Add Building',
      name: 'addBuilding',
      desc: '',
      args: [],
    );
  }

  /// `Select organizations`
  String get selectOrganizations {
    return Intl.message(
      'Select organizations',
      name: 'selectOrganizations',
      desc: '',
      args: [],
    );
  }

  /// `Building Name`
  String get buildingName {
    return Intl.message(
      'Building Name',
      name: 'buildingName',
      desc: '',
      args: [],
    );
  }

  /// `Building name is required`
  String get buildingNameRequired {
    return Intl.message(
      'Building name is required',
      name: 'buildingNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Building name too long`
  String get buildingNameTooLong {
    return Intl.message(
      'Building name too long',
      name: 'buildingNameTooLong',
      desc: '',
      args: [],
    );
  }

  /// `Building name too short`
  String get buildingNameTooShort {
    return Intl.message(
      'Building name too short',
      name: 'buildingNameTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Building Number`
  String get buildingNumber {
    return Intl.message(
      'Building Number',
      name: 'buildingNumber',
      desc: '',
      args: [],
    );
  }

  /// `Building number is required`
  String get buildingNumberRequired {
    return Intl.message(
      'Building number is required',
      name: 'buildingNumberRequired',
      desc: '',
      args: [],
    );
  }

  /// `Building number too long`
  String get buildingNumberTooLong {
    return Intl.message(
      'Building number too long',
      name: 'buildingNumberTooLong',
      desc: '',
      args: [],
    );
  }

  /// `Building Description`
  String get buildingDescription {
    return Intl.message(
      'Building Description',
      name: 'buildingDescription',
      desc: '',
      args: [],
    );
  }

  /// `Description is required`
  String get descriptionRequired {
    return Intl.message(
      'Description is required',
      name: 'descriptionRequired',
      desc: '',
      args: [],
    );
  }

  /// `Description too short`
  String get descriptionTooShort {
    return Intl.message(
      'Description too short',
      name: 'descriptionTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Add Floor`
  String get addFloor {
    return Intl.message('Add Floor', name: 'addFloor', desc: '', args: []);
  }

  /// `Floor Name`
  String get floorName {
    return Intl.message('Floor Name', name: 'floorName', desc: '', args: []);
  }

  /// `Floor name is required`
  String get floorNameRequired {
    return Intl.message(
      'Floor name is required',
      name: 'floorNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Floor name too long`
  String get floorNameTooLong {
    return Intl.message(
      'Floor name too long',
      name: 'floorNameTooLong',
      desc: '',
      args: [],
    );
  }

  /// `Floor name too short`
  String get floorNameTooShort {
    return Intl.message(
      'Floor name too short',
      name: 'floorNameTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Floor Number`
  String get floorNumber {
    return Intl.message(
      'Floor Number',
      name: 'floorNumber',
      desc: '',
      args: [],
    );
  }

  /// `Floor number is required`
  String get floorNumberRequired {
    return Intl.message(
      'Floor number is required',
      name: 'floorNumberRequired',
      desc: '',
      args: [],
    );
  }

  /// `Floor number too long`
  String get floorNumberTooLong {
    return Intl.message(
      'Floor number too long',
      name: 'floorNumberTooLong',
      desc: '',
      args: [],
    );
  }

  /// `Floor Description`
  String get floorDescription {
    return Intl.message(
      'Floor Description',
      name: 'floorDescription',
      desc: '',
      args: [],
    );
  }

  /// `Add Section`
  String get addSection {
    return Intl.message('Add Section', name: 'addSection', desc: '', args: []);
  }

  /// `Section Name`
  String get sectionName {
    return Intl.message(
      'Section Name',
      name: 'sectionName',
      desc: '',
      args: [],
    );
  }

  /// `Section name is required`
  String get sectionNameRequired {
    return Intl.message(
      'Section name is required',
      name: 'sectionNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Section name too long`
  String get sectionNameTooLong {
    return Intl.message(
      'Section name too long',
      name: 'sectionNameTooLong',
      desc: '',
      args: [],
    );
  }

  /// `Section name too short`
  String get sectionNameTooShort {
    return Intl.message(
      'Section name too short',
      name: 'sectionNameTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Section Number`
  String get sectionNumber {
    return Intl.message(
      'Section Number',
      name: 'sectionNumber',
      desc: '',
      args: [],
    );
  }

  /// `Section number is required`
  String get sectionNumberRequired {
    return Intl.message(
      'Section number is required',
      name: 'sectionNumberRequired',
      desc: '',
      args: [],
    );
  }

  /// `Section number too long`
  String get sectionNumberTooLong {
    return Intl.message(
      'Section number too long',
      name: 'sectionNumberTooLong',
      desc: '',
      args: [],
    );
  }

  /// `Section Description`
  String get sectionDescription {
    return Intl.message(
      'Section Description',
      name: 'sectionDescription',
      desc: '',
      args: [],
    );
  }

  /// `Add Point`
  String get addPoint {
    return Intl.message('Add Point', name: 'addPoint', desc: '', args: []);
  }

  /// `Point Name`
  String get pointName {
    return Intl.message('Point Name', name: 'pointName', desc: '', args: []);
  }

  /// `Point name is required`
  String get pointNameRequired {
    return Intl.message(
      'Point name is required',
      name: 'pointNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Point name too long`
  String get pointNameTooLong {
    return Intl.message(
      'Point name too long',
      name: 'pointNameTooLong',
      desc: '',
      args: [],
    );
  }

  /// `Point name too short`
  String get pointNameTooShort {
    return Intl.message(
      'Point name too short',
      name: 'pointNameTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Point Number`
  String get pointNumber {
    return Intl.message(
      'Point Number',
      name: 'pointNumber',
      desc: '',
      args: [],
    );
  }

  /// `Point number is required`
  String get pointNumberRequired {
    return Intl.message(
      'Point number is required',
      name: 'pointNumberRequired',
      desc: '',
      args: [],
    );
  }

  /// `Point number too long`
  String get pointNumberTooLong {
    return Intl.message(
      'Point number too long',
      name: 'pointNumberTooLong',
      desc: '',
      args: [],
    );
  }

  /// `Point Description`
  String get pointDescription {
    return Intl.message(
      'Point Description',
      name: 'pointDescription',
      desc: '',
      args: [],
    );
  }

  /// `Sensor`
  String get sensor {
    return Intl.message('Sensor', name: 'sensor', desc: '', args: []);
  }

  /// `Select sensor`
  String get selectSensor {
    return Intl.message(
      'Select sensor',
      name: 'selectSensor',
      desc: '',
      args: [],
    );
  }

  /// `Is Countable:`
  String get isCountable {
    return Intl.message(
      'Is Countable:',
      name: 'isCountable',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `Capacity`
  String get capacity {
    return Intl.message('Capacity', name: 'capacity', desc: '', args: []);
  }

  /// `Write capacity`
  String get writeCapacity {
    return Intl.message(
      'Write capacity',
      name: 'writeCapacity',
      desc: '',
      args: [],
    );
  }

  /// `Capacity is required`
  String get capacityRequired {
    return Intl.message(
      'Capacity is required',
      name: 'capacityRequired',
      desc: '',
      args: [],
    );
  }

  /// `Capacity too long`
  String get capacityTooLong {
    return Intl.message(
      'Capacity too long',
      name: 'capacityTooLong',
      desc: '',
      args: [],
    );
  }

  /// `No shifts available`
  String get noShiftsAvailable {
    return Intl.message(
      'No shifts available',
      name: 'noShiftsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Select shift`
  String get selectShift {
    return Intl.message(
      'Select shift',
      name: 'selectShift',
      desc: '',
      args: [],
    );
  }

  /// `Edit Area`
  String get EditArea {
    return Intl.message('Edit Area', name: 'EditArea', desc: '', args: []);
  }

  /// `area`
  String get areaBody {
    return Intl.message('area', name: 'areaBody', desc: '', args: []);
  }

  /// `Edit Building`
  String get EditBuilding {
    return Intl.message(
      'Edit Building',
      name: 'EditBuilding',
      desc: '',
      args: [],
    );
  }

  /// `building`
  String get buildingBody {
    return Intl.message('building', name: 'buildingBody', desc: '', args: []);
  }

  /// `Edit City`
  String get EditCity {
    return Intl.message('Edit City', name: 'EditCity', desc: '', args: []);
  }

  /// `city`
  String get cityBody {
    return Intl.message('city', name: 'cityBody', desc: '', args: []);
  }

  /// `Edit Floor`
  String get EditFloor {
    return Intl.message('Edit Floor', name: 'EditFloor', desc: '', args: []);
  }

  /// `floor`
  String get floorBody {
    return Intl.message('floor', name: 'floorBody', desc: '', args: []);
  }

  /// `Edit Organization`
  String get EditOrganization {
    return Intl.message(
      'Edit Organization',
      name: 'EditOrganization',
      desc: '',
      args: [],
    );
  }

  /// `organization`
  String get organizationBody {
    return Intl.message(
      'organization',
      name: 'organizationBody',
      desc: '',
      args: [],
    );
  }

  /// `Edit Point`
  String get EditPoint {
    return Intl.message('Edit Point', name: 'EditPoint', desc: '', args: []);
  }

  /// `point`
  String get pointBody {
    return Intl.message('point', name: 'pointBody', desc: '', args: []);
  }

  /// `Edit Section`
  String get EditSection {
    return Intl.message(
      'Edit Section',
      name: 'EditSection',
      desc: '',
      args: [],
    );
  }

  /// `section`
  String get sectionBody {
    return Intl.message('section', name: 'sectionBody', desc: '', args: []);
  }

  /// `Area details`
  String get area_details {
    return Intl.message(
      'Area details',
      name: 'area_details',
      desc: '',
      args: [],
    );
  }

  /// `City details`
  String get city_details {
    return Intl.message(
      'City details',
      name: 'city_details',
      desc: '',
      args: [],
    );
  }

  /// `Organization details`
  String get organization_details {
    return Intl.message(
      'Organization details',
      name: 'organization_details',
      desc: '',
      args: [],
    );
  }

  /// `Building details`
  String get building_details {
    return Intl.message(
      'Building details',
      name: 'building_details',
      desc: '',
      args: [],
    );
  }

  /// `Floor details`
  String get floor_details {
    return Intl.message(
      'Floor details',
      name: 'floor_details',
      desc: '',
      args: [],
    );
  }

  /// `Section details`
  String get section_details {
    return Intl.message(
      'Section details',
      name: 'section_details',
      desc: '',
      args: [],
    );
  }

  /// `Point details`
  String get point_details {
    return Intl.message(
      'Point details',
      name: 'point_details',
      desc: '',
      args: [],
    );
  }

  /// `Shifts`
  String get shifts {
    return Intl.message('Shifts', name: 'shifts', desc: '', args: []);
  }

  /// `Country`
  String get country {
    return Intl.message('Country', name: 'country', desc: '', args: []);
  }

  /// `Device`
  String get device {
    return Intl.message('Device', name: 'device', desc: '', args: []);
  }

  /// `Areas`
  String get areas {
    return Intl.message('Areas', name: 'areas', desc: '', args: []);
  }

  /// `Cities`
  String get cities {
    return Intl.message('Cities', name: 'cities', desc: '', args: []);
  }

  /// `Organizations`
  String get organizations {
    return Intl.message(
      'Organizations',
      name: 'organizations',
      desc: '',
      args: [],
    );
  }

  /// `Buildings`
  String get buildings {
    return Intl.message('Buildings', name: 'buildings', desc: '', args: []);
  }

  /// `Floors`
  String get floors {
    return Intl.message('Floors', name: 'floors', desc: '', args: []);
  }

  /// `Sections`
  String get sections {
    return Intl.message('Sections', name: 'sections', desc: '', args: []);
  }

  /// `Points`
  String get points {
    return Intl.message('Points', name: 'points', desc: '', args: []);
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Deleted`
  String get deleted {
    return Intl.message('Deleted', name: 'deleted', desc: '', args: []);
  }

  /// `Find name of work location`
  String get find_name_of_work_location {
    return Intl.message(
      'Find name of work location',
      name: 'find_name_of_work_location',
      desc: '',
      args: [],
    );
  }

  /// `Create Task`
  String get create_task {
    return Intl.message('Create Task', name: 'create_task', desc: '', args: []);
  }

  /// `Select Priority`
  String get select_priority {
    return Intl.message(
      'Select Priority',
      name: 'select_priority',
      desc: '',
      args: [],
    );
  }

  /// `Priority is Required`
  String get priority_required {
    return Intl.message(
      'Priority is Required',
      name: 'priority_required',
      desc: '',
      args: [],
    );
  }

  /// `Parent task`
  String get parent_task {
    return Intl.message('Parent task', name: 'parent_task', desc: '', args: []);
  }

  /// `Select parent task`
  String get select_parent_task {
    return Intl.message(
      'Select parent task',
      name: 'select_parent_task',
      desc: '',
      args: [],
    );
  }

  /// `Task Title`
  String get task_title {
    return Intl.message('Task Title', name: 'task_title', desc: '', args: []);
  }

  /// `Enter task title`
  String get enter_task_title {
    return Intl.message(
      'Enter task title',
      name: 'enter_task_title',
      desc: '',
      args: [],
    );
  }

  /// `Task title is Required`
  String get task_title_required {
    return Intl.message(
      'Task title is Required',
      name: 'task_title_required',
      desc: '',
      args: [],
    );
  }

  /// `Task title too long`
  String get task_title_too_long {
    return Intl.message(
      'Task title too long',
      name: 'task_title_too_long',
      desc: '',
      args: [],
    );
  }

  /// `Task title too short`
  String get task_title_too_short {
    return Intl.message(
      'Task title too short',
      name: 'task_title_too_short',
      desc: '',
      args: [],
    );
  }

  /// `Select point`
  String get select_point {
    return Intl.message(
      'Select point',
      name: 'select_point',
      desc: '',
      args: [],
    );
  }

  /// `Currently reading`
  String get currently_reading {
    return Intl.message(
      'Currently reading',
      name: 'currently_reading',
      desc: '',
      args: [],
    );
  }

  /// `Write Currently reading`
  String get write_currently_reading {
    return Intl.message(
      'Write Currently reading',
      name: 'write_currently_reading',
      desc: '',
      args: [],
    );
  }

  /// `Currently reading is Required`
  String get currently_reading_required {
    return Intl.message(
      'Currently reading is Required',
      name: 'currently_reading_required',
      desc: '',
      args: [],
    );
  }

  /// `Currently reading too long`
  String get currently_reading_too_long {
    return Intl.message(
      'Currently reading too long',
      name: 'currently_reading_too_long',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message('Status', name: 'status', desc: '', args: []);
  }

  /// `Status is Required`
  String get status_required {
    return Intl.message(
      'Status is Required',
      name: 'status_required',
      desc: '',
      args: [],
    );
  }

  /// `Employee`
  String get employee {
    return Intl.message('Employee', name: 'employee', desc: '', args: []);
  }

  /// `Take photo`
  String get take_photo {
    return Intl.message('Take photo', name: 'take_photo', desc: '', args: []);
  }

  /// `Edit Task`
  String get edit_task {
    return Intl.message('Edit Task', name: 'edit_task', desc: '', args: []);
  }

  /// `Files`
  String get files {
    return Intl.message('Files', name: 'files', desc: '', args: []);
  }

  /// `task`
  String get taskbody {
    return Intl.message('task', name: 'taskbody', desc: '', args: []);
  }

  /// `My tasks`
  String get my_tasks {
    return Intl.message('My tasks', name: 'my_tasks', desc: '', args: []);
  }

  /// `Received tasks`
  String get received_tasks {
    return Intl.message(
      'Received tasks',
      name: 'received_tasks',
      desc: '',
      args: [],
    );
  }

  /// `My team tasks`
  String get my_team_tasks {
    return Intl.message(
      'My team tasks',
      name: 'my_team_tasks',
      desc: '',
      args: [],
    );
  }

  /// `Find task`
  String get find_task {
    return Intl.message('Find task', name: 'find_task', desc: '', args: []);
  }

  /// `IP is Required`
  String get ip_required {
    return Intl.message(
      'IP is Required',
      name: 'ip_required',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid IP (e.g. 192.168.1.1)`
  String get ip_invalid_format {
    return Intl.message(
      'Enter a valid IP (e.g. 192.168.1.1)',
      name: 'ip_invalid_format',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your network IP`
  String get enter_network_ip {
    return Intl.message(
      'Please enter your network IP',
      name: 'enter_network_ip',
      desc: '',
      args: [],
    );
  }

  /// `Network IP`
  String get network_ip {
    return Intl.message('Network IP', name: 'network_ip', desc: '', args: []);
  }

  /// `Check IP`
  String get check_ip {
    return Intl.message('Check IP', name: 'check_ip', desc: '', args: []);
  }

  /// `Select Parent Category`
  String get select_parent_category {
    return Intl.message(
      'Select Parent Category',
      name: 'select_parent_category',
      desc: '',
      args: [],
    );
  }

  /// `Transaction type`
  String get transaction_type {
    return Intl.message(
      'Transaction type',
      name: 'transaction_type',
      desc: '',
      args: [],
    );
  }

  /// `Activity status`
  String get activity_status {
    return Intl.message(
      'Activity status',
      name: 'activity_status',
      desc: '',
      args: [],
    );
  }

  /// `Select status`
  String get select_status {
    return Intl.message(
      'Select status',
      name: 'select_status',
      desc: '',
      args: [],
    );
  }

  /// `Is Assign`
  String get is_assign {
    return Intl.message('Is Assign', name: 'is_assign', desc: '', args: []);
  }

  /// `Select`
  String get select {
    return Intl.message('Select', name: 'select', desc: '', args: []);
  }

  /// `Created By`
  String get created_by {
    return Intl.message('Created By', name: 'created_by', desc: '', args: []);
  }

  /// `Select user`
  String get select_user {
    return Intl.message('Select user', name: 'select_user', desc: '', args: []);
  }

  /// `No user`
  String get no_user {
    return Intl.message('No user', name: 'no_user', desc: '', args: []);
  }

  /// `Assign to`
  String get assign_to {
    return Intl.message('Assign to', name: 'assign_to', desc: '', args: []);
  }

  /// `In Progress`
  String get in_progress {
    return Intl.message('In Progress', name: 'in_progress', desc: '', args: []);
  }

  /// `Not Approval`
  String get not_approval {
    return Intl.message(
      'Not Approval',
      name: 'not_approval',
      desc: '',
      args: [],
    );
  }

  /// `Not Resolved`
  String get not_resolved {
    return Intl.message(
      'Not Resolved',
      name: 'not_resolved',
      desc: '',
      args: [],
    );
  }

  /// `Priority`
  String get priority {
    return Intl.message('Priority', name: 'priority', desc: '', args: []);
  }

  /// `Select Role`
  String get select_role {
    return Intl.message('Select Role', name: 'select_role', desc: '', args: []);
  }

  /// `Select shift`
  String get select_shift {
    return Intl.message(
      'Select shift',
      name: 'select_shift',
      desc: '',
      args: [],
    );
  }

  /// `Select Users`
  String get select_users {
    return Intl.message(
      'Select Users',
      name: 'select_users',
      desc: '',
      args: [],
    );
  }

  /// `Module`
  String get module {
    return Intl.message('Module', name: 'module', desc: '', args: []);
  }

  /// `Select module`
  String get select_module {
    return Intl.message(
      'Select module',
      name: 'select_module',
      desc: '',
      args: [],
    );
  }

  /// `Action`
  String get action {
    return Intl.message('Action', name: 'action', desc: '', args: []);
  }

  /// `Select action`
  String get select_action {
    return Intl.message(
      'Select action',
      name: 'select_action',
      desc: '',
      args: [],
    );
  }

  /// `Provider`
  String get provider {
    return Intl.message('Provider', name: 'provider', desc: '', args: []);
  }

  /// `Select Provider`
  String get select_provider {
    return Intl.message(
      'Select Provider',
      name: 'select_provider',
      desc: '',
      args: [],
    );
  }

  /// `Select Sensor`
  String get select_sensor {
    return Intl.message(
      'Select Sensor',
      name: 'select_sensor',
      desc: '',
      args: [],
    );
  }

  /// `Is Active`
  String get is_active {
    return Intl.message('Is Active', name: 'is_active', desc: '', args: []);
  }

  /// `Male`
  String get male {
    return Intl.message('Male', name: 'male', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `Select Nationality`
  String get select_nationality {
    return Intl.message(
      'Select Nationality',
      name: 'select_nationality',
      desc: '',
      args: [],
    );
  }

  /// `Select Work location`
  String get select_work_location {
    return Intl.message(
      'Select Work location',
      name: 'select_work_location',
      desc: '',
      args: [],
    );
  }

  /// `Chart Type`
  String get chart_type {
    return Intl.message('Chart Type', name: 'chart_type', desc: '', args: []);
  }

  /// `Line`
  String get line {
    return Intl.message('Line', name: 'line', desc: '', args: []);
  }

  /// `Bar`
  String get bar {
    return Intl.message('Bar', name: 'bar', desc: '', args: []);
  }

  /// `Pie`
  String get pie {
    return Intl.message('Pie', name: 'pie', desc: '', args: []);
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Please, setup a new password for your account`
  String get change_password_description {
    return Intl.message(
      'Please, setup a new password for your account',
      name: 'change_password_description',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get old_password {
    return Intl.message(
      'Old Password',
      name: 'old_password',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get new_password {
    return Intl.message(
      'New Password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePasswordbutton {
    return Intl.message(
      'Change Password',
      name: 'changePasswordbutton',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get TitleChangePassword {
    return Intl.message(
      'Change Password',
      name: 'TitleChangePassword',
      desc: '',
      args: [],
    );
  }

  /// `profile`
  String get profileBody {
    return Intl.message('profile', name: 'profileBody', desc: '', args: []);
  }

  /// `Task details`
  String get task_details {
    return Intl.message(
      'Task details',
      name: 'task_details',
      desc: '',
      args: [],
    );
  }

  /// `Total Time`
  String get total_time {
    return Intl.message('Total Time', name: 'total_time', desc: '', args: []);
  }

  /// `The task isn't start yet.`
  String get task_not_started {
    return Intl.message(
      'The task isn\'t start yet.',
      name: 'task_not_started',
      desc: '',
      args: [],
    );
  }

  /// `The task isn't complete yet.`
  String get task_not_completed {
    return Intl.message(
      'The task isn\'t complete yet.',
      name: 'task_not_completed',
      desc: '',
      args: [],
    );
  }

  /// `Start:`
  String get start_time {
    return Intl.message('Start:', name: 'start_time', desc: '', args: []);
  }

  /// `End:`
  String get end_time {
    return Intl.message('End:', name: 'end_time', desc: '', args: []);
  }

  /// `Device name`
  String get device_name {
    return Intl.message('Device name', name: 'device_name', desc: '', args: []);
  }

  /// `After Reading`
  String get after_reading {
    return Intl.message(
      'After Reading',
      name: 'after_reading',
      desc: '',
      args: [],
    );
  }

  /// `Task Team`
  String get task_team {
    return Intl.message('Task Team', name: 'task_team', desc: '', args: []);
  }

  /// `No employee added`
  String get no_employee_added {
    return Intl.message(
      'No employee added',
      name: 'no_employee_added',
      desc: '',
      args: [],
    );
  }

  /// `No file uploaded`
  String get no_file_uploaded {
    return Intl.message(
      'No file uploaded',
      name: 'no_file_uploaded',
      desc: '',
      args: [],
    );
  }

  /// `files uploaded`
  String get files_uploaded {
    return Intl.message(
      'files uploaded',
      name: 'files_uploaded',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comments {
    return Intl.message('Comments', name: 'comments', desc: '', args: []);
  }

  /// `There's no comments`
  String get no_comments {
    return Intl.message(
      'There\'s no comments',
      name: 'no_comments',
      desc: '',
      args: [],
    );
  }

  /// `Add Comment`
  String get add_comment {
    return Intl.message('Add Comment', name: 'add_comment', desc: '', args: []);
  }

  /// `write your comment`
  String get write_comment {
    return Intl.message(
      'write your comment',
      name: 'write_comment',
      desc: '',
      args: [],
    );
  }

  /// `Comment or Image is required`
  String get comment_or_image_required {
    return Intl.message(
      'Comment or Image is required',
      name: 'comment_or_image_required',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get startButton {
    return Intl.message('Start', name: 'startButton', desc: '', args: []);
  }

  /// `NotResolved`
  String get notresolvedButton {
    return Intl.message(
      'NotResolved',
      name: 'notresolvedButton',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get completeButton {
    return Intl.message('Complete', name: 'completeButton', desc: '', args: []);
  }

  /// `Duration`
  String get duration2 {
    return Intl.message('Duration', name: 'duration2', desc: '', args: []);
  }

  /// `Done`
  String get doneButton2 {
    return Intl.message('Done', name: 'doneButton2', desc: '', args: []);
  }

  /// `True`
  String get trueSelect {
    return Intl.message('True', name: 'trueSelect', desc: '', args: []);
  }

  /// `False`
  String get falseSelect {
    return Intl.message('False', name: 'falseSelect', desc: '', args: []);
  }

  /// `In`
  String get inSelect {
    return Intl.message('In', name: 'inSelect', desc: '', args: []);
  }

  /// `Out`
  String get outSelect {
    return Intl.message('Out', name: 'outSelect', desc: '', args: []);
  }

  /// `Assign`
  String get assignButton {
    return Intl.message('Assign', name: 'assignButton', desc: '', args: []);
  }

  /// `There's no activities`
  String get noActivities {
    return Intl.message(
      'There\'s no activities',
      name: 'noActivities',
      desc: '',
      args: [],
    );
  }

  /// `Login to access your Clean Tech\naccount`
  String get loginDescription {
    return Intl.message(
      'Login to access your Clean Tech\naccount',
      name: 'loginDescription',
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
