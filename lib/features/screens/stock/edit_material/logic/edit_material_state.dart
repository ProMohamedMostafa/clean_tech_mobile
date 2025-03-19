
import 'package:smart_cleaning_application/features/screens/stock/category_management/data/model/category_management_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/edit_material/data/model/edit_material_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/view_material/data/model/material_details_model.dart';

abstract class EditMaterialState {}

class EditMaterialInitialState extends EditMaterialState {}

class EditMaterialLoadingState extends EditMaterialState {}

class EditMaterialSuccessState extends EditMaterialState {
  final EditMaterialModel editMaterialModel;

  EditMaterialSuccessState(this.editMaterialModel);
}

class EditMaterialErrorState extends EditMaterialState {
  final String error;
  EditMaterialErrorState(this.error);
}
//***************** */

class MaterialDetailsLoadingState extends EditMaterialState {}

class MaterialDetailsSuccessState extends EditMaterialState {
  final MaterialDetailsModel materialDetailsModelModel;

  MaterialDetailsSuccessState(this.materialDetailsModelModel);
}

class MaterialDetailsErrorState extends EditMaterialState {
  final String error;
  MaterialDetailsErrorState(this.error);
}
//**************** */

class CategoryManagementLoadingState extends EditMaterialState {}

class CategoryManagementSuccessState extends EditMaterialState {
  final CategoryManagementModel categoryManagementModel;

  CategoryManagementSuccessState(this.categoryManagementModel);
}

class CategoryManagementErrorState extends EditMaterialState {
  final String error;
  CategoryManagementErrorState(this.error);
}