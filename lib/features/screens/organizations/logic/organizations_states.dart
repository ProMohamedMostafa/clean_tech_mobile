abstract class OrganizationsState {}

class OrganizationsInitialState extends OrganizationsState {}

class OrganizationsLoadingState extends OrganizationsState {}

class OrganizationsSuccessState extends OrganizationsState {}

class OrganizationsErrorState extends OrganizationsState {
  final String error;
  OrganizationsErrorState(this.error);
}
