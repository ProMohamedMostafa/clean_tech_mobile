import 'package:bloc/bloc.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/data/model/delete_material_model.dart';
import 'package:smart_cleaning_application/features/screens/stock/view_material/data/model/material_details_model.dart';

part 'material_details_state.dart';

class MaterialDetailsCubit extends Cubit<MaterialDetailsState> {
  MaterialDetailsCubit() : super(MaterialDetailsInitial());

  bool descTextShowFlag = false;

  MaterialDetailsModel? materialDetailsModel;
  getMaterialDetails(int id) {
    emit(MaterialDetailsLoadingState());
    DioHelper.getData(url: 'materials/$id').then((value) {
      materialDetailsModel = MaterialDetailsModel.fromJson(value!.data);
      emit(MaterialDetailsSuccessState(materialDetailsModel!));
    }).catchError((error) {
      emit(MaterialDetailsErrorState(error.toString()));
    });
  }

  DeleteMaterialModel? deleteMaterialModel;
  deleteMaterial(int id) {
    emit(DeleteMaterialLoadingState());
    DioHelper.postData(url: 'materials/delete/$id').then((value) {
      deleteMaterialModel = DeleteMaterialModel.fromJson(value!.data);

      emit(DeleteMaterialSuccessState(deleteMaterialModel!));
    }).catchError((error) {
      emit(DeleteMaterialErrorState(error.toString()));
    });
  }
    void toggleDescText() {
  descTextShowFlag = !descTextShowFlag;
  emit(DescToggleState());
}

Future<void> refreshMaterials({int? id}) async {
    materialDetailsModel = null;
    emit(MaterialDetailsLoadingState());
    await getMaterialDetails(id!);
  }
}
