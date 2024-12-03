import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/features/screens/auth/set_password/logic/set_password_state.dart';

class SetPasswordCubit extends Cubit<SetPasswordStates> {
  SetPasswordCubit() : super(SetPasswordInitialState());
  static SetPasswordCubit get(context) => BlocProvider.of(context);
  TextEditingController passController = TextEditingController();
  TextEditingController repeatPassController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  IconData suffixIcon = Icons.visibility_outlined;
  bool ispassword = true;
  changeSuffixIconVisiability() {
    ispassword = !ispassword;
    suffixIcon =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeSuffixIconVisiabiltyState());
  }
}
