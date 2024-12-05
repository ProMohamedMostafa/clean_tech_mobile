// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "createPass1":
            MessageLookupByLibrary.simpleMessage("At least 1 lowercase letter"),
        "createPass2":
            MessageLookupByLibrary.simpleMessage("At least 1 uppercase letter"),
        "createPass3": MessageLookupByLibrary.simpleMessage(
            "At least 1 special character"),
        "createPass4":
            MessageLookupByLibrary.simpleMessage("At least 1 number"),
        "createPass5":
            MessageLookupByLibrary.simpleMessage("At least 8 characters long"),
        "doneTitl1": MessageLookupByLibrary.simpleMessage("Password Changed!"),
        "doneTitl2": MessageLookupByLibrary.simpleMessage(
            "Your password has been changed successfully."),
        "donebutton": MessageLookupByLibrary.simpleMessage("Back to login"),
        "forgotPassButton":
            MessageLookupByLibrary.simpleMessage("Forgot Password?"),
        "forgotPassScreenTextField":
            MessageLookupByLibrary.simpleMessage("Email"),
        "forgotPassScreenTitle1":
            MessageLookupByLibrary.simpleMessage("Forgot your password?"),
        "forgotPassScreenTitle2": MessageLookupByLibrary.simpleMessage(
            "Don’t worry, happens to all of us. Enter your email below to recover your password"),
        "labelEmail": MessageLookupByLibrary.simpleMessage("Email or userName"),
        "labelPassword": MessageLookupByLibrary.simpleMessage("Password"),
        "loginButton": MessageLookupByLibrary.simpleMessage("Login"),
        "loginTitle1": MessageLookupByLibrary.simpleMessage("Login"),
        "loginTitle2": MessageLookupByLibrary.simpleMessage(
            "Login to access your Clean Tech  account"),
        "resendButton": MessageLookupByLibrary.simpleMessage(" Resend"),
        "setButton": MessageLookupByLibrary.simpleMessage("Reset Password"),
        "setPassTextField1":
            MessageLookupByLibrary.simpleMessage("Create New Password"),
        "setPassTextField2":
            MessageLookupByLibrary.simpleMessage("Re-enter Password"),
        "setPassTitle1":
            MessageLookupByLibrary.simpleMessage("Set a new password"),
        "setPassTitle2": MessageLookupByLibrary.simpleMessage(
            "Please set a new password for your account."),
        "submitButton": MessageLookupByLibrary.simpleMessage("Submit"),
        "termsConditions": MessageLookupByLibrary.simpleMessage(
            "Terms & Conditions and Conditions"),
        "validationEmail":
            MessageLookupByLibrary.simpleMessage("Invalid email address"),
        "validationEmailAndUser": MessageLookupByLibrary.simpleMessage(
            "Invalid email address or userName"),
        "validationPassword":
            MessageLookupByLibrary.simpleMessage("Invalid password"),
        "validationRepeatPassword":
            MessageLookupByLibrary.simpleMessage("Password not matched"),
        "validationVerify":
            MessageLookupByLibrary.simpleMessage("Invalid code"),
        "verifyAccountScreenTextField":
            MessageLookupByLibrary.simpleMessage("Enter Code"),
        "verifyAccountScreenTitle1":
            MessageLookupByLibrary.simpleMessage("Verify code"),
        "verifyAccountScreenTitle2": MessageLookupByLibrary.simpleMessage(
            "An authentication code has been sent to your email."),
        "verifyAccountScreenTitle3":
            MessageLookupByLibrary.simpleMessage("Didn’t receive a code?"),
        "verifyButton": MessageLookupByLibrary.simpleMessage("Verify")
      };
}
