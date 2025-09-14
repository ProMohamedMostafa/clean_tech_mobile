import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_text_form_field/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/questions/create_question/logic/cubit/add_question_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class ChoicesBody extends StatelessWidget {
  final int selectedTabIndex;
  const ChoicesBody({super.key, required this.selectedTabIndex});
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddQuestionCubit>();
    return BlocBuilder<AddQuestionCubit, AddQuestionState>(
      builder: (context, state) {
        if (selectedTabIndex == 0 || selectedTabIndex == 1) {
          return _buildChoicesList(cubit, context);
        } else if (selectedTabIndex == 3) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(5),
              Text(
                S.of(context).select_type_of_rating,
                style: TextStyles.font16BlackRegular,
              ),
              verticalSpace(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => cubit.changeSelectedRatingType(0),
                    child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          border: Border.all(
                            color: cubit.selectedRatingType == 0
                                ? AppColor.primaryColor
                                : Colors.grey,
                          )),
                      child: Center(
                        child: Text(
                          S.of(context).stars,
                          style: TextStyle(
                            color: cubit.selectedRatingType == 0
                                ? AppColor.primaryColor
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => cubit.changeSelectedRatingType(1),
                    child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          border: Border.all(
                            color: cubit.selectedRatingType == 1
                                ? AppColor.primaryColor
                                : Colors.grey,
                          )),
                      child: Center(
                        child: Text(
                          S.of(context).emotions,
                          style: TextStyle(
                            color: cubit.selectedRatingType == 1
                                ? AppColor.primaryColor
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildChoicesList(AddQuestionCubit cubit, BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).choices,
            style: TextStyles.font16BlackRegular,
          ),
          verticalSpace(10),
          BlocBuilder<AddQuestionCubit, AddQuestionState>(
            builder: (context, state) {
              final cubit = context.read<AddQuestionCubit>();
              return ReorderableListView.builder(
                shrinkWrap: true,
                itemCount: cubit.choiceControllers.length,
                onReorder: cubit.reorderChoices,
                itemBuilder: (context, index) {
                  final image = cubit.choiceImages[index];
                  return ListTile(
                    key: ValueKey("choice_$index"),
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.unfold_more_double_rounded,
                        color: Colors.grey),
                    title: Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(50.r),
                          onTap: () => cubit.pickChoiceImage(index),
                          child: image != null
                              ? _buildFilePreview(context, cubit, index)
                              : _buildPlaceholderImage(),
                        ),
                        horizontalSpace(8),
                        Expanded(
                          child: CustomTextFormField(
                            onlyRead: false,
                            hint: S.of(context).write,
                            controller: cubit.choiceControllers[index],
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.length > 155) {
                                return S.of(context).answer_too_long;
                              } else if (value.length < 2) {
                                return S.of(context).answer_too_short;
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    trailing: InkWell(
                      onTap: () {
                        cubit.removeChoiceField(index);
                      },
                      child:
                          Icon(Icons.close, size: 16.sp, color: Colors.black),
                    ),
                  );
                },
              );
            },
          ),
          verticalSpace(10),
          if (cubit.choiceControllers.length < 4)
            TextButton.icon(
              onPressed: cubit.addChoiceField,
              icon: Icon(Icons.add, size: 22.sp, color: AppColor.primaryColor),
              label:
                  Text(S.of(context).add_more_option, style: TextStyles.font14Primarybold),
            ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      height: 40.r,
      width: 40.r,
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: Colors.grey.shade200,
        ),
        child: Image.asset('assets/images/noImage.png', fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildFilePreview(
      BuildContext context, AddQuestionCubit cubit, int index) {
    final path = cubit.choiceImages[index]!.path;
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Scaffold(
                  appBar: AppBar(leading: const CustomBackButton()),
                  body: Center(
                    child: PhotoView(
                      imageProvider: FileImage(File(path)),
                      backgroundDecoration:
                          const BoxDecoration(color: Colors.white),
                    ),
                  ),
                ),
              ),
            );
          },
          child: Container(
            height: 40.h,
            width: 40.w,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.grey.shade200,
            ),
            child: Image.file(File(path), fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () => cubit.removeChoiceImage(index),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black54,
              ),
              child: const Icon(Icons.close, size: 12, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
