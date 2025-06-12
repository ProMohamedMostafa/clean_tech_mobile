import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/provider/provider_management/data/models/all_deleted_providers_model.dart';
import 'package:smart_cleaning_application/features/screens/provider/provider_management/data/models/delete_provider_model.dart';
import 'package:smart_cleaning_application/features/screens/provider/provider_management/data/models/providers_model.dart';

part 'provider_state.dart';

class ProviderCubit extends Cubit<ProviderState> {
  ProviderCubit() : super(ProviderInitial());

  TextEditingController searchController = TextEditingController();
  TextEditingController providerController = TextEditingController();
  TextEditingController providerIdController = TextEditingController();
  ScrollController scrollController = ScrollController();
  final formAddKey = GlobalKey<FormState>();

  int selectedIndex = 0;
  int currentPage = 1;
  ProvidersModel? providersModel;
  getProviders() {
    emit(AllProvidersLoadingState());
    DioHelper.getData(url: "providers/pagination", query: {
      'PageNumber': currentPage,
      'PageSize': 20,
      'SearchQuery': searchController.text,
    }).then((value) {
      final newProvider = ProvidersModel.fromJson(value!.data);

      if (currentPage == 1 || providersModel == null) {
        providersModel = newProvider;
      } else {
        providersModel?.data?.data?.addAll(newProvider.data?.data ?? []);
        providersModel?.data?.currentPage = newProvider.data?.currentPage;
        providersModel?.data?.totalPages = newProvider.data?.totalPages;
      }

      emit(AllProvidersSuccessState(providersModel!));
    }).catchError((error) {
      emit(AllProvidersErrorState(error.toString()));
    });
  }

  void initialize() {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          currentPage++;
          getProviders();
        }
      });
    getProviders();
    getAllDeletedProviders();
  }

  void changeTap(int index) {
    selectedIndex = index;

    if (index == 0) {
      if (providersModel == null) {
        currentPage = 1;
        providersModel = null;
        getProviders();
      } else {
        emit(AllProvidersSuccessState(providersModel!));
      }
    } else {
      if (allDeletedProvidersModel == null) {
        getAllDeletedProviders();
      } else {
        emit(AllDeletedProvidersSuccessState(allDeletedProvidersModel!));
      }
    }
  }

  DeleteProviderModel? deleteProviderModel;
  List<ProviderItem> deletedProviders = [];

  providerDelete(int id) {
    emit(ProviderDeleteLoadingState());

    DioHelper.postData(url: 'providers/delete/$id').then((value) {
      deleteProviderModel = DeleteProviderModel.fromJson(value!.data);

      final deletedProvider = providersModel?.data?.data?.firstWhere(
        (provider) => provider.id == id,
      );

      if (deletedProvider != null) {
        providersModel?.data?.data
            ?.removeWhere((provider) => provider.id == id);
        deletedProviders.insert(0, deletedProvider);

        // Decrement totalCount
        if (providersModel?.data?.totalCount != null &&
            providersModel!.data!.totalCount! > 0) {
          providersModel!.data!.totalCount =
              providersModel!.data!.totalCount! - 1;
        }

        if (currentPage == 1) {
          providersModel = null;
          getProviders();
        } else {
          emit(AllProvidersSuccessState(providersModel!));
        }
      }

      emit(ProviderDeleteSuccessState(deleteProviderModel!));
    }).catchError((error) {
      emit(ProviderDeleteErrorState(error.toString()));
    });
  }

  AllDeletedProvidersModel? allDeletedProvidersModel;
  getAllDeletedProviders() {
    emit(AllDeletedProvidersLoadingState());
    DioHelper.getData(url: 'providers/deleted/index').then((value) {
      allDeletedProvidersModel = AllDeletedProvidersModel.fromJson(value!.data);
      emit(AllDeletedProvidersSuccessState(allDeletedProvidersModel!));
    }).catchError((error) {
      emit(AllDeletedProvidersErrorState(error.toString()));
    });
  }

  restoreDeletedProvider(int id) {
    emit(RestoreProvidersLoadingState());

    DioHelper.postData(url: 'providers/restore/$id').then((value) {
      final responseMessage = value?.data['message'] ?? "Restored successfully";

      final restoredData = allDeletedProvidersModel?.data?.firstWhere(
        (data) => data.id == id,
      );

      if (restoredData != null) {
        // Remove from deleted list
        allDeletedProvidersModel?.data?.removeWhere((data) => data.id == id);

        // Initialize users list if null
        providersModel?.data?.data ??= [];

        // Convert to User object
        final restoredUser = ProviderItem.fromJson(restoredData.toJson());

        // Find the correct position to insert (sorted by ID)
        int insertIndex = providersModel!.data!.data!
            .indexWhere((user) => user.id! > restoredUser.id!);

        // If not found, add to end
        if (insertIndex == -1) insertIndex = providersModel!.data!.data!.length;

        // Insert at correct position
        providersModel?.data?.data?.insert(insertIndex, restoredUser);

        // Update pagination metadata
        providersModel?.data?.totalCount =
            (providersModel?.data?.totalCount ?? 0) + 1;
        providersModel?.data?.totalPages =
            ((providersModel?.data?.totalCount ?? 0) /
                    (providersModel?.data?.pageSize ?? 10))
                .ceil();
      }

      emit(RestoreProvidersSuccessState(responseMessage));
    }).catchError((error) {
      emit(RestoreProvidersErrorState(error.toString()));
    });
  }

  forcedDeletedProvider(int id) {
    emit(ForceDeleteProvidersLoadingState());
    DioHelper.deleteData(url: 'providers/forcedelete/$id').then((value) {
      final message = value?.data['message'] ?? "deleted successfully";
      emit(ForceDeleteProvidersSuccessState(message));
    }).catchError((error) {
      emit(ForceDeleteProvidersErrorState(error.toString()));
    });
  }

  addProvider() {
    emit(AddProviderLoadingState());
    DioHelper.postData(url: ApiConstants.userCreateProviderUrl, data: {
      "name": providerController.text,
    }).then((value) {
      final message = value?.data['message'] ?? "Created Successfully";
      providerController.clear();
      providerIdController.clear();
      emit(AddProviderSuccessState(message!));
    }).catchError((error) {
      emit(AddProviderErrorState(error.toString()));
    });
  }

  editProvider(int? id) {
    emit(EditProviderLoadingState());
    DioHelper.putData(url: 'providers/edit', data: {
      "id": id,
      "name": providerController.text,
    }).then((value) {
      final message = value?.data['message'] ?? "Created Successfully";
      providerController.clear();
      providerIdController.clear();
      emit(EditProviderSuccessState(message!));
    }).catchError((error) {
      emit(EditProviderErrorState(error.toString()));
    });
  }
}
