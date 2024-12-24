import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/features/screens/edit_user/logic/edit_user_cubit.dart';
import 'package:smart_cleaning_application/features/screens/edit_user/logic/edit_user_state.dart';
import 'package:smart_cleaning_application/features/screens/edit_user/ui/widgets/edit_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/edit_user/ui/widgets/edit_user_text_form_field/edit_user_text_form_field.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

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
        listener: (context, state) {},
        builder: (context, state) {
          // EditUserCubit cubit = EditUserCubit.get(context);

          if (state is UserLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColor.primaryColor,
              ),
            );
          } else if (state is UserSuccessState) {
            return SafeArea(
                child: SingleChildScrollView(
              child: Form(
                key: context.read<EditUserCubit>().formKey,
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
                                      color: AppColor.primaryColor,
                                      width: 3.w)),
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
                              controller: context
                                  .read<EditUserCubit>()
                                  .firstNameController,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return S.of(context).validationEmailAndUser;
                                }
                              },
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
                              controller: context
                                  .read<EditUserCubit>()
                                  .lastNameController,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return S.of(context).validationEmailAndUser;
                                }
                              },
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
                        controller:
                            context.read<EditUserCubit>().userNameController,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).validationUserName;
                          }
                        },
                        label: S.of(context).addUserText5,
                        hint: context
                            .read<EditUserCubit>()
                            .userModel!
                            .data!
                            .userName!,
                      ),
                      verticalSpace(15),
                      EditUserTextField(
                        controller:
                            context.read<EditUserCubit>().emailController,
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).validationEmailAndUser;
                          }
                        },
                        label: S.of(context).addUserText3,
                        hint: context
                            .read<EditUserCubit>()
                            .userModel!
                            .data!
                            .email!,
                      ),
                      verticalSpace(15),
                      EditUserTextField(
                        controller:
                            context.read<EditUserCubit>().phoneController,
                        obscureText: false,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).validationEmailAndUser;
                          }
                        },
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
                                controller: context
                                    .read<EditUserCubit>()
                                    .birthController,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S.of(context).validationEmailAndUser;
                                  }
                                },
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
                        controller:
                            context.read<EditUserCubit>().idNumberController,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).validationEmailAndUser;
                          }
                        },
                        label: S.of(context).addUserText7,
                        hint: context
                            .read<EditUserCubit>()
                            .userModel!
                            .data!
                            .idNumber!,
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
                            context
                                .read<EditUserCubit>()
                                .providerIdController
                                .text = value;
                          }),
                      verticalSpace(35),
                      Center(
                        child: DefaultElevatedButton(
                            name: S.of(context).saveButtton,
                            onPressed: () {},
                            color: AppColor.primaryColor,
                            height: 47,
                            width: double.infinity,
                            textStyles: TextStyles.font20Whitesemimedium),
                      ),
                      verticalSpace(30),
                    ],
                  ),
                ),
              ),
            ));
          } else {
            return Center(
                child: Text(
              "Please try again",
            ));
          }
        },
      ),
    );
  }
}
