part of 'filter_dialog_cubit.dart';

abstract class FilterDialogState<T> {}

final class FilterDialogInitial extends FilterDialogState {}

final class FilterDialogLoading<T> extends FilterDialogState {}

final class FilterDialogSuccess<T> extends FilterDialogState {}

final class FilterDialogError<T> extends FilterDialogState {}

//**************** */
class FilterDialogLevelChanged extends FilterDialogState {}
class ChangeActionsState extends FilterDialogState {}
