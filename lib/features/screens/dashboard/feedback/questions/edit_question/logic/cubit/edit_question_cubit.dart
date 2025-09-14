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
      S.of(context).rating,
      S.of(context).true_or_false,
    ];
  }
  int selectedTabIndex = -1;
  int selectedRatingType = -1;
  final List<XFile?> choiceImages = [null];

  QuestionDetailsModel? questionDetailsModel;
  getQuestionDetails(int? id) {
    emit(QuestionDetailsLoadingState());
    DioHelper.getData(url: 'questions/$id').then((value) {
      questionDetailsModel = QuestionDetailsModel.fromJson(value!.data);

      final typeId = questionDetailsModel?.data?.typeId;
      if (typeId != null) {
        _setInitialTab(typeId);
      }

      // fill question text
      questionController.text = questionDetailsModel?.data?.text ?? "";

      // hydrate choices
      _setInitialChoices();

      if (typeId == 3) {
        // Rating question
        final icon = questionDetailsModel?.data?.choices?.first.icon;
        if (icon != null && icon.isNotEmpty) {
          selectedRatingType = int.tryParse(icon) ?? -1;
          emit(RatingTypeChangedState(selectedRatingType));
        }
      }
      emit(QuestionDetailsSuccessState(questionDetailsModel!));
    }).catchError((error) {
      emit(QuestionDetailsErrorState(error.toString()));
    });
  }

  void _setInitialChoices() {
    choiceControllers.clear();
    choiceImages.clear();

    final choices = questionDetailsModel?.data?.choices ?? [];
    if (choices.isNotEmpty) {
      for (var c in choices) {
        choiceControllers.add(TextEditingController(text: c.text ?? ""));
        // store image url as "string" instead of XFile
        choiceImages.add(c.image != null ? XFile(c.image!) : null);
      }
    } else {
      // keep at least one empty field
      choiceControllers.add(TextEditingController());
      choiceImages.add(null);
    }

    emit(ChoicesUpdatedState());
  }

  void _setInitialTab(int typeId) {
    for (int i = 0; i < isSelected.length; i++) {
      isSelected[i] = (i == typeId);
    }
    selectedTabIndex = typeId;
    emit(SelectedTabChangedState(typeId));
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

  void changeSelectedRatingType(int index) {
    selectedRatingType = index;
    emit(RatingTypeChangedState(index));
  }

  Future<void> editQuestion(int id) async {
    emit(EditQuestionLoadingState());

    try {
      FormData formData = FormData();

      // Add question ID
      formData.fields.add(MapEntry("id", id.toString()));

      // Add question text (fallback to old if empty)
      formData.fields.add(MapEntry(
        "text",
        questionController.text.isEmpty
            ? questionDetailsModel!.data!.text!
            : questionController.text,
      ));

      // Add question type
      formData.fields.add(MapEntry(
        "type",
        selectedTabIndex == -1
            ? questionDetailsModel!.data!.typeId.toString()
            : selectedTabIndex.toString(),
      ));

      // Handle choices (similar to addQuestion)
      if (selectedTabIndex == 0 || selectedTabIndex == 1) {
        for (int i = 0; i < choiceControllers.length; i++) {
          final text = choiceControllers[i].text.trim();
          final image = choiceImages[i];

          // Add choice ID (if available from API)
          final existingChoice = questionDetailsModel?.data?.choices?[i];
          final choiceId =
              existingChoice?.id; // add `id` in Choices model if missing
          if (choiceId != null) {
            formData.fields
                .add(MapEntry("choices[$i].id", choiceId.toString()));
          }

          // Add choice text
          formData.fields.add(MapEntry("choices[$i].text", text));

          // Handle image state
          if (image != null) {
            if (!image.path.startsWith("http")) {
              // New uploaded image -> replace
              formData.files.add(MapEntry(
                "choices[$i].image",
                await MultipartFile.fromFile(
                  image.path,
                  filename: image.path.split('/').last,
                ),
              ));
              formData.fields.add(MapEntry("choices[$i].deleteImage", "false"));
            } else {
              // Keep old image
              formData.fields.add(MapEntry("choices[$i].image", image.path));
              formData.fields.add(MapEntry("choices[$i].deleteImage", "false"));
            }
          } else {
            // No image -> delete existing
            formData.fields.add(MapEntry("choices[$i].image", ""));
            formData.fields.add(MapEntry("choices[$i].deleteImage", "true"));
          }

          // Icon (can be left empty)
          formData.fields.add(MapEntry("choices[$i].icon", ""));
        }
      } else if (selectedTabIndex == 3) {
        // For rating type
        formData.fields.add(MapEntry("choices[0].text", ""));
        formData.fields.add(MapEntry("choices[0].image", ""));
        formData.fields
            .add(MapEntry("choices[0].icon", selectedRatingType.toString()));
      }

      // Call API
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
