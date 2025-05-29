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

  /// `User Management`
  String get integ1 {
    return Intl.message('User Management', name: 'integ1', desc: '', args: []);
  }

  /// `Work Location`
  String get integ2 {
    return Intl.message('Work Location', name: 'integ2', desc: '', args: []);
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

  /// `Shift`
  String get integ4 {
    return Intl.message('Shift', name: 'integ4', desc: '', args: []);
  }

  /// `Task`
  String get integ5 {
    return Intl.message('Task', name: 'integ5', desc: '', args: []);
  }

  /// `Attendance`
  String get integ6 {
    return Intl.message('Attendance', name: 'integ6', desc: '', args: []);
  }

  /// `Stock`
  String get integ7 {
    return Intl.message('Stock', name: 'integ7', desc: '', args: []);
  }

  /// `Activity`
  String get integ8 {
    return Intl.message('Activity', name: 'integ8', desc: '', args: []);
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

  /// `Late`
  String get late {
    return Intl.message('Late', name: 'late', desc: '', args: []);
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

  /// `In Active`
  String get inactive {
    return Intl.message('In Active', name: 'inactive', desc: '', args: []);
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
