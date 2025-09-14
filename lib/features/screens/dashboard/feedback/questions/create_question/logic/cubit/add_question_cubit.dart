import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

part 'add_question_state.dart';

class AddQuestionCubit extends Cubit<AddQuestionState> {
  AddQuestionCubit() : super(AddQuestionInitial());

  final formKey = GlobalKey<FormState>();
  final questionController = TextEditingController();

  final List<TextEditingController> choiceControllers = [
    TextEditingController()
  ];
  List<bool> isSelected = [true, false, false, false, false];
  
 List<String> getOptions(BuildContext context) {
    return [
      S.of(context).multiple_options,
      S.of(context).checkbox,
      S.of(context).text_input,
      S.of(context).rating,
      S.of(context).true_or_false,
    ];
  }

  int selectedTabIndex = 0;
  int selectedRatingType = -1;
  final List<XFile?> choiceImages = [null];

  void changeSelectedTab(int index) {
    questionController.clear();
    choiceControllers.clear();
    choiceImages.clear();
    choiceControllers.add(TextEditingController());
    choiceImages.add(null);
    selectedRatingType = -1;

    for (int i = 0; i < isSelected.length; i++) {
      isSelected[i] = (i == index);
    }
    selectedTabIndex = index;
    emit(SelectedTabChangedState(index));
  }

  void changeSelectedRatingType(int index) {
    selectedRatingType = index;
    emit(RatingTypeChangedState(index));
  }

  Future<void> addQuestion() async {
    emit(AddQuestionLoadingState());

    try {
      FormData formData = FormData();

      // Add basic fields
      formData.fields.add(MapEntry("text", questionController.text.trim()));
      formData.fields.add(MapEntry("type", selectedTabIndex.toString()));

      // Add choices
      if (selectedTabIndex == 0 || selectedTabIndex == 1) {
        for (int i = 0; i < choiceControllers.length; i++) {
          // Add choice text
          formData.fields.add(
              MapEntry("choices[$i].text", choiceControllers[i].text.trim()));

          // Add choice image if exists
          if (choiceImages[i] != null) {
            formData.files.add(MapEntry(
              "choices[$i].image",
              await MultipartFile.fromFile(
                choiceImages[i]!.path,
                filename: choiceImages[i]!.path.split('/').last,
              ),
            ));
          }

          // Add empty icon (since we're not using it)
          formData.fields.add(MapEntry("choices[$i].icon", ""));
        }
      } else if (selectedTabIndex == 3) {
        // For rating type
        formData.fields.add(MapEntry("choices[0].text", ""));
        formData.fields.add(MapEntry("choices[0].image", ""));
        formData.fields
            .add(MapEntry("choices[0].icon", selectedRatingType.toString()));
      }

      DioHelper.postData2(
        url: "questions/create",
        data: formData,
      ).then((value) {
        final message =
            value?.data['message'] ?? "Question created successfully";
        emit(AddQuestionSuccessState(message));
      });
    } catch (error) {
      emit(AddQuestionErrorState(error.toString()));
    }
  }

  void addChoiceField() {
    for (int i = 0; i < choiceControllers.length; i++) {
      if (choiceControllers[i].text.trim().isEmpty && choiceImages[i] == null) {
        toast(text: "Please fill field before adding more", isSuccess: false);
        return;
      }
    }

    choiceControllers.add(TextEditingController());
    choiceImages.add(null);
    emit(ChoicesUpdatedState());
  }

  void removeChoiceField(int index) {
    choiceControllers.removeAt(index);
    choiceImages.removeAt(index);
    emit(ChoicesUpdatedState());
  }

  Future<void> pickChoiceImage(int index) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      choiceImages[index] = pickedFile;
      emit(ChoicesUpdatedState());
    }
  }

  void removeChoiceImage(int index) {
    choiceImages[index] = null;
    emit(ChoicesUpdatedState());
  }

  void reorderChoices(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    final textItem = choiceControllers.removeAt(oldIndex);
    final imageItem = choiceImages.removeAt(oldIndex);

    choiceControllers.insert(newIndex, textItem);
    choiceImages.insert(newIndex, imageItem);

    emit(ChoicesUpdatedState());
  }

  void clearAllFields() {
    questionController.clear();
    selectedTabIndex = 0;
    selectedRatingType = -1;
    isSelected = [true, false, false, false, false];
    choiceControllers.clear();
    choiceImages.clear();
    choiceControllers.add(TextEditingController());
    choiceImages.add(null);
    emit(ChoicesUpdatedState());
  }
  
}
