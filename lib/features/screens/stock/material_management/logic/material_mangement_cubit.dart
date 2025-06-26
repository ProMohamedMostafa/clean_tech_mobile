import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/widgets/filter/data/model/filter_dialog_data_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/gallary_model.dart';
import 'package:smart_cleaning_application/features/screens/provider/provider_management/data/models/providers_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/data/model/delete_material_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/data/model/deleted_material_list_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/data/model/material_management_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/logic/material_mangement_state.dart';

class MaterialManagementCubit extends Cubit<MaterialManagementState> {
  MaterialManagementCubit() : super(MaterialManagementInitialState());

  static MaterialManagementCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController quantityIdController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController priceIdController = TextEditingController();
  TextEditingController providerController = TextEditingController();
  TextEditingController providerIdController = TextEditingController();

  ScrollController scrollController = ScrollController();

  int selectedIndex = 0;
  int currentPage = 1;
  FilterDialogDataModel? filterModel;
  MaterialManagementModel? materialManagementModel;
  getMaterialList({int? categoryId}) {
    emit(MaterialManagementLoadingState());
    DioHelper.getData(url: ApiConstants.materialUrl, query: {
      'PageNumber': currentPage,
      'PageSize': 15,
      'Search': searchController.text,
      'CategoryId': categoryId ?? filterModel?.categoryId,
    }).then((value) {
      final newMaterial = MaterialManagementModel.fromJson(value!.data);

      if (currentPage == 1 || materialManagementModel == null) {
        materialManagementModel = newMaterial;
      } else {
        materialManagementModel?.data?.materials
            ?.addAll(newMaterial.data?.materials ?? []);
        materialManagementModel?.data?.currentPage =
            newMaterial.data?.currentPage;
        materialManagementModel?.data?.totalPages =
            newMaterial.data?.totalPages;
      }
      emit(MaterialManagementSuccessState(materialManagementModel!));
    }).catchError((error) {
      emit(MaterialManagementErrorState(error.toString()));
    });
  }

  void initialize({int? id}) {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          currentPage++;
          getMaterialList(categoryId: id);
        }
      });
    getMaterialList(categoryId: id);
    getAllDeletedMaterial();
  }

  void changeTap(int index) {
    selectedIndex = index;

    if (index == 0) {
      if (materialManagementModel == null) {
        currentPage = 1;
        materialManagementModel = null;
        getMaterialList();
      } else {
        emit(MaterialManagementSuccessState(materialManagementModel!));
      }
    } else {
      if (deletedMaterialListModel == null) {
        getAllDeletedMaterial();
      } else {
        emit(DeletedMaterialSuccessState(deletedMaterialListModel!));
      }
    }
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

  DeleteMaterialModel? deleteMaterialModel;
  List<MaterialModel> deletedMaterials = [];
  deleteMaterial(int id) {
    emit(DeleteMaterialLoadingState());
    DioHelper.postData(url: 'materials/delete/$id').then((value) {
      deleteMaterialModel = DeleteMaterialModel.fromJson(value!.data);

      final deletedUser = materialManagementModel?.data?.materials?.firstWhere(
        (user) => user.id == id,
      );

      if (deletedUser != null) {
        // Remove from main list
        materialManagementModel?.data?.materials
            ?.removeWhere((user) => user.id == id);

        // Add to deleted list
        deletedMaterials.insert(0, deletedUser);

        //  Reload current page to refill to 10 users
        if (currentPage == 1) {
          materialManagementModel = null;
          getMaterialList();
        }
      }
      emit(DeleteMaterialSuccessState(deleteMaterialModel!));
    }).catchError((error) {
      emit(DeleteMaterialErrorState(error.toString()));
    });
  }

  restoreDeletedMaterial(int id) {
    emit(RestoreMaterialLoadingState());
    DioHelper.postData(url: 'materials/restore/$id').then((value) {
      final message = value?.data['message'] ?? "restored successfully";

      // Find and process the restored user
      final restoredData = deletedMaterialListModel?.data?.firstWhere(
        (data) => data.id == id,
      );

      if (restoredData != null) {
        // Remove from deleted list
        deletedMaterialListModel?.data?.removeWhere((data) => data.id == id);

        // Initialize users list if null
        materialManagementModel?.data?.materials ??= [];

        // Convert to User object
        final restoredUser = MaterialModel.fromJson(restoredData.toJson());

        // Find the correct position to insert (sorted by ID)
        int insertIndex = materialManagementModel!.data!.materials!
            .indexWhere((user) => user.id! > restoredUser.id!);

        // If not found, add to end
        if (insertIndex == -1) {
          insertIndex = materialManagementModel!.data!.materials!.length;
        }

        // Insert at correct position
        materialManagementModel?.data?.materials
            ?.insert(insertIndex, restoredUser);

        // Update pagination metadata
        materialManagementModel?.data?.totalCount =
            (materialManagementModel?.data?.totalCount ?? 0) + 1;
        materialManagementModel?.data?.totalPages =
            ((materialManagementModel?.data?.totalCount ?? 0) /
                    (materialManagementModel?.data?.pageSize ?? 10))
                .ceil();
      }

      emit(RestoreMaterialSuccessState(message));
    }).catchError((error) {
      emit(RestoreMaterialErrorState(error.toString()));
    });
  }

  forcedDeletedMaterial(int id) {
    emit(ForceDeleteMaterialLoadingState());
    DioHelper.deleteData(url: 'materials/forcedelete/$id').then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(ForceDeleteMaterialSuccessState(message));
    }).catchError((error) {
      emit(ForceDeleteMaterialErrorState(error.toString()));
    });
  }

  ProvidersModel? providersModel;
  List<ProviderItem> providerItem = [
    ProviderItem(name: 'No providers available')
  ];
  getProviders() {
    emit(AllProvidersLoadingState());
    DioHelper.getData(url: ApiConstants.allProvidersUrl).then((value) {
      providersModel = ProvidersModel.fromJson(value!.data);
      providerItem = providersModel?.data?.data ??
          [ProviderItem(name: 'No providers available')];
      emit(AllProvidersSuccessState(providersModel!));
    }).catchError((error) {
      emit(AllProvidersErrorState(error.toString()));
    });
  }

  addMaterial({
    int? materialId,
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
      'ProviderId': providerIdController.text,
      "Quantity": quantityIdController.text,
      'Price': priceIdController.text,
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
  }) async {
    emit(ReduceMaterialLoadingState());
    try {
      final response = await DioHelper.postData(url: 'stock/out', data: {
        'MaterialId': materialId,
        'ProviderId': providerIdController.text,
        "Quantity": quantityIdController.text,
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
