import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/features/screens/assign/logic/assign_state.dart';

class AssignCubit extends Cubit<AssignStates> {
  AssignCubit() : super(AssignInitialState());

  static AssignCubit get(context) => BlocProvider.of(context);
  
}
