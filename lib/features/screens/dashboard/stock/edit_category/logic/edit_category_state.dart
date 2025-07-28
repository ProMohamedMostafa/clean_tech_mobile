
import 'package:smart_cleaning_application/features/screens/dashboard/stock/category_management/data/model/category_management_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/edit_category/data/model/edit_category_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/edit_category/data/model/category_details_model.dart';

abstract class EditCategoryState {}

class EditCategoryInitialState extends EditCategoryState {}

class EditCategoryLoadingState extends EditCategoryState {}

class EditCategorySuccessState extends EditCategoryState {
  final EditCategoryModel editCategoryModel;

  EditCategorySuccessState(this.editCategoryModel);
}

class EditCategoryErrorState extends EditCategoryState {
  final String error;
  EditCategoryErrorState(this.error);
}
//***************** */

class CategoryDetailsLoadingState extends EditCategoryState {}

class CategoryDetailsSuccessState extends EditCategoryState {
  final CategoryDetailsModel categoryDetailsModelModel;

  CategoryDetailsSuccessState(this.categoryDetailsModelModel);
}

class CategoryDetailsErrorState extends EditCategoryState {
  final String error;
  CategoryDetailsErrorState(this.error);
}
//**************** */

class AllCategoriesLoadingState extends EditCategoryState {}

class AllCategoriesSuccessState extends EditCategoryState {
  final CategoryManagementModel categoryManagementModel;

  AllCategoriesSuccessState(this.categoryManagementModel);
}

class AllCategoriesErrorState extends EditCategoryState {
  final String error;
  AllCategoriesErrorState(this.error);
}