import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/user_details/data/model/user_model.dart';
import 'package:smart_cleaning_application/features/screens/user_details/logic/user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState());

  static UserCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  getUserDetails() {
    emit(UserLoadingState());
    DioHelper.getData(url: 'users/1').then((value) {
      userModel = UserModel.fromJson(value!.data);
      emit(UserSuccessState(userModel!));
    }).catchError((error) {
      emit(UserErrorState(error.toString()));
    });
  }
}
