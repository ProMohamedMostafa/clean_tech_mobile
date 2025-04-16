import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/data/model/category_management_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/data/model/transaction_management_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/view_transaction/data/model/transaction_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/providers_model.dart';

abstract class TransactionManagementState {}

class TransactionManagementInitialState extends TransactionManagementState {}

class TransactionManagementLoadingState extends TransactionManagementState {}

class TransactionManagementSuccessState extends TransactionManagementState {
  final TransactionManagementModel transactionManagementModel;

  TransactionManagementSuccessState(this.transactionManagementModel);
}

class TransactionManagementErrorState extends TransactionManagementState {
  final String error;
  TransactionManagementErrorState(this.error);
}

//***************** */

class UsersLoadingState extends TransactionManagementState {}

class UsersSuccessState extends TransactionManagementState {
  final UsersModel usersModel;

  UsersSuccessState(this.usersModel);
}

class UsersErrorState extends TransactionManagementState {
  final String error;
  UsersErrorState(this.error);
}

//***************** */

class CategoriesLoadingState extends TransactionManagementState {}

class CategoriesSuccessState extends TransactionManagementState {
  final CategoryManagementModel catergoriesModel;

  CategoriesSuccessState(this.catergoriesModel);
}

class CategoriesErrorState extends TransactionManagementState {
  final String error;
  CategoriesErrorState(this.error);
}
//**************************** */

class ProvidersLoadingState extends TransactionManagementState {}

class ProvidersSuccessState extends TransactionManagementState {
  final ProvidersModel providersModel;

  ProvidersSuccessState(this.providersModel);
}

class ProvidersErrorState extends TransactionManagementState {
  final String error;
  ProvidersErrorState(this.error);
}
//**************************** */

class TransactionDetailsLoadingState extends TransactionManagementState {}

class TransactionDetailsSuccessState extends TransactionManagementState {
  final TransactionDetailsModel transactionDetailsModel;

  TransactionDetailsSuccessState(this.transactionDetailsModel);
}

class TransactionDetailsErrorState extends TransactionManagementState {
  final String error;
  TransactionDetailsErrorState(this.error);
}
