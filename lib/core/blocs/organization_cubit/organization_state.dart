part of 'organization_cubit.dart';

class OrganizationState {
  final List<DepartmentModel> departments;
  final String organizationId;
  final bool isLoading;
  final Failure failure;
  OrganizationState({
    this.departments,
    this.organizationId,
    this.isLoading,
    this.failure,
  });
}
