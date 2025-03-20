import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/gallary_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/data/model/category_management_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/data/model/deleted_material_list_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/data/model/material_management_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/logic/material_mangement_state.dart';
import 'package:smart_cleaning_application/features/screens/stock/view_material/data/model/material_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/providers_model.dart';

class MaterialManagementCubit extends Cubit<MaterialManagementState> {
  MaterialManagementCubit() : super(MaterialManagementInitialState());

  static MaterialManagementCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController unitIdController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController providerController = TextEditingController();
  TextEditingController providerIdController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  MaterialManagementModel? materialManagementModel;
  getMaterialList({int? categoryId}) {
    emit(MaterialManagementLoadingState());
    DioHelper.getData(url: ApiConstants.materialUrl, query: {
      'Search': searchController.text,
      'category': categoryId,
    }).then((value) {
      materialManagementModel = MaterialManagementModel.fromJson(value!.data);
      emit(MaterialManagementSuccessState(materialManagementModel!));
    }).catchError((error) {
      emit(MaterialManagementErrorState(error.toString()));
    });
  }

  deleteMaterial(int id) {
    emit(DeleteMaterialLoadingState());
    DioHelper.postData(url: 'materials/delete/$id').then((value) {
      final message = value?.data['message'] ?? "deleted successfully";
      emit(DeleteMaterialSuccessState(message!));
    }).catchError((error) {
      emit(DeleteMaterialErrorState(error.toString()));
    });
  }

  DeletedMaterialListModel? deletedMaterialListModel;
  getAllDeletedMaterial() {
    emit(DeletedMaterialLoadingState());
    DioHelper.getData(url: ApiConstants.deleteMaterialListUrl).then((value) {
      deletedMaterialListModel = DeletedMaterialListModel.fromJson(value!.data);
      emit(DeletedMaterialSuccessState(deletedMaterialListModel!));
    }).catchError((error) {
      emit(DeletedMaterialErrorState(error.toString()));
    });
  }

  restoreDeletedMaterial(int id) {
    emit(RestoreMaterialLoadingState());
    DioHelper.postData(url: 'materials/restore/$id').then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(RestoreMaterialSuccessState(message));
    }).catchError((error) {
      emit(RestoreMaterialErrorState(error.toString()));
    });
  }

  forcedDeletedMaterial(int id) {
    emit(ForceDeleteMaterialLoadingState());
    DioHelper.deleteData(url: 'materials/forcedelete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(ForceDeleteMaterialSuccessState(message));
    }).catchError((error) {
      emit(ForceDeleteMaterialErrorState(error.toString()));
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

  ProvidersModel? providersModel;
  getProviders() {
    emit(AllProvidersLoadingState());
    DioHelper.getData(url: ApiConstants.allProvidersUrl).then((value) {
      providersModel = ProvidersModel.fromJson(value!.data);
      emit(AllProvidersSuccessState(providersModel!));
    }).catchError((error) {
      emit(AllProvidersErrorState(error.toString()));
    });
  }

  CategoryManagementModel? categoryManagementModel;
  getCategoryList() {
    emit(CategoriesLoadingState());
    DioHelper.getData(url: ApiConstants.categoryUrl).then((value) {
      categoryManagementModel = CategoryManagementModel.fromJson(value!.data);
      emit(CategoriesSuccessState(categoryManagementModel!));
    }).catchError((error) {
      emit(CategoriesErrorState(error.toString()));
    });
  }

  addMaterial({
    int? materialId,
    int? providerId,
    double? quantityId,
    double? priceId,
    String? image,
  }) async {
    emit(AddMaterialLoadingState());

    MultipartFile? imageFile;
    if (image != null && image.isNotEmpty) {
      imageFile = await MultipartFile.fromFile(
        image,
        filename: image.split('/').last,
      );
    }
    Map<String, dynamic> formDataMap = {
      'MaterialId': materialId,
      'ProviderId': providerId,
      "Quantity": quantityId,
      'Price': priceId,
      'File': imageFile,
    };
    FormData formData = FormData.fromMap(formDataMap);

    try {
      final response =
          await DioHelper.postData2(url: 'stock/in', data: formData);
      final message = response?.data['message'] ?? "Add successfully";
      emit(AddMaterialSuccessState(message!));
    } catch (error) {
      emit(AddMaterialErrorState(error.toString()));
    }
  }

  reduceMaterial({
    int? materialId,
    int? providerId,
    double? quantityId,
  }) async {
    emit(ReduceMaterialLoadingState());
    try {
      final response = await DioHelper.postData(url: 'stock/out', data: {
        'MaterialId': materialId,
        'ProviderId': providerId,
        "Quantity": quantityId,
      });
      final message = response?.data['message'] ?? "Reduce successfully";
      emit(ReduceMaterialSuccessState(message!));
    } catch (error) {
      emit(ReduceMaterialErrorState(error.toString()));
    }
  }

  GalleryModel? gellaryModel;
  XFile? image;
  Future<void> galleryFile() async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      image = selectedImage;
      emit(ImageSelectedState(image!));
    }
  }
}
