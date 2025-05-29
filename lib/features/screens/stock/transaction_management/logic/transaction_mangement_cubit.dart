import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/widgets/filter/data/model/filter_dialog_data_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/data/model/transaction_management_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/logic/transaction_mangement_state.dart';
import 'package:smart_cleaning_application/features/screens/stock/view_transaction/data/model/transaction_details_model.dart';

class TransactionManagementCubit extends Cubit<TransactionManagementState> {
  TransactionManagementCubit() : super(TransactionManagementInitialState());

  static TransactionManagementCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  ScrollController scrollController = ScrollController();

  int selectedIndex = 0;
  int currentPage = 1;
  FilterDialogDataModel? filterModel;
  int? type;
  TransactionManagementModel? transactionManagementModel;
  TransactionManagementModel? transactionManagementInModel;
  TransactionManagementModel? transactionManagementOutModel;
  getTransactionList() {
    emit(TransactionManagementLoadingState());
    transactionManagementModel == null;
    DioHelper.getData(url: ApiConstants.transactionUrl, query: {
      'PageNumber': currentPage,
      'PageSize': 15,
      'Search': searchController.text,
      'CategoryId': filterModel?.categoryId,
      'ProviderId': filterModel?.providerId,
      'UserId': filterModel?.userId,
      'StartDate': filterModel?.startDate,
      'EndDate': filterModel?.endDate,
      'Type': filterModel?.transactionTypeId ?? type,
    }).then((value) {
      final newTransaction = TransactionManagementModel.fromJson(value!.data);
      if (type == 0) {
        if (currentPage == 1 || transactionManagementInModel == null) {
          transactionManagementInModel = newTransaction;
        } else {
          transactionManagementInModel?.data?.data
              ?.addAll(newTransaction.data?.data ?? []);
          transactionManagementInModel?.data?.currentPage =
              newTransaction.data?.currentPage;
          transactionManagementInModel?.data?.totalPages =
              newTransaction.data?.totalPages;
        }
      } else if (type == 1) {
        if (currentPage == 1 || transactionManagementOutModel == null) {
          transactionManagementOutModel = newTransaction;
        } else {
          transactionManagementOutModel?.data?.data
              ?.addAll(newTransaction.data?.data ?? []);
          transactionManagementOutModel?.data?.currentPage =
              newTransaction.data?.currentPage;
          transactionManagementOutModel?.data?.totalPages =
              newTransaction.data?.totalPages;
        }
      } else {
        if (currentPage == 1 || transactionManagementModel == null) {
          transactionManagementModel = newTransaction;
        } else {
          transactionManagementModel?.data?.data
              ?.addAll(newTransaction.data?.data ?? []);
          transactionManagementModel?.data?.currentPage =
              newTransaction.data?.currentPage;
          transactionManagementModel?.data?.totalPages =
              newTransaction.data?.totalPages;
        }
      }

      emit(TransactionManagementSuccessState(transactionManagementModel!));
    }).catchError((error) {
      emit(TransactionManagementErrorState(error.toString()));
    });
  }

  void initialize() {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          currentPage++;
          getTransactionList();
        }
      });

    getTransactionList();
  }

  void changeTap(int index) {
    selectedIndex = index;
    currentPage = 1;
    type = index == 1
        ? 0
        : index == 2
            ? 1
            : null;

    if (index == 1 && transactionManagementInModel != null) {
      emit(TransactionManagementSuccessState(transactionManagementInModel!));
    } else if (index == 2 && transactionManagementOutModel != null) {
      emit(TransactionManagementSuccessState(transactionManagementOutModel!));
    } else if (index == 0 && transactionManagementModel != null) {
      emit(TransactionManagementSuccessState(transactionManagementModel!));
    } else {
      getTransactionList();
    }
  }

  TransactionDetailsModel? transactionDetailsModel;
  getTransactionDetails(int? id, int? type) {
    emit(TransactionDetailsLoadingState());
    DioHelper.getData(url: 'stock/transactions/$id/$type').then((value) {
      transactionDetailsModel = TransactionDetailsModel.fromJson(value!.data);
      emit(TransactionDetailsSuccessState(transactionDetailsModel!));
    }).catchError((error) {
      emit(TransactionDetailsErrorState(error.toString()));
    });
  }

  String getDateOnly(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  final List<int> typeIdList = [0, 1];
  final List<Color> statusColorList = [Colors.green, Colors.red];

  int getTransactionType({
    required int selectedIndex,
    required int index,
  }) {
    final model = transactionManagementModel;
    if (model == null || model.data == null || model.data!.data == null)
      return -1;

    final data = model.data!.data!;
    if (selectedIndex == 0) {
      return data[index].typeId ?? -1;
    } else {
      final filtered = data
          .where((type) => type.typeId == (selectedIndex == 1 ? 0 : 1))
          .toList();
      return filtered[index].typeId ?? -1;
    }
  }

  Color getStatusColorForType(int typeId) {
    final index = typeIdList.indexOf(typeId);
    return index != -1 ? statusColorList[index] : Colors.black;
  }
}
