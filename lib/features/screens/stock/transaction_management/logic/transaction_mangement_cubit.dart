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
  ScrollController scrollController = ScrollController();
  ScrollController inScrollController = ScrollController();
  ScrollController outScrollController = ScrollController();
  int currentPage = 1;

  TransactionManagementModel? transactionManagementModel;
  getTransactionList({int? userId, int? categoryId, int? providerId}) {
    emit(TransactionManagementLoadingState());
    DioHelper.getData(url: ApiConstants.transactionUrl, query: {
      'PageNumber': currentPage,
      'PageSize': 10,
      'Search': searchController.text,
      'UserId': userId,
      'StartDate': startDateController.text,
      'EndDate': endDateController.text,
      'ProviderId': providerId,
      'CategoryId': categoryId,
    }).then((value) {
      final newTransaction = TransactionManagementModel.fromJson(value!.data);

      if (transactionManagementModel == null) {
        transactionManagementModel = newTransaction;
      } else {
        transactionManagementModel?.data.data
            .addAll(newTransaction.data?.data ?? []);
        transactionManagementModel?.data.currentPage =
            newTransaction.data.currentPage;
        transactionManagementModel?.data.totalPages =
            newTransaction.data.totalPages;
      }
      emit(TransactionManagementSuccessState(transactionManagementModel!));
    }).catchError((error) {
      emit(TransactionManagementErrorState(error.toString()));
    });
  }

  int currentPageIn = 1;

  TransactionManagementModel? transactionManagementInModel;
  getTransactionInList({int? userId, int? categoryId, int? providerId}) {
    emit(TransactionManagementLoadingState());
    DioHelper.getData(url: ApiConstants.transactionUrl, query: {
      'PageNumber': currentPageIn,
      'PageSize': 10,
      'Search': searchController.text,
      'UserId': userId,
      'StartDate': startDateController.text,
      'EndDate': endDateController.text,
      'ProviderId': providerId,
      'CategoryId': categoryId,
      'Type': 0,
    }).then((value) {
      final newTransaction = TransactionManagementModel.fromJson(value!.data);

      if (transactionManagementInModel == null) {
        transactionManagementInModel = newTransaction;
      } else {
        transactionManagementInModel?.data.data
            .addAll(newTransaction.data?.data ?? []);
        transactionManagementInModel?.data.currentPage =
            newTransaction.data.currentPage;
        transactionManagementInModel?.data.totalPages =
            newTransaction.data.totalPages;
      }
      emit(TransactionManagementSuccessState(transactionManagementInModel!));
    }).catchError((error) {
      emit(TransactionManagementErrorState(error.toString()));
    });
  }

  int currentPageOut = 1;

  TransactionManagementModel? transactionManagementOutModel;
  getTransactionOutList({int? userId, int? categoryId, int? providerId}) {
    emit(TransactionManagementLoadingState());
    DioHelper.getData(url: ApiConstants.transactionUrl, query: {
      'PageNumber': currentPageIn,
      'PageSize': 10,
      'Search': searchController.text,
      'UserId': userId,
      'StartDate': startDateController.text,
      'EndDate': endDateController.text,
      'ProviderId': providerId,
      'CategoryId': categoryId,
      'Type': 1,
    }).then((value) {
      final newTransaction = TransactionManagementModel.fromJson(value!.data);

      if (transactionManagementOutModel == null) {
        transactionManagementOutModel = newTransaction;
      } else {
        transactionManagementOutModel?.data.data
            .addAll(newTransaction.data?.data ?? []);
        transactionManagementOutModel?.data.currentPage =
            newTransaction.data.currentPage;
        transactionManagementOutModel?.data.totalPages =
            newTransaction.data.totalPages;
      }
      emit(TransactionManagementSuccessState(transactionManagementOutModel!));
    }).catchError((error) {
      emit(TransactionManagementErrorState(error.toString()));
    });
  }

  initialize() {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          currentPage++;
          getTransactionList();
        }
      });
  }

  initializeIn() {
    inScrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          currentPage++;
          getTransactionList();
        }
      });
  }

  initializeOut() {
    outScrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          currentPage++;
          getTransactionList();
        }
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
