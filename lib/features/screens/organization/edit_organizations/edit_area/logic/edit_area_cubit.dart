import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_area/data/model/area_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_area/data/model/edit_area_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_area/logic/edit_area_state.dart';

class EditAreaCubit extends Cubit<EditAreaState> {
  EditAreaCubit() : super(EditAreaInitialState());

  static EditAreaCubit get(context) => BlocProvider.of(context);
  TextEditingController nationalityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController managerNameController = TextEditingController();
  TextEditingController shiftsNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  EditAreaModel? editAreaModel;
  editArea(
    int? id,
  ) async {
    emit(EditAreaLoadingState());
    try {
      final response =
          await DioHelper.putData(url: ApiConstants.areaEditUrl, data: {
        "id": id,
        "name": areaController.text.isEmpty
            ? areaDetailsInEditModel!.data!.name
            : areaController.text,
        "countryName": nationalityController.text.isEmpty
            ? areaDetailsInEditModel!.data!.countryName
            : nationalityController.text,
        "managerIds": null,
        "shiftsIds": null,
      });
      editAreaModel = EditAreaModel.fromJson(response!.data);
      emit(EditAreaSuccessState(editAreaModel!));
    } catch (error) {
      emit(EditAreaErrorState(error.toString()));
    }
  }

  AreaDetailsInEditModel? areaDetailsInEditModel;
  getAreaDetailsInEdit(int id) {
    emit(GetAreaDetailsLoadingState());
    DioHelper.getData(url: 'areas/$id').then((value) {
      areaDetailsInEditModel = AreaDetailsInEditModel.fromJson(value!.data);
      emit(GetAreaDetailsSuccessState(areaDetailsInEditModel!));
    }).catchError((error) {
      emit(GetAreaDetailsErrorState(error.toString()));
    });
  }

  OrganizationNationalityModel? nationalityModel;
  getNationality() {
    emit(GetAreaNationalityLoadingState());
    DioHelper.getData(url: ApiConstants.countriesUrl).then((value) {
      nationalityModel = OrganizationNationalityModel.fromJson(value!.data);
      emit(GetAreaNationalitySuccessState(nationalityModel!));
    }).catchError((error) {
      emit(GetAreaNationalityErrorState(error.toString()));
    });
  }

  AreaModel? areaModel;
  getArea(String countryName) {
    emit(GetAreaLoadingState());
    DioHelper.getData(url: "areas/country/$countryName").then((value) {
      areaModel = AreaModel.fromJson(value!.data);
      emit(GetAreaSuccessState(areaModel!));
    }).catchError((error) {
      emit(GetAreaErrorState(error.toString()));
    });
  }
}
