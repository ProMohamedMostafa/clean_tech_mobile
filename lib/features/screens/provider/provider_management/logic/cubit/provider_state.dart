part of 'provider_cubit.dart';

abstract class ProviderState {}

class ProviderInitial extends ProviderState {}

class ProviderLoadingState extends ProviderState {}

class ProviderSuccessState extends ProviderState {}

class ProviderErrorState extends ProviderState {
  final String error;
  ProviderErrorState(this.error);
}
//***************** */

class ProviderDeleteLoadingState extends ProviderState {}

class ProviderDeleteSuccessState extends ProviderState {
  final DeleteProviderModel deleteProviderModel;

  ProviderDeleteSuccessState(this.deleteProviderModel);
}

class ProviderDeleteErrorState extends ProviderState {
  final String error;
  ProviderDeleteErrorState(this.error);
}

//***************** */

class AllProvidersLoadingState extends ProviderState {}

class AllProvidersSuccessState extends ProviderState {
  final ProvidersModel providersModel;

  AllProvidersSuccessState(this.providersModel);
}

class AllProvidersErrorState extends ProviderState {
  final String error;
  AllProvidersErrorState(this.error);
}

//***************** */

class AllDeletedProvidersLoadingState extends ProviderState {}

class AllDeletedProvidersSuccessState extends ProviderState {
  final AllDeletedProvidersModel allDeletedProvidersModel;

  AllDeletedProvidersSuccessState(this.allDeletedProvidersModel);
}

class AllDeletedProvidersErrorState extends ProviderState {
  final String error;
  AllDeletedProvidersErrorState(this.error);
}
//***************** */

class RestoreProvidersLoadingState extends ProviderState {}

class RestoreProvidersSuccessState extends ProviderState {
  final String message;

  RestoreProvidersSuccessState(this.message);
}

class RestoreProvidersErrorState extends ProviderState {
  final String error;
  RestoreProvidersErrorState(this.error);
}
//***************** */

class ForceDeleteProvidersLoadingState extends ProviderState {}

class ForceDeleteProvidersSuccessState extends ProviderState {
  final String message;

  ForceDeleteProvidersSuccessState(this.message);
}

class ForceDeleteProvidersErrorState extends ProviderState {
  final String error;
  ForceDeleteProvidersErrorState(this.error);
}

//**************************** */
class AddProviderLoadingState extends ProviderState {}

class AddProviderSuccessState extends ProviderState {
  final String message;

  AddProviderSuccessState(this.message);
}

class AddProviderErrorState extends ProviderState {
  final String error;
  AddProviderErrorState(this.error);
} //**************************** */

class EditProviderLoadingState extends ProviderState {}

class EditProviderSuccessState extends ProviderState {
  final String message;

  EditProviderSuccessState(this.message);
}

class EditProviderErrorState extends ProviderState {
  final String error;
  EditProviderErrorState(this.error);
}
