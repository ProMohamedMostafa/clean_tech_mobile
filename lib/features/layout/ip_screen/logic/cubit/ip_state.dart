part of 'ip_cubit.dart';

abstract class IpState {}

final class IpInitial extends IpState {}

final class IpLoadingState extends IpState {}

final class IpSuccessState extends IpState {
  final String message;

  IpSuccessState(this.message);
}

final class IpErrorState extends IpState {
  final String error;

  IpErrorState(this.error);
}
