import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/organizations/logic/organizations_cubit.dart';
import 'package:smart_cleaning_application/features/screens/organizations/ui/widgets/organizations_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/organizations/ui/widgets/step_progress_indicator.dart';

Widget addOrganizationBuild(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: Colors.white,
        border: Border.all(color: AppColor.primaryColor)),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StepProgressIndicator(
            currentStep: 1,
            steps: [
              'Choose Country',
              'Add Area',
              'Add City',
              'Add builiding',
              'Add Floor',
              'Add Point',
            ],
          ),
          verticalSpace(30),
          OrganizationsTextFormField(
              controller: context.read<OrganizationsCubit>().searchController,
              hintText: 'Choose Country',
              suffixIcon: Icons.arrow_forward_ios_rounded,
              keyboardType: TextInputType.text,
              readOnly: false),
          verticalSpace(20),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 40.h,
              width: 110.w,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: REdgeInsets.all(0),
                  backgroundColor: AppColor.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  side: BorderSide(
                    color: AppColor.secondaryColor,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    "Next",
                    style: TextStyles.font13Whitemedium,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}