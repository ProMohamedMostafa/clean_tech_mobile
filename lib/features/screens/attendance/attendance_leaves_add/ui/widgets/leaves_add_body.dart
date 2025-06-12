import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_add/logic/leaves_add_cubit.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_add/logic/leaves_add_state.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_date_picker.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_description_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';

class LeavesAddBody extends StatefulWidget {
  const LeavesAddBody({super.key});

  @override
  State<LeavesAddBody> createState() => _LeavesAddBodyState();
}

class _LeavesAddBodyState extends State<LeavesAddBody> {
  int? typeId;
  @override
  void initState() {
    context.read<LeavesAddCubit>().getAllUsersInUserManage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Leave"),
        leading: CustomBackButton(),
      ),
      body: BlocConsumer<LeavesAddCubit, LeavesAddState>(
        listener: (context, state) {
          if (state is LeavesAddSuccessState) {
            toast(
                text: state.attendanceLeavesAddModel.message!,
                color: Colors.blue);
            context.pushNamedAndRemoveLastTwo(Routes.leavesScreen);
          }
          if (state is LeavesAddErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Form(
                  key: context.read<LeavesAddCubit>().formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Employee Name',
                        style: TextStyles.font16BlackRegular,
                      ),
                      verticalSpace(5),
                      CustomDropDownList(
                        hint: 'Select Employee',
                        onPressed: (selectedValue) {
                          final selectedId = context
                              .read<LeavesAddCubit>()
                              .usersModel
                              ?.data
                              ?.users!
                              .firstWhere((employee) =>
                                  employee.userName == selectedValue)
                              .id
                              ?.toString();

                          if (selectedId != null) {
                            context
                                .read<LeavesAddCubit>()
                                .employeeIdController
                                .text = selectedId;
                          }
                        },
                        items: context
                                    .read<LeavesAddCubit>()
                                    .usersModel
                                    ?.data
                                    ?.users
                                    ?.isEmpty ??
                                true
                            ? ['No employee available']
                            : context
                                    .read<LeavesAddCubit>()
                                    .usersModel
                                    ?.data
                                    ?.users
                                    ?.map((e) => e.userName ?? 'Unknown')
                                    .toList() ??
                                [],
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value == 'No employee available') {
                            return 'Employee name is required';
                          }
                          return null;
                        },
                        controller:
                            context.read<LeavesAddCubit>().employeeController,
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                      verticalSpace(10),
                      Text(
                        'Type',
                        style: TextStyles.font16BlackRegular,
                      ),
                      verticalSpace(5),
                      CustomDropDownList(
                        onPressed: (selectedValue) {
                          final items = ['Sick', 'Annual', 'Ordinary'];
                          final selectedIndex = items.indexOf(selectedValue);
                          if (selectedIndex != -1) {
                            typeId = selectedIndex;
                          }
                        },
                        hint: 'Select type',
                        items: ['Sick', 'Annual', 'Ordinary'],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Type is required';
                          }
                          return null;
                        },
                        controller:
                            context.read<LeavesAddCubit>().typeController,
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                      verticalSpace(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Start Date",
                                style: TextStyles.font16BlackRegular,
                              ),
                              verticalSpace(5),
                              CustomTextFormField(
                                onlyRead: true,
                                hint: "--/--/---",
                                controller: context
                                    .read<LeavesAddCubit>()
                                    .startDateController,
                                suffixIcon: Icons.calendar_today,
                                suffixPressed: () async {
                                  final selectedDate =
                                      await CustomDatePicker.show(
                                          context: context);

                                  if (selectedDate != null && context.mounted) {
                                    context
                                        .read<LeavesAddCubit>()
                                        .startDateController
                                        .text = selectedDate;
                                  }
                                },
                                keyboardType: TextInputType.none,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Start Date is required';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          )),
                          horizontalSpace(10),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "End Date",
                                style: TextStyles.font16BlackRegular,
                              ),
                              verticalSpace(5),
                              CustomTextFormField(
                                onlyRead: true,
                                hint: "--/--/---",
                                controller: context
                                    .read<LeavesAddCubit>()
                                    .endDateController,
                                suffixIcon: Icons.calendar_today,
                                suffixPressed: () async {
                                  final selectedDate =
                                      await CustomDatePicker.show(
                                          context: context);

                                  if (selectedDate != null && context.mounted) {
                                    context
                                        .read<LeavesAddCubit>()
                                        .endDateController
                                        .text = selectedDate;
                                  }
                                },
                                keyboardType: TextInputType.none,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'End Date is required';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          )),
                        ],
                      ),
                      verticalSpace(10),
                      Text(
                        "Reason",
                        style: TextStyles.font16BlackRegular,
                      ),
                      verticalSpace(5),
                      CustomDescriptionTextFormField(
                        controller: context
                            .read<LeavesAddCubit>()
                            .discriptionController,
                        hint: 'Write the reason for the leave.',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Reason is required';
                          }
                          return null;
                        },
                      ),
                      verticalSpace(10),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<LeavesAddCubit>().galleryFile();
                          },
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(10),
                              backgroundColor: AppColor.primaryColor,
                              elevation: 4),
                          child: const Icon(IconBroken.upload,
                              color: Colors.white, size: 26),
                        ),
                      ),
                      verticalSpace(8),
                      Center(
                        child: Text(
                          'Upload file',
                          style: TextStyles.font14BlackSemiBold,
                        ),
                      ),
                      verticalSpace(20),
                      if (state is ImageSelectedState) ...[
                        Text(
                          "File",
                          style: TextStyles.font16BlackRegular,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (contextt) => Scaffold(
                                    appBar: AppBar(
                                      leading: CustomBackButton(),
                                    ),
                                    body: Center(
                                      child: PhotoView(
                                        imageProvider: FileImage(
                                          File(context
                                              .read<LeavesAddCubit>()
                                              .image!
                                              .path),
                                        ),
                                        backgroundDecoration:
                                            const BoxDecoration(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 80,
                              width: 80,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Image.file(
                                File(
                                    context.read<LeavesAddCubit>().image!.path),
                                fit: BoxFit.cover,
                              ),
                            )),
                      ],
                      verticalSpace(20),
                      state is LeavesAddLoadingState
                          ? Loading()
                          : Center(
                              child: DefaultElevatedButton(
                                  name: 'Create',
                                  onPressed: () {
                                    if (context
                                        .read<LeavesAddCubit>()
                                        .formKey
                                        .currentState!
                                        .validate()) {
                                      context
                                          .read<LeavesAddCubit>()
                                          .createLeaves(
                                              context
                                                  .read<LeavesAddCubit>()
                                                  .image
                                                  ?.path,
                                              typeId!);
                                    }
                                  },
                                  color: AppColor.primaryColor,
                                  height: 47,
                                  width: double.infinity,
                                  textStyles: TextStyles.font20Whitesemimedium),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
