import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/custom_multi_dropdown/custom_multi_dropdown.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/questions/question_mangement/logic/question_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/edit_task/data/models/section_basic_model.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionCubit, QuestionState>(
      builder: (context, state) {
        final cubit = context.read<QuestionCubit>();
        final hasSelected = cubit.selectedItems.contains(true);

        return Container(
          height: 48.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xffF1F9FF),
            border: Border.symmetric(
              horizontal: BorderSide(color: Colors.grey[300]!),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => cubit.toggleSelectAll(),
                  child: Container(
                    width: 20.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(color: AppColor.primaryColor),
                      color:
                          cubit.checked ? AppColor.primaryColor : Colors.white,
                    ),
                    child: Icon(
                      Icons.remove,
                      size: 13.w,
                      color:
                          cubit.checked ? Colors.white : AppColor.primaryColor,
                    ),
                  ),
                ),
                horizontalSpace(8),
                InkWell(
                  onTap: () => cubit.toggleSelectAll(),
                  child: Text(S.of(context).select_all,
                      style: TextStyles.font12PrimSemi),
                ),
                const Spacer(),
                Opacity(
                  opacity: hasSelected ? 1.0 : 0.4,
                  child: IgnorePointer(
                    ignoring: !hasSelected,
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                                insetPadding: EdgeInsets.all(20),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 8.w,
                                            height: 24.h,
                                            decoration: BoxDecoration(
                                                color: AppColor.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(2.r)),
                                          ),
                                          horizontalSpace(8),
                                          Text(S.of(context).assignButton,
                                              style:
                                                  TextStyles.font18BlackMedium),
                                          const Spacer(),
                                          IconButton(
                                            icon: Icon(
                                              Icons.close_rounded,
                                              size: 26.sp,
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ],
                                      ),
                                      verticalSpace(10),
                                      Text(
                                        S.of(context).sections,
                                        style: TextStyles.font14BlackMedium,
                                      ),
                                      verticalSpace(5),
                                      Form(
                                        key: cubit.formKey,
                                        child: CustomMultiDropdown<SectionData>(
                                          hint: S.of(context).selectSection,
                                          controller:
                                              cubit.allSectionsController,
                                          items: cubit.sectionModel!.data!
                                              .map((e) =>
                                                  DropdownItem<SectionData>(
                                                    value: e,
                                                    label: e.name ?? 'Unknown',
                                                  ))
                                              .toList(),
                                          onSelectionChange: (selectedItems) {
                                            cubit.selectedSectionsIds =
                                                selectedItems
                                                    .map((item) => item.id!)
                                                    .toList();
                                          },
                                        ),
                                      ),
                                      verticalSpace(25),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: DefaultElevatedButton(
                                                name: S.of(context).addButton,
                                                textStyles: TextStyles
                                                    .font16WhiteSemiBold,
                                                onPressed: () {
                                                  {
                                                    if (cubit.formKey
                                                            .currentState
                                                            ?.validate() ??
                                                        false) {
                                                      cubit.assignQuestion();
                                                      context.pop();
                                                    }
                                                  }
                                                },
                                                color: AppColor.primaryColor,
                                                width: double.infinity),
                                          ),
                                          horizontalSpace(16),
                                          Expanded(
                                            child: DefaultElevatedButton(
                                                name:
                                                    S.of(context).cancelButton,
                                                textStyles: TextStyles
                                                    .font16PrimSemiBold,
                                                onPressed: () {
                                                  context.pop();
                                                },
                                                color: AppColor.fourthColor,
                                                width: double.infinity),
                                          ),
                                        ],
                                      ),
                                      verticalSpace(5),
                                    ],
                                  ),
                                ));
                          },
                        );
                      },
                      borderRadius: BorderRadius.circular(4.r),
                      child: Container(
                        height: 32.h,
                        width: 82,
                        decoration: BoxDecoration(
                          color: const Color(0xff49B848),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, size: 16.sp, color: Colors.white),
                            horizontalSpace(7),
                            Text(S.of(context).assignButton,
                                style: TextStyles.font11WhiteSemiBold),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                horizontalSpace(10),
                Opacity(
                  opacity: hasSelected ? 1.0 : 0.4,
                  child: IgnorePointer(
                    ignoring: !hasSelected,
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return PopUpMessage(
                                  title: S.of(context).TitleDelete,
                                  body: S.of(context).question,
                                  onPressed: () {
                                    cubit.deleteQuestion();
                                  });
                            });
                      },
                      borderRadius: BorderRadius.circular(4.r),
                      child: Container(
                        height: 32.h,
                        width: 82,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconBroken.delete,
                                size: 16.sp, color: Colors.white),
                            horizontalSpace(7),
                            Text(S.of(context).deleteButton,
                                style: TextStyles.font11WhiteSemiBold),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
