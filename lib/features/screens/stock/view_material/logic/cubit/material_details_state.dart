part of 'material_details_cubit.dart';

abstract class MaterialDetailsState {}

final class MaterialDetailsInitial extends MaterialDetailsState {}

class MaterialDetailsLoadingState extends MaterialDetailsState {}

class MaterialDetailsSuccessState extends MaterialDetailsState {
  final MaterialDetailsModel materialDetailsModelModel;

  MaterialDetailsSuccessState(this.materialDetailsModelModel);
}

class MaterialDetailsErrorState extends MaterialDetailsState {
  final String error;
  MaterialDetailsErrorState(this.error);
}
//***************** */

class DeleteMaterialLoadingState extends MaterialDetailsState {}

class DeleteMaterialSuccessState extends MaterialDetailsState {
  final DeleteMaterialModel deleteMaterialModel;

  DeleteMaterialSuccessState(this.deleteMaterialModel);
}

class DeleteMaterialErrorState extends MaterialDetailsState {
  final String error;
  DeleteMaterialErrorState(this.error);
}
//*************** */
class DescToggleState extends MaterialDetailsState {}
