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
      S.of(context).true_or_false,
      S.of(context).rating,
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

      // Map UI selection + rating sub-type to final typeId required by API:
      // 0 -> choose, 1 -> checkbox, 2 -> text, 3 -> true/false,
      // 4 -> rating stars, 5 -> rating emotions
      int typeId;
      if (selectedTabIndex == 0) {
        typeId = 0;
      } else if (selectedTabIndex == 1) {
        typeId = 1;
      } else if (selectedTabIndex == 2) {
        typeId = 2;
      } else if (selectedTabIndex == 3) {
        typeId = 3;
      } else {
        // selectedTabIndex == 4 => rating tab in UI
        // selectedRatingType must decide between stars (4) and emotions (5)
        typeId = (selectedRatingType == 0) ? 4 : 5;
      }

      // Add main fields
      formData.fields.add(MapEntry("text", questionController.text.trim()));
      formData.fields.add(MapEntry("type", typeId.toString()));

      // Add choices for choose, checkbox and true/false (if you want choices for true/false keep it — else remove 3)
      if (selectedTabIndex == 0 ||
          selectedTabIndex == 1 ||
          selectedTabIndex == 3) {
        for (int i = 0; i < choiceControllers.length; i++) {
          formData.fields.add(
              MapEntry("choices[$i].text", choiceControllers[i].text.trim()));

          if (choiceImages[i] != null) {
            formData.files.add(MapEntry(
              "choices[$i].image",
              await MultipartFile.fromFile(
                choiceImages[i]!.path,
                filename: choiceImages[i]!.path.split('/').last,
              ),
            ));
          }

          // icons are unused — send empty string as before
          formData.fields.add(MapEntry("choices[$i].icon", ""));
        }
      } else {
        // For rating types we don't send choices — keep behaviour unchanged
      }

      final response = await DioHelper.postData2(
        url: "questions/create",
        data: formData,
      );

      final message =
          response?.data['message'] ?? "Question created successfully";
      emit(AddQuestionSuccessState(message));
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
