import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/stock/add_category/data/model/add_category_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/add_category/logic/add_category_state.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/data/model/category_management_model.dart';

class AddCategoryCubit extends Cubit<AddCategoryState> {
  AddCategoryCubit() : super(AddCategoryInitialState());

  static AddCategoryCubit get(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController parentCategoryController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  AddCategoryModel? addCategoryModel;
  addCategory(int? unit , int? parentCategory) {
    emit(AddCategoryLoadingState());
    DioHelper.postData(url: ApiConstants.createCategoryUrl, data: {
      "name": nameController.text,
      "unit": unit,
      "parentCategoryId": parentCategory,
    }).then((value) {
      addCategoryModel = AddCategoryModel.fromJson(value!.data);
      emit(AddCategorySuccessState(addCategoryModel!));
    }).catchError((error) {
      emit(AddCategoryErrorState(error.toString()));
    });
  }

  CategoryManagementModel? categoryManagementModel;
  getCategoryList() {
    emit(CategoryManagementLoadingState());
    DioHelper.getData(url: ApiConstants.categoryUrl).then((value) {
      categoryManagementModel = CategoryManagementModel.fromJson(value!.data);
      emit(CategoryManagementSuccessState(categoryManagementModel!));
    }).catchError((error) {
      emit(CategoryManagementErrorState(error.toString()));
    });
  }
}
