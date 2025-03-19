import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/data/model/category_management_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/edit_category/data/model/edit_category_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/edit_category/logic/edit_category_state.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/data/model/category_details_model.dart';

class EditCategoryCubit extends Cubit<EditCategoryState> {
  EditCategoryCubit() : super(EditCategoryInitialState());

  static EditCategoryCubit get(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController parentCategoryController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  EditCategoryModel? editCategoryModel;
  editCategory(int id, int? unit, int? parentCategory) {
    emit(EditCategoryLoadingState());
    DioHelper.putData(url: ApiConstants.editCategoryUrl, data: {
      "id": id,
      "name": nameController.text.isEmpty
          ? categoryDetailsModel!.data!.name
          : nameController.text,
      "parentCategoryId":
          parentCategory ?? categoryDetailsModel!.data!.parentCategoryId,
      "unit": unit ?? categoryDetailsModel!.data!.unitId,
    }).then((value) {
      editCategoryModel = EditCategoryModel.fromJson(value!.data);
      emit(EditCategorySuccessState(editCategoryModel!));
    }).catchError((error) {
      emit(EditCategoryErrorState(error.toString()));
    });
  }

  CategoryDetailsModel? categoryDetailsModel;
  getCategoryDetails(int id) {
    emit(CategoryDetailsLoadingState());
    DioHelper.getData(url: 'categories/$id').then((value) {
      categoryDetailsModel = CategoryDetailsModel.fromJson(value!.data);
      emit(CategoryDetailsSuccessState(categoryDetailsModel!));
    }).catchError((error) {
      emit(CategoryDetailsErrorState(error.toString()));
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
