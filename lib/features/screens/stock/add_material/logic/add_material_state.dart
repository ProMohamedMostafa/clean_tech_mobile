
import 'package:smart_cleaning_application/features/screens/stock/add_material/data/model/add_material_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/data/model/category_management_model.dart';

abstract class AddMaterialState {}

class AddMaterialInitialState extends AddMaterialState {}

class AddMaterialLoadingState extends AddMaterialState {}

class AddMaterialSuccessState extends AddMaterialState {
  final AddMaterialModel addMaterialModel;

  AddMaterialSuccessState(this.addMaterialModel);
}

class AddMaterialErrorState extends AddMaterialState {
  final String error;
  AddMaterialErrorState(this.error);
}
//***************************** */

class CategoriesLoadingState extends AddMaterialState {}

class CategoriesSuccessState extends AddMaterialState {
  final CategoryManagementModel catergoriesModel;

  CategoriesSuccessState(this.catergoriesModel);
}

class CategoriesErrorState extends AddMaterialState {
  final String error;
  CategoriesErrorState(this.error);
}
