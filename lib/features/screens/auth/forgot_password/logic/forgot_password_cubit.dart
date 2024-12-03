import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/features/screens/auth/forgot_password/logic/forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordStates> {
  ForgotPasswordCubit() : super(ForgotPasswordInitialState());
  static ForgotPasswordCubit get(context) => BlocProvider.of(context);
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
}
