import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/data/models/attendance_history_model.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_state.dart';
import 'package:smart_cleaning_application/features/screens/settings/data/model/profile_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  ProfileModel? profileModel;
  getUserDetails() {
    emit(UserDetailsLoadingState());
    DioHelper.getData(url: 'auth/profile').then((value) {
      profileModel = ProfileModel.fromJson(value!.data);
      emit(UserDetailsSuccessState(profileModel!));
    }).catchError((error) {
      emit(UserDetailsErrorState(error.toString()));
    });
  }

  clockInOut() {
    emit(ClockInOutLoadingState());
    DioHelper.postData(url: 'attendance/clock').then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(ClockInOutSuccessState(message!));
    }).catchError((error) {
      emit(ClockInOutErrorState(error.toString()));
    });
  }

  AttendanceHistoryModel? attendanceHistoryModel;
  getUserStatus() {
    emit(UserStatusLoadingState());
    DioHelper.getData(url: 'attendance/history', query: {'history': true})
        .then((value) {
      attendanceHistoryModel = AttendanceHistoryModel.fromJson(value!.data);
      emit(UserStatusSuccessState(attendanceHistoryModel!));
    }).catchError((error) {
      emit(UserStatusErrorState(error.toString()));
    });
  }
}
