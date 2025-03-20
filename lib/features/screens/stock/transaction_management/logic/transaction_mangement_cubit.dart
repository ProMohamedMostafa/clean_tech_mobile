import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/data/model/category_management_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/data/model/transaction_management_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/logic/transaction_mangement_state.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/providers_model.dart';

class TransactionManagementCubit extends Cubit<TransactionManagementState> {
  TransactionManagementCubit() : super(TransactionManagementInitialState());

  static TransactionManagementCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController providerController = TextEditingController();
  TextEditingController providerIdController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  TransactionManagementModel? transactionManagementModel;
  getTransactionList(
      {int? type, int? userId, int? categoryId, int? providerId}) {
    emit(TransactionManagementLoadingState());
    DioHelper.getData(url: ApiConstants.transactionUrl, query: {
      'Search': searchController.text,
      'UserId': userId,
      'StartDate': startDateController.text,
      'EndDate': endDateController.text,
      'ProviderId': providerId,
      'CategoryId': categoryId,
      'Type': type,
    }).then((value) {
      transactionManagementModel =
          TransactionManagementModel.fromJson(value!.data);
      emit(TransactionManagementSuccessState(transactionManagementModel!));
    }).catchError((error) {
      emit(TransactionManagementErrorState(error.toString()));
    });
  }

  UsersModel? usersModel;
  getUsers() {
    emit(UsersLoadingState());
    DioHelper.getData(url: "users/pagination", query: {'role': 1})
        .then((value) {
      usersModel = UsersModel.fromJson(value!.data);
      emit(UsersSuccessState(usersModel!));
    }).catchError((error) {
      emit(UsersErrorState(error.toString()));
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

  ProvidersModel? providersModel;
  getProviders() {
    emit(ProvidersLoadingState());
    DioHelper.getData(url: ApiConstants.allProvidersUrl).then((value) {
      providersModel = ProvidersModel.fromJson(value!.data);
      emit(ProvidersSuccessState(providersModel!));
    }).catchError((error) {
      emit(ProvidersErrorState(error.toString()));
    });
  }
}
