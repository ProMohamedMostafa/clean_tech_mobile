import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/features/screens/organizations/logic/organizations_states.dart';

class OrganizationsCubit extends Cubit<OrganizationsState> {
  OrganizationsCubit() : super(OrganizationsInitialState());

  static OrganizationsCubit get(context) => BlocProvider.of(context);
  TextEditingController searchController = TextEditingController();

  TextEditingController countryController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController organizationsController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  
  

  final formKey = GlobalKey<FormState>();
}
