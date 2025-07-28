import 'package:smart_cleaning_application/features/screens/dashboard/stock/category_management/data/model/category_management_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/category_management/data/model/delete_category_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/category_management/data/model/deleted_category_list_model.dart';

abstract class CategoryManagementState {}

class CategoryManagementInitialState extends CategoryManagementState {}

class CategoryManagementLoadingState extends CategoryManagementState {}

class CategoryManagementSuccessState extends CategoryManagementState {
  final CategoryManagementModel categoryManagementModel;

  CategoryManagementSuccessState(this.categoryManagementModel);
}

class CategoryManagementErrorState extends CategoryManagementState {
  final String error;
  CategoryManagementErrorState(this.error);
}
//***************** */

class DeleteCategoryLoadingState extends CategoryManagementState {}

class DeleteCategorySuccessState extends CategoryManagementState {
  final DeleteCategoryModel deleteCategoryModel;

  DeleteCategorySuccessState(this.deleteCategoryModel);
}

class DeleteCategoryErrorState extends CategoryManagementState {
  final String error;
  DeleteCategoryErrorState(this.error);
}
//***************** */

class AllDeletedCategoryLoadingState extends CategoryManagementState {}

class AllDeletedCategorySuccessState extends CategoryManagementState {
  final DeletedCategoryListModel deletedCategoryListModel;

  AllDeletedCategorySuccessState(this.deletedCategoryListModel);
}

class AllDeletedCategoryErrorState extends CategoryManagementState {
  final String error;
  AllDeletedCategoryErrorState(this.error);
}
//***************** */

class RestoreCategoryLoadingState extends CategoryManagementState {}

class RestoreCategorySuccessState extends CategoryManagementState {
  final String message;

  RestoreCategorySuccessState(this.message);
}

class RestoreCategoryErrorState extends CategoryManagementState {
  final String error;
  RestoreCategoryErrorState(this.error);
}
//***************** */

class ForceDeleteCategoryLoadingState extends CategoryManagementState {}

class ForceDeleteCategorySuccessState extends CategoryManagementState {
  final String message;

  ForceDeleteCategorySuccessState(this.message);
}

class ForceDeleteCategoryErrorState extends CategoryManagementState {
  final String error;
  ForceDeleteCategoryErrorState(this.error);
}
