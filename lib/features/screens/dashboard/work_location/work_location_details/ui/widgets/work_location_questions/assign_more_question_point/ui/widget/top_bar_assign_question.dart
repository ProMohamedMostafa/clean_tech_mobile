import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/ui/widgets/work_location_questions/assign_more_question_point/logic/cubit/assign_question_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class TopBarAssignQuestion extends StatelessWidget {
  const TopBarAssignQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AssignQuestionPointCubit>();

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
                  color: cubit.checked ? AppColor.primaryColor : Colors.white,
                ),
                child: Icon(
                  Icons.remove,
                  size: 13.w,
                  color: cubit.checked ? Colors.white : AppColor.primaryColor,
                ),
              ),
            ),
            horizontalSpace(8),
            InkWell(
              onTap: () => cubit.toggleSelectAll(),
              child: Text(S.of(context).select_all,
                  style: TextStyles.font12PrimSemi),
            ),
          ],
        ),
      ),
    );
  }
}
