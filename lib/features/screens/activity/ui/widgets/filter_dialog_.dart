import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/filter_top_widget/filter_top_widget.dart';
import 'package:smart_cleaning_application/features/screens/activity/logic/activity_cubit.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_date_picker.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';

class CustomFilterActivityDialog {
  static const Map<String, List<String>> moduleActions = {
    'Provider': ['Create', 'Edit', 'Delete', 'Restore', 'ForceDelete'],
    'User': [
      'Create',
      'Edit',
      'Delete',
      'Restore',
      'ForceDelete',
      'Login',
      'Logout',
      'ClockIn',
      'ClockOut',
      'ChangePassword',
      'EditProfile',
      'Assign',
      'RemoveAssign',
      'EditSetting'
    ],
    'UserSetting': ['EditSetting'],
    'Area': [
      'Create',
      'Edit',
      'Delete',
      'Restore',
      'ForceDelete',
      'Assign',
      'RemoveAssign'
    ],
    'City': [
      'Create',
      'Edit',
      'Delete',
      'Restore',
      'ForceDelete',
      'Assign',
      'RemoveAssign'
    ],
    'Organization': [
      'Create',
      'Edit',
      'Delete',
      'Restore',
      'ForceDelete',
      'Assign',
      'RemoveAssign'
    ],
    'Building': [
      'Create',
      'Edit',
      'Delete',
      'Restore',
      'ForceDelete',
      'Assign',
      'RemoveAssign'
    ],
    'Floor': [
      'Create',
      'Edit',
      'Delete',
      'Restore',
      'ForceDelete',
      'Assign',
      'RemoveAssign'
    ],
    'Section': [
      'Create',
      'Edit',
      'Delete',
      'Restore',
      'ForceDelete',
      'Assign',
      'RemoveAssign'
    ],
    'Point': [
      'Create',
      'Edit',
      'Delete',
      'Restore',
      'ForceDelete',
      'Assign',
      'RemoveAssign'
    ],
    'Task': [
      'Create',
      'Edit',
      'Delete',
      'Restore',
      'ForceDelete',
      'ChangeStatus',
      'Comment'
    ],
    'Shift': [
      'Create',
      'Edit',
      'Delete',
      'Restore',
      'ForceDelete',
      'Assign',
      'RemoveAssign'
    ],
    'Attendacne': ['ClockIn', 'ClockOut'],
    'Leave': ['Create', 'Edit', 'Delete'],
    'Category': ['Create', 'Edit', 'Delete', 'Restore', 'ForceDelete'],
    'Material': ['Create', 'Edit', 'Delete', 'Restore', 'ForceDelete'],
    'Stock': ['StockIn', 'StockOut'],
  };

  static final List<String> allModules = moduleActions.keys.toList();
  static final List<String> allActions =
      moduleActions.values.expand((actions) => actions).toSet().toList();
  static Future<String?> show({
    required BuildContext context,
  }) async {
    return await showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            insetPadding: EdgeInsets.all(20),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.r)),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildHeader(context),
                      verticalSpace(10),
                      Text(
                        "Module",
                        style: TextStyles.font16BlackRegular,
                      ),
                      verticalSpace(5),
                      CustomDropDownList(
                        onPressed: (selectedValue) {
                          final selectedIndex =
                              allModules.indexOf(selectedValue);
                          if (selectedIndex != -1) {
                            context.read<ActivityCubit>()
                              ..moduleIdController.text =
                                  selectedIndex.toString()
                              ..moduleController.text = selectedValue
                              ..actionController.text = ''
                              ..actionIdController.text = '';
                          }
                        },
                        hint: 'Select module',
                        items: allModules,
                        controller:
                            context.read<ActivityCubit>().moduleController,
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                      verticalSpace(10),
                      Text(
                        "Action",
                        style: TextStyles.font16BlackRegular,
                      ),
                      verticalSpace(5),
                      CustomDropDownList(
                        onPressed: (selectedValue) {
                          final selectedIndex =
                              allActions.indexOf(selectedValue);
                          if (selectedIndex != -1) {
                            context
                                .read<ActivityCubit>()
                                .actionIdController
                                .text = selectedIndex.toString();
                          }
                        },
                        hint: 'Select action',
                        items: moduleActions[context
                                .read<ActivityCubit>()
                                .moduleController
                                .text] ??
                            [],
                        controller:
                            context.read<ActivityCubit>().actionController,
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                      verticalSpace(10),
                      Text(
                        "Role",
                        style: TextStyles.font16BlackRegular,
                      ),
                      verticalSpace(5),
                      CustomDropDownList(
                        onPressed: (selectedValue) {
                          final selectedId = context
                              .read<ActivityCubit>()
                              .roleModel
                              ?.data
                              ?.firstWhere(
                                (role) => role.name == selectedValue,
                              )
                              .id
                              ?.toString();

                          if (selectedId != null) {
                            context
                                .read<ActivityCubit>()
                                .roleIdController
                                .text = selectedId;
                          }
                        },
                        hint: 'Select Role',
                        items: context
                                    .read<ActivityCubit>()
                                    .roleModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No roles available']
                            : context
                                    .read<ActivityCubit>()
                                    .roleModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        controller:
                            context.read<ActivityCubit>().roleController,
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                      verticalSpace(10),
                      Text(
                        "Date",
                        style: TextStyles.font16BlackRegular,
                      ),
                      verticalSpace(5),
                      CustomTextFormField(
                        onlyRead: true,
                        hint: "--/--/---",
                        controller:
                            context.read<ActivityCubit>().dateController,
                        suffixIcon: Icons.calendar_today,
                        suffixPressed: () async {
                          final selectedDate =
                              await CustomDatePicker.show(context: context);

                          if (selectedDate != null && context.mounted) {
                            context.read<ActivityCubit>().dateController.text =
                                selectedDate;
                          }
                        },
                        keyboardType: TextInputType.none,
                      ),
                      verticalSpace(20),
                      Center(
                        child: DefaultElevatedButton(
                            name: 'Done',
                            onPressed: () {
                              context.read<ActivityCubit>().getMyActivities();
                              context.read<ActivityCubit>().getTeamActivities();
                              context.pop();
                            },
                            color: AppColor.primaryColor,
                            height: 47,
                            width: double.infinity,
                            textStyles: TextStyles.font20Whitesemimedium),
                      ),
                      verticalSpace(10),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
