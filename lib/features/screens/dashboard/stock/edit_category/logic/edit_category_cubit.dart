import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/category_management/data/model/category_management_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/edit_category/data/model/edit_category_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/edit_category/logic/edit_category_state.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/edit_category/data/model/category_details_model.dart';

class EditCategoryCubit extends Cubit<EditCategoryState> {
  EditCategoryCubit() : super(EditCategoryInitialState());

  static EditCategoryCubit get(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController unitIdController = TextEditingController();
  TextEditingController parentCategoryController = TextEditingController();
  TextEditingController parentCategoryIdController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  EditCategoryModel? editCategoryModel;
  editCategory(int id) {
    emit(EditCategoryLoadingState());
    DioHelper.putData(url: ApiConstants.editCategoryUrl, data: {
      "id": id,
      "name": nameController.text.isEmpty
          ? categoryDetailsModel!.data!.name
          : nameController.text,
      "parentCategoryId": parentCategoryController.text.isEmpty
          ? categoryDetailsModel!.data!.parentCategoryId
          : parentCategoryIdController.text,
      "unit": unitController.text.isEmpty
          ? categoryDetailsModel!.data!.unitId
          : int.parse(unitIdController.text),
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
    emit(AllCategoriesLoadingState());
    DioHelper.getData(url: ApiConstants.categoryUrl).then((value) {
      categoryManagementModel = CategoryManagementModel.fromJson(value!.data);
      emit(AllCategoriesSuccessState(categoryManagementModel!));
    }).catchError((error) {
      emit(AllCategoriesErrorState(error.toString()));
    });
  }
}
