import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/features/screens/analytics/ui/widgets/row_organization_details_build.dart';

class DetailsBottomDialog {
  void showBottomDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: true,
      barrierColor: Colors.black12,
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, _, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: _buildDialogContent(context),
        );
      },
      transitionBuilder: (_, animation1, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(animation1),
          child: child,
        );
      },
    );
  }

  Widget _buildDialogContent(context) {
    return IntrinsicHeight(
      child: Container(
        width: double.maxFinite,
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(16.r),
          ),
        ),
        child: Material(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Divider(
                indent: 110,
                endIndent: 110,
                color: AppColor.primaryColor,
                height: 0,
                thickness: 3,
              ),
              verticalSpace(8),
              _buildContinueText(),
              verticalSpace(8),
              _buildDetailsField(context),
              verticalSpace(16),
              _buildContinueButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContinueText() {
    return Text(
      'Organization Details',
      style: TextStyles.font20BlacksemiBold,
    );
  }

  Widget _buildDetailsField(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Divider(),
          ),
          rowOrganizationDetailsBuild(context, 'Country', 'Egypt'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Divider(),
          ),
          rowOrganizationDetailsBuild(context, 'Area', 'Cairo'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Divider(),
          ),
          rowOrganizationDetailsBuild(context, 'City', 'NasrCity'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Divider(),
          ),
          rowOrganizationDetailsBuild(context, 'Organization', 'Ai Cloud'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Divider(),
          ),
          rowOrganizationDetailsBuild(context, 'Building', '13'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Divider(),
          ),
          rowOrganizationDetailsBuild(context, 'Floor', '3'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Divider(),
          ),
          rowOrganizationDetailsBuild(context, 'Point', 'bathRoom'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Divider(),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton(context) {
    return DefaultElevatedButton(
        name: "Close",
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
        },
        color: AppColor.primaryColor,
        height: 45,
        width: double.infinity,
        textStyles: TextStyles.font20Whitesemimedium);
  }
}
