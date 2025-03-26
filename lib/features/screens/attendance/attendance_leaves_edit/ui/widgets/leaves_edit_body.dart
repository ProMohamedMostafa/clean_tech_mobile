import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_edit/logic/leaves_edit_cubit.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_edit/logic/leaves_edit_state.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_date_picker.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_description_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';

class LeavesEditBody extends StatefulWidget {
  final int id;
  const LeavesEditBody({super.key, required this.id});

  @override
  State<LeavesEditBody> createState() => _LeavesEditBodyState();
}

class _LeavesEditBodyState extends State<LeavesEditBody> {
  int? typeId;
  @override
  void initState() {
    context.read<LeavesEditCubit>().getLeavesDetails(widget.id);
    context.read<LeavesEditCubit>().getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
        leading: customBackButton(context),
      ),
      body: BlocConsumer<LeavesEditCubit, LeavesEditState>(
        listener: (context, state) {
          if (state is LeavesEditSuccessState) {
            toast(
                text: state.attendanceLeavesEditModel.message!,
                color: Colors.blue);
            context.pushNamedAndRemoveLastTwo(Routes.leavesScreen);
          }
          if (state is LeavesEditErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          if (context.read<LeavesEditCubit>().leavesDetailsModel == null) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColor.primaryColor,
              ),
            );
          }
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Form(
                  key: context.read<LeavesEditCubit>().formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Employee Name',
                        style: TextStyles.font16BlackRegular,
                      ),
                      verticalSpace(5),
                      CustomDropDownList(
                        hint: context
                            .read<LeavesEditCubit>()
                            .leavesDetailsModel!
                            .data!
                            .userName!,
                        onPressed: (selectedValue) {
                          final selectedId = context
                              .read<LeavesEditCubit>()
                              .usersModel
                              ?.data
                              ?.users!
                              .firstWhere((employee) =>
                                  employee.userName == selectedValue)
                              .id
                              ?.toString();

                          if (selectedId != null) {
                            context
                                .read<LeavesEditCubit>()
                                .employeeIdController
                                .text = selectedId;
                          }
                        },
                        items: context
                                    .read<LeavesEditCubit>()
                                    .usersModel
                                    ?.data
                                    ?.users
                                    ?.isEmpty ??
                                true
                            ? ['No employee available']
                            : context
                                    .read<LeavesEditCubit>()
                                    .usersModel
                                    ?.data
                                    ?.users
                                    ?.map((e) => e.userName ?? 'Unknown')
                                    .toList() ??
                                [],
                        controller:
                            context.read<LeavesEditCubit>().employeeController,
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
                        hint: context
                            .read<LeavesEditCubit>()
                            .leavesDetailsModel!
                            .data!
                            .type!,
                        items: ['Sick', 'Annual', 'Ordinary'],
                        controller:
                            context.read<LeavesEditCubit>().typeController,
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
                                hint: context
                                    .read<LeavesEditCubit>()
                                    .leavesDetailsModel!
                                    .data!
                                    .startDate!,
                                controller: context
                                    .read<LeavesEditCubit>()
                                    .startDateController,
                                suffixIcon: Icons.calendar_today,
                                suffixPressed: () async {
                                  final selectedDate =
                                      await CustomDatePicker.show(
                                          context: context);

                                  if (selectedDate != null && context.mounted) {
                                    context
                                        .read<LeavesEditCubit>()
                                        .startDateController
                                        .text = selectedDate;
                                  }
                                },
                                keyboardType: TextInputType.none,
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
                                hint: context
                                    .read<LeavesEditCubit>()
                                    .leavesDetailsModel!
                                    .data!
                                    .endDate!,
                                controller: context
                                    .read<LeavesEditCubit>()
                                    .endDateController,
                                suffixIcon: Icons.calendar_today,
                                suffixPressed: () async {
                                  final selectedDate =
                                      await CustomDatePicker.show(
                                          context: context);

                                  if (selectedDate != null && context.mounted) {
                                    context
                                        .read<LeavesEditCubit>()
                                        .endDateController
                                        .text = selectedDate;
                                  }
                                },
                                keyboardType: TextInputType.none,
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
                            .read<LeavesEditCubit>()
                            .discriptionController
                          ..text = context
                              .read<LeavesEditCubit>()
                              .leavesDetailsModel!
                              .data!
                              .reason!,
                        hint: context
                            .read<LeavesEditCubit>()
                            .leavesDetailsModel!
                            .data!
                            .reason!,
                      ),
                      verticalSpace(10),
                      Row(
                        children: [
                          Text(
                            "File",
                            style: TextStyles.font16BlackRegular,
                          ),
                          horizontalSpace(20),
                          Builder(
                            builder: (context) {
                              if (context.read<LeavesEditCubit>().image?.path !=
                                  null) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (contextt) => Scaffold(
                                          appBar: AppBar(
                                            leading: customBackButton(context),
                                          ),
                                          body: Center(
                                            child: PhotoView(
                                              imageProvider: FileImage(
                                                File(context
                                                    .read<LeavesEditCubit>()
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
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: Image.file(
                                      File(context
                                          .read<LeavesEditCubit>()
                                          .image!
                                          .path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              } else if (context
                                      .read<LeavesEditCubit>()
                                      .leavesDetailsModel!
                                      .data!
                                      .file !=
                                  null) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (contextt) => Scaffold(
                                            appBar: AppBar(
                                              leading:
                                                  customBackButton(context),
                                            ),
                                            body: Center(
                                              child: PhotoView(
                                                imageProvider: NetworkImage(
                                                  '${ApiConstants.apiBaseUrl}${context.read<LeavesEditCubit>().leavesDetailsModel!.data!.file}',
                                                ),
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Image.asset(
                                                    'assets/images/noImage.png',
                                                    fit: BoxFit.fill,
                                                  );
                                                },
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
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      child: Image.network(
                                        '${ApiConstants.apiBaseUrl}${context.read<LeavesEditCubit>().leavesDetailsModel!.data!.file}',
                                        fit: BoxFit.fill,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            'assets/images/noImage.png',
                                            fit: BoxFit.fill,
                                          );
                                        },
                                      ),
                                    ));
                              } else {
                                return Text("There's no file");
                              }
                            },
                          ),
                          Spacer(),
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  context.read<LeavesEditCubit>().galleryFile();
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(10),
                                    backgroundColor: AppColor.primaryColor,
                                    elevation: 4),
                                child: const Icon(IconBroken.upload,
                                    color: Colors.white, size: 26),
                              ),
                              verticalSpace(8),
                              Text(
                                'Upload file',
                                style: TextStyles.font14BlackSemiBold,
                              ),
                            ],
                          ),
                          horizontalSpace(20),
                        ],
                      ),
                      verticalSpace(20),
                      state is LeavesEditLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: AppColor.primaryColor),
                            )
                          : Center(
                              child: DefaultElevatedButton(
                                  name: 'Edit',
                                  onPressed: () {
                                    context.read<LeavesEditCubit>().editLeaves(
                                        context
                                            .read<LeavesEditCubit>()
                                            .image
                                            ?.path,
                                        widget.id,
                                        typeId);
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
