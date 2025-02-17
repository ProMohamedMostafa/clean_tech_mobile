import 'package:image_picker/image_picker.dart';

abstract class TechnicalSupportState {}

class TechnicalSupportInitialState extends TechnicalSupportState {}

class TechnicalSupportLoadingState extends TechnicalSupportState {}

class TechnicalSupportSuccessState extends TechnicalSupportState {}

class TechnicalSupportErrorState extends TechnicalSupportState {
  final String error;
  TechnicalSupportErrorState(this.error);
}

//***************************** */

class ImageSelectedState extends TechnicalSupportState {
  final XFile image;
  ImageSelectedState(this.image);
}