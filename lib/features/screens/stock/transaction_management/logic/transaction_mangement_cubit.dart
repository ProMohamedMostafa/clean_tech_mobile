import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/widgets/filter/data/model/filter_dialog_data_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/data/model/transaction_management_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/logic/transaction_mangement_state.dart';

class TransactionManagementCubit extends Cubit<TransactionManagementState> {
  TransactionManagementCubit() : super(TransactionManagementInitialState());

  static TransactionManagementCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  int selectedIndex = 0;
  int currentPage = 1;
  FilterDialogDataModel? filterModel;
  int? type;
  TransactionManagementModel? transactionManagementModel;
  TransactionManagementModel? transactionManagementInModel;
  TransactionManagementModel? transactionManagementOutModel;
  Future<void> getTransactionList({int? type, int page = 1}) async {
    emit(TransactionManagementLoadingState());

    try {
      final response = await DioHelper.getData(
        url: ApiConstants.transactionUrl,
        query: {
          'PageNumber': page,
          'PageSize': 15,
          'Search': searchController.text,
          'CategoryId': filterModel?.categoryId,
          'ProviderId': filterModel?.providerId,
          'UserId': filterModel?.userId,
          'StartDate': filterModel?.startDate,
          'EndDate': filterModel?.endDate,
          'Type': filterModel?.transactionTypeId ?? type,
        },
      );

      final newTransaction =
          TransactionManagementModel.fromJson(response!.data);

      if (type == 0) {
        transactionManagementInModel = newTransaction;
      } else if (type == 1) {
        transactionManagementOutModel = newTransaction;
      } else {
        transactionManagementModel = newTransaction;
      }

      emit(TransactionManagementSuccessState(transactionManagementModel!));
    } catch (e) {
      emit(TransactionManagementErrorState(e.toString()));
    }
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
    fetchAllCounts();
  }

  Future<void> fetchAllCounts() async {
    emit(TransactionManagementLoadingState());

    try {
      await getTransactionList(type: null, page: 1); // All
      await getTransactionList(type: 0, page: 1); // Inside
      await getTransactionList(type: 1, page: 1); // Outside

      emit(TransactionManagementSuccessState(transactionManagementModel!));
    } catch (e) {
      emit(TransactionManagementErrorState(e.toString()));
    }
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
      getTransactionList(type: type, page: 1);
    }
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
