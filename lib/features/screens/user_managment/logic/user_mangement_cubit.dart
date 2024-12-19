import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/features/screens/user_managment/logic/user_mangement_state.dart';

class UserManagementCubit extends Cubit<UserManagementState> {
  UserManagementCubit() : super(UserManagementInitialState());

  static UserManagementCubit get(context) => BlocProvider.of(context);
  TextEditingController searchController = TextEditingController();

  final formKey = GlobalKey<FormState>();
}
