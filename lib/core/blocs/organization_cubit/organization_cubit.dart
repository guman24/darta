import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:sifaris_app/core/data/models/department_model.dart';
import 'package:sifaris_app/core/domain/usecases/organization_usecase.dart';
import 'package:sifaris_app/core/error/failure.dart';

part 'organization_state.dart';

class OrganizationCubit extends Cubit<OrganizationState> {
  final OrganizationUseCase organizationUseCase;

  OrganizationCubit({@required this.organizationUseCase})
      : assert(organizationUseCase != null),
        super(OrganizationState(
          isLoading: true,
          organizationId: null,
          departments: null,
          failure: null,
        ));

  void loadDepartments() async {
    final failOrOrganization = await organizationUseCase(null);
    failOrOrganization.fold(
        (fail) => emit(OrganizationState(
            isLoading: false,
            failure: fail,
            organizationId: null,
            departments: null)), (organization) {
      List<DepartmentModel> departments = [];
      departments = organization[0].departments;
      emit(OrganizationState(
        isLoading: false,
        departments: departments,
        organizationId: organization[0].id,
        failure: null,
      ));
    });
  }
}
