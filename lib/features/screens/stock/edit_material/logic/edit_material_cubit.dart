import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/data/model/category_management_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/edit_material/data/model/edit_material_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/edit_material/logic/edit_material_state.dart';
import 'package:smart_cleaning_application/features/screens/stock/view_material/data/model/material_details_model.dart';

class EditMaterialCubit extends Cubit<EditMaterialState> {
  EditMaterialCubit() : super(EditMaterialInitialState());

  static EditMaterialCubit get(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController miniController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  EditMaterialModel? editMaterialModel;
  editMaterial(
    int id,
    int? categoryId,
  ) {
    emit(EditMaterialLoadingState());
    DioHelper.putData(url: ApiConstants.editMaterialUrl, data: {
      "id": id,
      "name": nameController.text.isEmpty
          ? materialDetailsModel!.data!.name
          : nameController.text,
      "categoryId": categoryId ?? materialDetailsModel!.data!.categoryId,
      "minThreshold": miniController.text.isEmpty
          ? materialDetailsModel!.data!.minThreshold
          : miniController.text,
      "description": descriptionController.text.isEmpty
          ? materialDetailsModel!.data!.description
          : descriptionController.text,
    }).then((value) {
      editMaterialModel = EditMaterialModel.fromJson(value!.data);
      emit(EditMaterialSuccessState(editMaterialModel!));
    }).catchError((error) {
      emit(EditMaterialErrorState(error.toString()));
    });
  }

  MaterialDetailsModel? materialDetailsModel;
  getMaterialDetails(int id) {
    emit(MaterialDetailsLoadingState());
    DioHelper.getData(url: 'materials/$id').then((value) {
      materialDetailsModel = MaterialDetailsModel.fromJson(value!.data);
      emit(MaterialDetailsSuccessState(materialDetailsModel!));
    }).catchError((error) {
      emit(MaterialDetailsErrorState(error.toString()));
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
