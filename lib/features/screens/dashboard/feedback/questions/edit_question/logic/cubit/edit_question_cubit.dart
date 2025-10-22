import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/questions/edit_question/data/model/question_details.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

part 'edit_question_state.dart';

class EditQuestionCubit extends Cubit<EditQuestionState> {
  EditQuestionCubit() : super(EditQuestionInitial());

  final formKey = GlobalKey<FormState>();
  final questionController = TextEditingController();

  final List<TextEditingController> choiceControllers = [
    TextEditingController()
  ];
  List<bool> isSelected = [false, false, false, false, false];

  List<String> getOptions(BuildContext context) {
    return [
      S.of(context).multiple_options,
      S.of(context).checkbox,
      S.of(context).text_input,
      S.of(context).true_or_false,
      S.of(context).rating,
    ];
  }

  int selectedTabIndex = -1;
  int selectedRatingType = -1;
  final List<XFile?> choiceImages = [null];

  QuestionDetailsModel? questionDetailsModel;

  // ✅ Load question details and map typeId properly
  Future<void> getQuestionDetails(int? id) async {
    emit(QuestionDetailsLoadingState());
    try {
      final value = await DioHelper.getData(url: 'questions/$id');
      questionDetailsModel = QuestionDetailsModel.fromJson(value!.data);

      final typeId = questionDetailsModel?.data?.typeId;
      if (typeId != null) {
        _setInitialTab(typeId);
      }

      questionController.text = questionDetailsModel?.data?.text ?? "";
      _setInitialChoices();

      // ✅ Handle rating types (stars/emotions)
      if (typeId == 4 || typeId == 5) {
        selectedRatingType = (typeId == 4) ? 0 : 1;
        emit(RatingTypeChangedState(selectedRatingType));
      }

      emit(QuestionDetailsSuccessState(questionDetailsModel!));
    } catch (error) {
      emit(QuestionDetailsErrorState(error.toString()));
    }
  }

  void _setInitialChoices() {
    choiceControllers.clear();
    choiceImages.clear();

    final choices = questionDetailsModel?.data?.choices ?? [];
    if (choices.isNotEmpty) {
      for (var c in choices) {
        choiceControllers.add(TextEditingController(text: c.text ?? ""));
        choiceImages.add(c.image != null ? XFile(c.image!) : null);
      }
    } else {
      choiceControllers.add(TextEditingController());
      choiceImages.add(null);
    }
    emit(ChoicesUpdatedState());
  }

  void _setInitialTab(int typeId) {
    int index;
    if (typeId == 0) {
      index = 0;
    } else if (typeId == 1) {
      index = 1;
    } else if (typeId == 2) {
      index = 2;
    } else if (typeId == 3) {
      index = 3;
    } else {
      index = 4;
    }

    for (int i = 0; i < isSelected.length; i++) {
      isSelected[i] = (i == index);
    }
    selectedTabIndex = index;
    emit(SelectedTabChangedState(index));
  }

  void changeSelectedTab(int index) {
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

  void removeChoiceImage(int index) {
    choiceImages[index] = null;
    emit(ChoicesUpdatedState());
  }

  void addChoiceField() {
    for (int i = 0; i < choiceControllers.length; i++) {
      if (choiceControllers[i].text.trim().isEmpty && choiceImages[i] == null) {
        toast(text: "Please fill field before adding more", isSuccess: false);
        return;
      }
    }

    if (choiceControllers.length >= 4) {
      toast(text: "You can’t add more than 4 options", isSuccess: false);
      return;
    }

    choiceControllers.add(TextEditingController());
    choiceImages.add(null);
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

  Future<void> pickChoiceImage(int index) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      choiceImages[index] = pickedFile;
      emit(ChoicesUpdatedState());
    }
  }

  void removeChoiceField(int index) {
    choiceControllers.removeAt(index);
    choiceImages.removeAt(index);
    emit(ChoicesUpdatedState());
  }

  // ✅ Fully aligned edit logic with add logic
  Future<void> editQuestion(int id) async {
    emit(EditQuestionLoadingState());

    try {
      FormData formData = FormData();
      formData.fields.add(MapEntry("id", id.toString()));

      // Text
      formData.fields.add(MapEntry(
        "text",
        questionController.text.isEmpty
            ? questionDetailsModel!.data!.text!
            : questionController.text.trim(),
      ));

      // ✅ Determine typeId based on tab and rating type
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
        typeId = (selectedRatingType == 0) ? 4 : 5;
      }

      formData.fields.add(MapEntry("type", typeId.toString()));

      // ✅ Choices handling (same as add)
      if (selectedTabIndex == 0 ||
          selectedTabIndex == 1 ||
          selectedTabIndex == 3) {
        for (int i = 0; i < choiceControllers.length; i++) {
          final text = choiceControllers[i].text.trim();
          final image = choiceImages[i];
          final existingChoice = questionDetailsModel?.data?.choices?[i];
          final choiceId = existingChoice?.id;

          if (choiceId != null) {
            formData.fields
                .add(MapEntry("choices[$i].id", choiceId.toString()));
          }

          formData.fields.add(MapEntry("choices[$i].text", text));

          if (image != null) {
            if (!image.path.startsWith("http")) {
              formData.files.add(MapEntry(
                "choices[$i].image",
                await MultipartFile.fromFile(
                  image.path,
                  filename: image.path.split('/').last,
                ),
              ));
              formData.fields.add(MapEntry("choices[$i].deleteImage", "false"));
            } else {
              formData.fields.add(MapEntry("choices[$i].image", image.path));
              formData.fields.add(MapEntry("choices[$i].deleteImage", "false"));
            }
          } else {
            formData.fields.add(MapEntry("choices[$i].image", ""));
            formData.fields.add(MapEntry("choices[$i].deleteImage", "true"));
          }

          formData.fields.add(MapEntry("choices[0].icon", ""));
        }
      }

      // ✅ Rating (stars/emotions)
      if (selectedTabIndex == 4) {
        formData.fields.add(MapEntry("choices[0].text", ""));
        formData.fields.add(MapEntry("choices[0].image", ""));
        formData.fields.add(MapEntry("choices[0].icon", ""));
      }

      final response =
          await DioHelper.putData2(url: "questions/edit", data: formData);

      final message =
          response?.data['message'] ?? "Question updated successfully";
      emit(EditQuestionSuccessState(message));
    } catch (error) {
      emit(EditQuestionErrorState(error.toString()));
    }
  }
}
