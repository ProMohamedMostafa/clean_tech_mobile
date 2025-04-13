import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/data/model/category_management_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/data/model/delete_category_model.dart';
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
  ScrollController scrollController = ScrollController();

  int currentPage = 1;
  CategoryManagementModel? categoryManagementModel;
  getCategoryList() {
    emit(CategoryManagementLoadingState());
    DioHelper.getData(url: ApiConstants.categoryUrl, query: {
      'PageNumber': currentPage,
      'PageSize': 10,
      'Search': searchController.text,
      'ParentCategory': parentCategoryIdController.text,
      'Unit': unitIdController.text,
    }).then((value) {
      final newCategories = CategoryManagementModel.fromJson(value!.data);

      if (categoryManagementModel == null) {
        categoryManagementModel = newCategories;
      } else {
        categoryManagementModel?.data.categories
            .addAll(newCategories.data?.categories ?? []);
        categoryManagementModel?.data.currentPage =
            newCategories.data.currentPage;
        categoryManagementModel?.data.totalPages =
            newCategories.data.totalPages;
      }

      emit(CategoryManagementSuccessState(categoryManagementModel!));
    }).catchError((error) {
      emit(CategoryManagementErrorState(error.toString()));
    });
  }

  void initialize() {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          currentPage++;
          getCategoryList();
        }
      });
  }

  DeleteCategoryModel? deleteCategoryModel;
  List<CategoryModel> deletedCategories = [];

  deleteCategory(int id) {
    emit(DeleteCategoryLoadingState());
    DioHelper.postData(url: 'categories/delete/$id').then((value) {
      deleteCategoryModel = DeleteCategoryModel.fromJson(value!.data);

      final deletedCategory =
          categoryManagementModel?.data?.categories?.firstWhere(
        (user) => user.id == id,
      );

      if (deletedCategory != null) {
        // Remove from main list
        categoryManagementModel?.data?.categories
            ?.removeWhere((user) => user.id == id);

        // Add to deleted list
        deletedCategories.insert(0, deletedCategory);

        //  Reload current page to refill to 10 users
        if (currentPage == 1) {
          categoryManagementModel = null;
          getCategoryList();
        }
      }
      emit(DeleteCategorySuccessState(deleteCategoryModel!));
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
      // Find and process the restored user
      final restoredData = deletedCategoryListModel?.data?.firstWhere(
        (data) => data.id == id,
      );

      if (restoredData != null) {
        // Remove from deleted list
        deletedCategoryListModel?.data?.removeWhere((data) => data.id == id);

        // Initialize users list if null
        categoryManagementModel?.data?.categories ??= [];

        // Convert to User object
        final restoredUser = CategoryModel.fromJson(restoredData.toJson());

        // Find the correct position to insert (sorted by ID)
        int insertIndex = categoryManagementModel!.data.categories
            .indexWhere((user) => user.id > restoredUser.id);

        // If not found, add to end
        if (insertIndex == -1) {
          insertIndex = categoryManagementModel!.data.categories.length;
        }

        // Insert at correct position
        categoryManagementModel?.data.categories
            .insert(insertIndex, restoredUser);

        // Update pagination metadata
        categoryManagementModel?.data.totalCount =
            (categoryManagementModel?.data.totalCount ?? 0) + 1;
        categoryManagementModel?.data.totalPages =
            ((categoryManagementModel?.data.totalCount ?? 0) /
                    (categoryManagementModel?.data.pageSize ?? 10))
                .ceil();
      }
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
