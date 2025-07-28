import 'package:bloc/bloc.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/shifts_management/data/model/delete_shift_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/shift_details/data/models/shift_details_model.dart';

part 'shift_details_state.dart';

class ShiftDetailsCubit extends Cubit<ShiftDetailsState> {
  ShiftDetailsCubit() : super(ShiftDetailsInitial());

  ShiftDetailsModel? shiftDetailsModel;
  getShiftDetails(int? id) {
    emit(ShiftDetailsLoadingState());
    DioHelper.getData(url: 'shifts/$id').then((value) {
      shiftDetailsModel = ShiftDetailsModel.fromJson(value!.data);
      emit(ShiftDetailsSuccessState(shiftDetailsModel!));
    }).catchError((error) {
      emit(ShiftDetailsErrorState(error.toString()));
    });
  }

  DeleteShiftModel? deleteShiftModel;
  shiftDelete(int id) {
    emit(ShiftDeleteLoadingState());
    DioHelper.postData(url: 'shifts/delete/$id')
        .then((value) {
      deleteShiftModel = DeleteShiftModel.fromJson(value!.data);
      emit(ShiftDeleteSuccessState(deleteShiftModel!));
    }).catchError((error) {
      emit(ShiftDeleteErrorState(error.toString()));
    });
  }
}
