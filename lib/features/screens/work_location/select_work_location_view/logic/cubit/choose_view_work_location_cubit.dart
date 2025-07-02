import 'package:bloc/bloc.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/work_location/select_work_location_view/data/model/choose_view_model.dart';

part 'choose_view_work_location_state.dart';

class ChooseViewWorkLocationCubit extends Cubit<ChooseViewWorkLocationState> {
  ChooseViewWorkLocationCubit() : super(ChooseViewWorkLocationInitial());

  ChooseViewWorkLocationModel? chooseViewWorkLocationModel;
  getWorkLocations() {
    emit(WorkLocationsDetailsLoadingState());
    DioHelper.getData(url: 'location/authorization').then((value) {
      chooseViewWorkLocationModel =
          ChooseViewWorkLocationModel.fromJson(value!.data);
      emit(WorkLocationsDetailsSuccessState(chooseViewWorkLocationModel!));
    }).catchError((error) {
      emit(WorkLocationsDetailsErrorState(error.toString()));
    });
  }
}
