import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/questions/create_question/logic/cubit/add_question_cubit.dart';

class OptionTabs extends StatelessWidget {
  const OptionTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddQuestionCubit, AddQuestionState>(
      builder: (context, state) {
        final cubit = context.read<AddQuestionCubit>();
        return Container(
          color: const Color(0xffF1F9FF),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ToggleButtons(
              isSelected: cubit.isSelected,
              onPressed: (index) {
                cubit.changeSelectedTab(index);
              },
              fillColor: Colors.transparent,
              splashColor: Colors.transparent,
              renderBorder: false,
              children:
                  List.generate(cubit.getOptions(context).length, (index) {
                return Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.r),
                      border: cubit.isSelected[index]
                          ? Border.all(color: Colors.grey[400]!, width: 0.5.w)
                          : null,
                      color: cubit.isSelected[index]
                          ? Colors.white
                          : const Color(0xffF1F9FF),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    child: Text(
                      cubit.getOptions(context)[index], 
                      style: TextStyles.font12GreyRegular
                          .copyWith(color: Colors.black),
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
