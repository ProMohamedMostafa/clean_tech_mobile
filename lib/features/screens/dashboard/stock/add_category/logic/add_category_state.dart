import 'package:smart_cleaning_application/features/screens/dashboard/stock/add_category/data/model/add_category_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/category_management/data/model/category_management_model.dart';

abstract class AddCategoryState {}

class AddCategoryInitialState extends AddCategoryState {}

class AddCategoryLoadingState extends AddCategoryState {}

class AddCategorySuccessState extends AddCategoryState {
  final AddCategoryModel addCategoryModel;

  AddCategorySuccessState(this.addCategoryModel);
}

class AddCategoryErrorState extends AddCategoryState {
  final String error;
  AddCategoryErrorState(this.error);
}
//***************************** */

class CategoryManagementLoadingState extends AddCategoryState {}

class CategoryManagementSuccessState extends AddCategoryState {
  final CategoryManagementModel categoryManagementModel;

  CategoryManagementSuccessState(this.categoryManagementModel);
}

class CategoryManagementErrorState extends AddCategoryState {
  final String error;
  CategoryManagementErrorState(this.error);
}