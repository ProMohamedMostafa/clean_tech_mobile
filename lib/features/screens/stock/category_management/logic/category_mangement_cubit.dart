import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/data/model/category_management_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/data/model/deleted_category_list_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/logic/category_mangement_state.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/data/model/category_details_model.dart';

class CategoryManagementCubit extends Cubit<CategoryManagementState> {
  CategoryManagementCubit() : super(CategoryManagementInitialState());

  static CategoryManagementCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  TextEditingController parentCategoryIdController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController unitIdController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  CategoryManagementModel? categoryManagementModel;
  getCategoryList() {
    emit(CategoryManagementLoadingState());
    DioHelper.getData(url: ApiConstants.categoryUrl, query: {
      'Search': searchController.text,
      'ParentCategory': parentCategoryIdController.text,
      'Unit': unitIdController.text,
    }).then((value) {
      categoryManagementModel = CategoryManagementModel.fromJson(value!.data);
      emit(CategoryManagementSuccessState(categoryManagementModel!));
    }).catchError((error) {
      emit(CategoryManagementErrorState(error.toString()));
    });
  }

  deleteCategory(int id) {
    emit(DeleteCategoryLoadingState());
    DioHelper.postData(url: 'categories/delete/$id').then((value) {
      final message = value?.data['message'] ?? "deleted successfully";
      emit(DeleteCategorySuccessState(message!));
    }).catchError((error) {
      emit(DeleteCategoryErrorState(error.toString()));
    });
  }

  DeletedCategoryListModel? deletedCategoryListModel;
  getAllDeletedCategory() {
    emit(DeletedCategoryLoadingState());
    DioHelper.getData(url: ApiConstants.deleteCategoryListUrl).then((value) {
      deletedCategoryListModel = DeletedCategoryListModel.fromJson(value!.data);
      emit(DeletedCategorySuccessState(deletedCategoryListModel!));
    }).catchError((error) {
      emit(DeletedCategoryErrorState(error.toString()));
    });
  }

  restoreDeletedCategory(int id) {
    emit(RestoreCategoryLoadingState());
    DioHelper.postData(url: 'categories/restore/$id').then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(RestoreCategorySuccessState(message));
    }).catchError((error) {
      emit(RestoreCategoryErrorState(error.toString()));
    });
  }

  forcedDeletedCategory(int id) {
    emit(ForceDeleteCategoryLoadingState());
    DioHelper.deleteData(url: 'categories/forcedelete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(ForceDeleteCategorySuccessState(message));
    }).catchError((error) {
      emit(ForceDeleteCategoryErrorState(error.toString()));
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
}
