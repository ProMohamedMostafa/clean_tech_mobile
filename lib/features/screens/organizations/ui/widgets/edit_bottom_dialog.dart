import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/features/screens/organizations/logic/organizations_cubit.dart';
import 'package:smart_cleaning_application/features/screens/organizations/ui/widgets/edit_organization_text_form_field.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class EditBottomDialog {
  void showBottomDialog(BuildContext context, OrganizationsCubit cubit) {
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, _, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: _buildDialogContent(context, cubit),
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

  Widget _buildDialogContent(BuildContext context, OrganizationsCubit cubit) {
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
              _buildDetailsField(context, cubit),
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
      'Edit Organization Details',
      style: TextStyles.font20BlacksemiBold,
    );
  }

  Widget _buildDetailsField(BuildContext context, OrganizationsCubit cubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EditOrganizationTextField(
            controller: cubit.countryController,
            obscureText: false,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).validationEmailAndUser;
              }
            },
            label: "Country",
            hint: "Egypt",
          ),
          verticalSpace(15),
          EditOrganizationTextField(
            controller: cubit.areaController,
            obscureText: false,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).validationEmailAndUser;
              }
            },
            label: "Area",
            hint: "Cairo",
          ),
          verticalSpace(15),
          EditOrganizationTextField(
            controller: cubit.cityController,
            obscureText: false,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).validationEmailAndUser;
              }
            },
            label: "City",
            hint: "NasrCity",
          ),
          verticalSpace(15),
          EditOrganizationTextField(
            controller: cubit.organizationsController,
            obscureText: false,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).validationEmailAndUser;
              }
            },
            label: "Organization",
            hint: "Ai Cloud",
          ),
          verticalSpace(15),
          EditOrganizationTextField(
            controller: cubit.buildingController,
            obscureText: false,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).validationEmailAndUser;
              }
            },
            label: "Building",
            hint: "13",
          ),
          verticalSpace(15),
          EditOrganizationTextField(
            controller: cubit.floorController,
            obscureText: false,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).validationEmailAndUser;
              }
            },
            label: "Floor",
            hint: "3",
          ),
          verticalSpace(15),
          EditOrganizationTextField(
            controller: cubit.pointController,
            obscureText: false,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).validationEmailAndUser;
              }
            },
            label: "Point",
            hint: "bathroom",
          ),
          verticalSpace(15),
        ],
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DefaultElevatedButton(
          name: "Close",
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          color: AppColor.primaryColor,
          height: 45,
          width: 150,
          textStyles: TextStyles.font20Whitesemimedium,
        ),
        DefaultElevatedButton(
          name: "Save",
          onPressed: () {},
          color: AppColor.primaryColor,
          height: 45,
          width: 150,
          textStyles: TextStyles.font20Whitesemimedium,
        ),
      ],
    );
  }
}
