import 'package:share_plus/share_plus.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/data/model/category_management_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/data/model/deleted_material_list_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/data/model/material_management_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/view_material/data/model/material_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/providers_model.dart';

abstract class MaterialManagementState {}

class MaterialManagementInitialState extends MaterialManagementState {}

class MaterialManagementLoadingState extends MaterialManagementState {}

class MaterialManagementSuccessState extends MaterialManagementState {
  final MaterialManagementModel materialManagementModel;

  MaterialManagementSuccessState(this.materialManagementModel);
}

class MaterialManagementErrorState extends MaterialManagementState {
  final String error;
  MaterialManagementErrorState(this.error);
}
//***************** */

class DeleteMaterialLoadingState extends MaterialManagementState {}

class DeleteMaterialSuccessState extends MaterialManagementState {
  final String message;

  DeleteMaterialSuccessState(this.message);
}

class DeleteMaterialErrorState extends MaterialManagementState {
  final String error;
  DeleteMaterialErrorState(this.error);
}
//***************** */

class DeletedMaterialLoadingState extends MaterialManagementState {}

class DeletedMaterialSuccessState extends MaterialManagementState {
  final DeletedMaterialListModel deletedMaterialListModel;

  DeletedMaterialSuccessState(this.deletedMaterialListModel);
}

class DeletedMaterialErrorState extends MaterialManagementState {
  final String error;
  DeletedMaterialErrorState(this.error);
}
//***************** */

class RestoreMaterialLoadingState extends MaterialManagementState {}

class RestoreMaterialSuccessState extends MaterialManagementState {
  final String message;

  RestoreMaterialSuccessState(this.message);
}

class RestoreMaterialErrorState extends MaterialManagementState {
  final String error;
  RestoreMaterialErrorState(this.error);
}
//***************** */

class ForceDeleteMaterialLoadingState extends MaterialManagementState {}

class ForceDeleteMaterialSuccessState extends MaterialManagementState {
  final String message;

  ForceDeleteMaterialSuccessState(this.message);
}

class ForceDeleteMaterialErrorState extends MaterialManagementState {
  final String error;
  ForceDeleteMaterialErrorState(this.error);
}
//***************** */

class MaterialDetailsLoadingState extends MaterialManagementState {}

class MaterialDetailsSuccessState extends MaterialManagementState {
  final MaterialDetailsModel materialDetailsModelModel;

  MaterialDetailsSuccessState(this.materialDetailsModelModel);
}

class MaterialDetailsErrorState extends MaterialManagementState {
  final String error;
  MaterialDetailsErrorState(this.error);
}
//**************************** */

class AllProvidersLoadingState extends MaterialManagementState {}

class AllProvidersSuccessState extends MaterialManagementState {
  final ProvidersModel providersModel;

  AllProvidersSuccessState(this.providersModel);
}

class AllProvidersErrorState extends MaterialManagementState {
  final String error;
  AllProvidersErrorState(this.error);
}
//***************************** */

class CategoriesLoadingState extends MaterialManagementState {}

class CategoriesSuccessState extends MaterialManagementState {
  final CategoryManagementModel catergoriesModel;

  CategoriesSuccessState(this.catergoriesModel);
}

class CategoriesErrorState extends MaterialManagementState {
  final String error;
  CategoriesErrorState(this.error);
}

//***************************** */

class AddMaterialLoadingState extends MaterialManagementState {}

class AddMaterialSuccessState extends MaterialManagementState {
  final String message;

  AddMaterialSuccessState(this.message);
}

class AddMaterialErrorState extends MaterialManagementState {
  final String error;
  AddMaterialErrorState(this.error);
}
//***************************** */

class ReduceMaterialLoadingState extends MaterialManagementState {}

class ReduceMaterialSuccessState extends MaterialManagementState {
  final String message;

  ReduceMaterialSuccessState(this.message);
}

class ReduceMaterialErrorState extends MaterialManagementState {
  final String error;
  ReduceMaterialErrorState(this.error);
}
//*************************** */
class ImageSelectedState extends MaterialManagementState {
  final XFile image;
  ImageSelectedState(this.image);
}
