import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/features/screens/auth/verify_account/logic/verify_account_state.dart';

class VerifyAccountCubit extends Cubit<VerifyAccountState> {
  VerifyAccountCubit() : super(VerifyAccountInitialState());
  static VerifyAccountCubit get(context) => BlocProvider.of(context);
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
}
