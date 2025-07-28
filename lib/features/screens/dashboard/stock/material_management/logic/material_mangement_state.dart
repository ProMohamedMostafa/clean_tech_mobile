import 'package:share_plus/share_plus.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/provider/provider_management/data/models/providers_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/material_management/data/model/delete_material_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/material_management/data/model/deleted_material_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/material_management/data/model/material_management_model.dart';

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
  final DeleteMaterialModel deleteMaterialModel;

  DeleteMaterialSuccessState(this.deleteMaterialModel);
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
class MaterialClearState extends MaterialManagementState {}

class RemoveSelectedFileState extends MaterialManagementState {}

