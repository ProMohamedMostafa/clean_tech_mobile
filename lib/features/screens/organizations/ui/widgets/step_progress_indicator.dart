import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';

class StepProgressIndicator extends StatelessWidget {
  final int currentStep;
  final List<String> steps;

  const StepProgressIndicator({
    super.key,
    required this.currentStep,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(steps.length, (index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    steps[index],
                    style: TextStyle(
                      color: index < currentStep
                          ? AppColor.primaryColor
                          : AppColor.thirdColor,
                      fontWeight: index + 1 == currentStep
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  verticalSpace(15),
                  Row(
                    children: [
                      // Step Circle
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        width: 36.w,
                        height: 36.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index < currentStep
                                ? AppColor.primaryColor
                                : AppColor.thirdColor,
                            border: Border.all(color: AppColor.secondaryColor)),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      // Line Between Steps (except the last step)
                      if (index < steps.length - 1)
                        SizedBox(
                          width: 110, // Line length
                          child: Container(
                            height: 3, // Line thickness
                            margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            color: index + 1 < currentStep
                                ? AppColor.primaryColor
                                : AppColor.thirdColor,
                          ),
                        ),
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
