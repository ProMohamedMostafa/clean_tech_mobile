import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/features/screens/organizations/logic/organizations_states.dart';

class OrganizationsCubit extends Cubit<OrganizationsState> {
  OrganizationsCubit() : super(OrganizationsInitialState());

  static OrganizationsCubit get(context) => BlocProvider.of(context);
  TextEditingController searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();
}
