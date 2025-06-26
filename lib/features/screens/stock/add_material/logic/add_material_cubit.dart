import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/stock/add_material/data/model/add_material_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/add_material/logic/add_material_state.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/data/model/category_management_model.dart';

class AddMaterialCubit extends Cubit<AddMaterialState> {
  AddMaterialCubit() : super(AddMaterialInitialState());

  static AddMaterialCubit get(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController categoryIdController = TextEditingController();
  TextEditingController miniController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  AddMaterialModel? addMaterialModel;
  addMaterial() {
    emit(AddMaterialLoadingState());
    DioHelper.postData(url: ApiConstants.createMaterialUrl, data: {
      "name": nameController.text,
      "categoryId": categoryIdController.text,
      "minThreshold": miniController.text,
      "description": descriptionController.text,
    }).then((value) {
      addMaterialModel = AddMaterialModel.fromJson(value!.data);
      emit(AddMaterialSuccessState(addMaterialModel!));
    }).catchError((error) {
      emit(AddMaterialErrorState(error.toString()));
    });
  }

  CategoryManagementModel? categoryManagementModel;
  List<CategoryModel> categoryModel = [
    CategoryModel(name: 'No categories available')
  ];
  getCategoryList() {
    emit(CategoriesLoadingState());
    DioHelper.getData(url: ApiConstants.categoryUrl).then((value) {
      categoryManagementModel = CategoryManagementModel.fromJson(value!.data);
      categoryModel = categoryManagementModel?.data?.categories ??
          [CategoryModel(name: 'No categories available')];
      emit(CategoriesSuccessState(categoryManagementModel!));
    }).catchError((error) {
      emit(CategoriesErrorState(error.toString()));
    });
  }
}
