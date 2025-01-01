import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/user/edit_user/logic/edit_user_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/edit_user/logic/edit_user_state.dart';
import 'package:smart_cleaning_application/features/screens/user/edit_user/ui/widgets/edit_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/user/edit_user/ui/widgets/edit_user_text_form_field/edit_user_text_form_field.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

import '../../../../../../core/widgets/default_toast/default_toast.dart';

class EditUserBody extends StatefulWidget {
  final int id;
  const EditUserBody({super.key, required this.id});

  @override
  State<EditUserBody> createState() => _EditUserBodyState();
}

class _EditUserBodyState extends State<EditUserBody> {
  @override
  void initState() {
    context.read<EditUserCubit>().getUserDetailsInEdit(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).editUserTitle,
          style: TextStyles.font16BlackSemiBold,
        ),
        centerTitle: true,
        leading: customBackButton(context),
      ),
      body: BlocConsumer<EditUserCubit, EditUserState>(
          listener: (context, state) {
        if (state is EditUserSuccessState) {
          toast(text: state.editModel.message!, color: Colors.blue);
          context.pushNamedAndRemoveLastTwo(Routes.userManagmentScreen);
        }
        if (state is EditUserErrorState) {
          toast(text: state.error, color: Colors.red);
        }
      }, builder: (context, state) {
        if (state is UserLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColor.primaryColor,
            ),
          );
        }
        return SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(15),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 100.w,
                        height: 100.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // color: Colors.white,
                            border: Border.all(
                                color: AppColor.primaryColor, width: 3.w)),
                        child: ClipOval(
                            child: Image.asset(
                          'assets/images/profile.png',
                          fit: BoxFit.fill,
                        )),
                      ),
                      Positioned(
                        bottom: 1,
                        right: 10,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                              width: 22.w,
                              height: 22.h,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.primaryColor),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 15.sp,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                verticalSpace(35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: EditUserTextField(
                        controller:
                            context.read<EditUserCubit>().firstNameController,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        label: S.of(context).addUserText1,
                        hint: context
                            .read<EditUserCubit>()
                            .userModel!
                            .data!
                            .firstName!,
                      ),
                    ),
                    horizontalSpace(10),
                    Expanded(
                      child: EditUserTextField(
                        controller:
                            context.read<EditUserCubit>().lastNameController,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        label: S.of(context).addUserText2,
                        hint: context
                            .read<EditUserCubit>()
                            .userModel!
                            .data!
                            .lastName!,
                      ),
                    ),
                  ],
                ),
                verticalSpace(15),
                EditUserTextField(
                  controller: context.read<EditUserCubit>().userNameController,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  label: S.of(context).addUserText5,
                  hint:
                      context.read<EditUserCubit>().userModel!.data!.userName!,
                ),
                verticalSpace(15),
                EditUserTextField(
                  controller: context.read<EditUserCubit>().emailController,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  label: S.of(context).addUserText3,
                  hint: context.read<EditUserCubit>().userModel!.data!.email!,
                ),
                verticalSpace(15),
                EditUserTextField(
                  controller: context.read<EditUserCubit>().phoneController,
                  obscureText: false,
                  keyboardType: TextInputType.phone,
                  label: S.of(context).addUserText10,
                  hint: context
                      .read<EditUserCubit>()
                      .userModel!
                      .data!
                      .phoneNumber!,
                ),
                verticalSpace(9),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: EditDropdownList(
                          title: 'Country',
                          index: context
                              .read<EditUserCubit>()
                              .userModel!
                              .data!
                              .countryName!,
                          items: ['items', 'saas'],
                          onPressed: (value) {
                            context
                                .read<EditUserCubit>()
                                .countryController
                                .text = value;
                          }),
                    ),
                    horizontalSpace(10),
                    Expanded(
                      child: EditDropdownList(
                          title: 'Gender',
                          index: context
                              .read<EditUserCubit>()
                              .userModel!
                              .data!
                              .gender!,
                          items: ['items', 'saas'],
                          onPressed: (value) {
                            context
                                .read<EditUserCubit>()
                                .genderController
                                .text = value;
                          }),
                    ),
                  ],
                ),
                verticalSpace(9),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: EditDropdownList(
                          title: 'Nationality',
                          index: context
                              .read<EditUserCubit>()
                              .userModel!
                              .data!
                              .nationalityName!,
                          items: ['items', 'saas'],
                          onPressed: (value) {
                            context
                                .read<EditUserCubit>()
                                .nationalityController
                                .text = value;
                          }),
                    ),
                    horizontalSpace(10),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: EditUserTextField(
                          controller:
                              context.read<EditUserCubit>().birthController,
                          obscureText: false,
                          suffixIcon: Icons.calendar_today,
                          suffixPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime
                                  .now(), // This disables any date before today
                              lastDate:
                                  DateTime(3025), // Set this to any future date
                            );
                            if (pickedDate != null) {
                              // Format date in the form "yyyy-MM-dd"
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              setState(() {
                                context
                                    .read<EditUserCubit>()
                                    .birthController
                                    .text = formattedDate;
                              });
                            }
                          },
                          keyboardType: TextInputType.none,
                          label: S.of(context).addUserText4,
                          hint: context
                              .read<EditUserCubit>()
                              .userModel!
                              .data!
                              .birthdate!,
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpace(15),
                EditUserTextField(
                  controller: context.read<EditUserCubit>().idNumberController,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  label: S.of(context).addUserText7,
                  hint:
                      context.read<EditUserCubit>().userModel!.data!.idNumber!,
                ),
                verticalSpace(9),
                EditDropdownList(
                    title: 'Provider',
                    index: context
                        .read<EditUserCubit>()
                        .userModel!
                        .data!
                        .providerName!,
                    items: ['items', 'saas'],
                    onPressed: (value) {
                      context.read<EditUserCubit>().providerIdController.text =
                          value;
                    }),
                verticalSpace(20),
                state is EditUserLoadingState
                    ? const Center(
                        child: CircularProgressIndicator(
                            color: AppColor.primaryColor),
                      )
                    : Center(
                        child: DefaultElevatedButton(
                            name: S.of(context).saveButtton,
                            onPressed: () {
                              showCustomDialog(context,
                                  "Are you Sure you want save the edit of this user ?",
                                  () {
                                context
                                    .read<EditUserCubit>()
                                    .editUser(widget.id);
                                context.pop();
                              });
                            },
                            color: AppColor.primaryColor,
                            height: 47,
                            width: double.infinity,
                            textStyles: TextStyles.font20Whitesemimedium),
                      ),
                verticalSpace(30),
              ],
            ),
          ),
        ));
      }),
    );
  }
}
