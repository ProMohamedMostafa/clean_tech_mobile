import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/logic/cubit/work_location_details_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class QuestionTopBar extends StatelessWidget {
  final int id;
  final int selectedIndex;

  const QuestionTopBar(
      {super.key, required this.id, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkLocationDetailsCubit, WorkLocationDetailsState>(
      builder: (context, state) {
        final cubit = context.read<WorkLocationDetailsCubit>();
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
                    width: 16.w,
                    height: 16.h,
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
                            builder: (dialogContext) {
                              return PopUpMessage(
                                  title: S.of(context).TitleDelete,
                                  body: S.of(context).question,
                                  onPressed: () {
                                    if (selectedIndex == 5) {
                                      cubit.deleteQuestion(id);
                                    } else {
                                      cubit.deletePointQuestions(id);
                                    }
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
