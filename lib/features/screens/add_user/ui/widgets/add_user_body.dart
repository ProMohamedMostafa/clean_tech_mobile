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
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/add_user/logic/add_user_cubit.dart';
import 'package:smart_cleaning_application/features/screens/add_user/logic/add_user_state.dart';
import 'package:smart_cleaning_application/features/screens/add_user/ui/widgets/add_user_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/add_user/ui/widgets/drop_down_list.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AddUserBody extends StatefulWidget {
  const AddUserBody({super.key});

  @override
  State<AddUserBody> createState() => _AddUserBodyState();
}

class _AddUserBodyState extends State<AddUserBody> {
  @override
  void initState() {
    context.read<AddUserCubit>()
      ..getNationality()
      ..getRole()
      ..getAllUsers()
      ..getAllProviders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).addUserTitle,
          style: TextStyles.font16BlackSemiBold,
        ),
        centerTitle: true,
        leading: customBackButton(context),
      ),
      body: BlocConsumer<AddUserCubit, AddUserState>(
        listener: (context, state) {
          if (state is AddUserSuccessState) {
            toast(text: state.userCreateModel.message!, color: Colors.blue);
            context.pushNamedAndRemoveLastTwo(Routes.userManagmentScreen);
          }
          if (state is AddUserErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          return SafeArea(
              child: SingleChildScrollView(
            child: Form(
              key: context.read<AddUserCubit>().formKey,
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
                              'assets/images/noImage.png',
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
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                    size: 20.sp,
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).addUserText1,
                                style: TextStyles.font16BlackRegular,
                              ),
                              AddUserTextFormField(
                                controller: context
                                    .read<AddUserCubit>()
                                    .firstNameController,
                                obscureText: false,
                                readOnly: false,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S.of(context).validationFirstName;
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        horizontalSpace(10),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).addUserText2,
                              style: TextStyles.font16BlackRegular,
                            ),
                            AddUserTextFormField(
                              controller: context
                                  .read<AddUserCubit>()
                                  .lastNameController,
                              obscureText: false,
                              readOnly: false,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return S.of(context).validationLastName;
                                }
                              },
                            ),
                          ],
                        )),
                      ],
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).addUserText5,
                      style: TextStyles.font16BlackRegular,
                    ),
                    AddUserTextFormField(
                      controller:
                          context.read<AddUserCubit>().userNameController,
                      obscureText: false,
                      readOnly: false,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).validationUserName;
                        }
                      },
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).addUserText3,
                      style: TextStyles.font16BlackRegular,
                    ),
                    AddUserTextFormField(
                      controller: context.read<AddUserCubit>().emailController,
                      obscureText: false,
                      readOnly: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).validationAddEmail;
                        }
                      },
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).addUserText10,
                      style: TextStyles.font16BlackRegular,
                    ),
                    AddUserTextFormField(
                      controller: context.read<AddUserCubit>().phoneController,
                      obscureText: false,
                      readOnly: false,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).validationPhoneNumber;
                        }
                      },
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
                                S.of(context).addUserText12,
                                style: TextStyles.font16BlackRegular,
                              ),
                              DropdownList(
                                onPressed: (selectedValue) {
                                  context
                                      .read<AddUserCubit>()
                                      .countryController
                                      .text = selectedValue;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S.of(context).validationCountry;
                                  }
                                  return null;
                                },
                                title: 'Country',
                                items: context
                                            .read<AddUserCubit>()
                                            .nationalityModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No countries']
                                    : context
                                            .read<AddUserCubit>()
                                            .nationalityModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                              ),
                            ],
                          ),
                        ),
                        horizontalSpace(10),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).addUserText9,
                              style: TextStyles.font16BlackRegular,
                            ),
                            DropdownList(
                              onPressed: (selectedValue) {
                                final items = ['Male', 'Female'];
                                final selectedIndex =
                                    items.indexOf(selectedValue);
                                if (selectedIndex != -1) {
                                  context
                                      .read<AddUserCubit>()
                                      .genderController
                                      .text = selectedIndex.toString();
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return S.of(context).validationGender;
                                }
                                return null;
                              },
                              title: 'Gender',
                              items: ['Male', 'Female'],
                            ),
                          ],
                        )),
                      ],
                    ),
                    verticalSpace(15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).addUserText8,
                                style: TextStyles.font16BlackRegular,
                              ),
                              DropdownList(
                                onPressed: (selectedValue) {
                                  context
                                      .read<AddUserCubit>()
                                      .nationalityController
                                      .text = selectedValue;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S.of(context).validationNationality;
                                  }
                                  return null;
                                },
                                title: 'Nationality',
                                items: context
                                            .read<AddUserCubit>()
                                            .nationalityModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No nationalities']
                                    : context
                                            .read<AddUserCubit>()
                                            .nationalityModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                              ),
                            ],
                          ),
                        ),
                        horizontalSpace(10),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).addUserText4,
                              style: TextStyles.font16BlackRegular,
                            ),
                            AddUserTextFormField(
                              controller:
                                  context.read<AddUserCubit>().birthController,
                              obscureText: false,
                              readOnly: true,
                              suffixIcon: Icons.calendar_today,
                              suffixPressed: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime
                                      .now(), // This disables any date before today
                                  lastDate: DateTime(
                                      3025), // Set this to any future date
                                );
                                if (pickedDate != null) {
                                  // Format date in the form "yyyy-MM-dd"
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  setState(() {
                                    context
                                        .read<AddUserCubit>()
                                        .birthController
                                        .text = formattedDate;
                                  });
                                }
                              },
                              keyboardType: TextInputType.none,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return S.of(context).validationBirthdate;
                                }
                              },
                            ),
                          ],
                        )),
                      ],
                    ),
                    verticalSpace(15),
                    Text(
                      S.of(context).addUserText7,
                      style: TextStyles.font16BlackRegular,
                    ),
                    AddUserTextFormField(
                      controller:
                          context.read<AddUserCubit>().idNumberController,
                      obscureText: false,
                      readOnly: false,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).validationIdNumber;
                        }
                      },
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).addUserText6,
                      style: TextStyles.font16BlackRegular,
                    ),
                    AddUserTextFormField(
                      controller:
                          context.read<AddUserCubit>().passwordController,
                      obscureText: false,
                      readOnly: false,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).validationAddPassword;
                        }
                      },
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).addUserText11,
                      style: TextStyles.font16BlackRegular,
                    ),
                    AddUserTextFormField(
                      controller: context
                          .read<AddUserCubit>()
                          .passwordConfirmationController,
                      obscureText: false,
                      readOnly: false,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S
                              .of(context)
                              .validationAddPasswordConfirmation;
                        }
                      },
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).addUserText13,
                      style: TextStyles.font16BlackRegular,
                    ),
                    DropdownList(
                      onPressed: (selectedValue) {
                        final selectedId = context
                            .read<AddUserCubit>()
                            .roleModel
                            ?.data
                            ?.firstWhere(
                              (role) => role.name == selectedValue,
                            )
                            .id
                            ?.toString();

                        if (selectedId != null) {
                          context.read<AddUserCubit>().roleController.text =
                              selectedId;
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).validationRole;
                        }
                        return null;
                      },
                      title: 'Role',
                      items: context
                                  .read<AddUserCubit>()
                                  .roleModel
                                  ?.data
                                  ?.isEmpty ??
                              true
                          ? ['No roles available']
                          : context
                                  .read<AddUserCubit>()
                                  .roleModel
                                  ?.data
                                  ?.map((e) => e.name ?? 'Unknown')
                                  .toList() ??
                              [],
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).addUserText14,
                      style: TextStyles.font16BlackRegular,
                    ),
                    DropdownList(
                      onPressed: (selectedValue) {
                        final selectedId = context
                            .read<AddUserCubit>()
                            .usersModel
                            ?.data
                            ?.firstWhere(
                              (manager) => manager.userName == selectedValue,
                            )
                            .id
                            ?.toString();

                        if (selectedId != null) {
                          context
                              .read<AddUserCubit>()
                              .managerIdNumberController
                              .text = selectedId;
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).validationManager;
                        }
                        return null;
                      },
                      title: 'Manager',
                      items: context
                                  .read<AddUserCubit>()
                                  .usersModel
                                  ?.data
                                  ?.isEmpty ??
                              true
                          ? ['No Managers available']
                          : context
                                  .read<AddUserCubit>()
                                  .usersModel
                                  ?.data
                                  ?.map((e) => e.userName ?? 'Unknown')
                                  .toList() ??
                              [],
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).addUserText15,
                      style: TextStyles.font16BlackRegular,
                    ),
                    DropdownList(
                      onPressed: (selectedValue) {
                        final selectedId = context
                            .read<AddUserCubit>()
                            .providersModel
                            ?.data
                            ?.firstWhere(
                              (provider) => provider.name == selectedValue,
                            )
                            .id
                            ?.toString();

                        if (selectedId != null) {
                          context
                              .read<AddUserCubit>()
                              .providerIdController
                              .text = selectedId;
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).validationProvider;
                        }
                        return null;
                      },
                      title: 'Provider',
                      items: context
                                  .read<AddUserCubit>()
                                  .providersModel
                                  ?.data
                                  ?.isEmpty ??
                              true
                          ? ['No Providers available']
                          : context
                                  .read<AddUserCubit>()
                                  .providersModel
                                  ?.data
                                  ?.map((e) => e.name ?? 'Unknown')
                                  .toList() ??
                              [],
                    ),
                    verticalSpace(20),
                    state is AddUserLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(
                                color: AppColor.primaryColor),
                          )
                        : Center(
                            child: DefaultElevatedButton(
                                name: S.of(context).saveButtton,
                                onPressed: () {
                                  if (context
                                      .read<AddUserCubit>()
                                      .formKey
                                      .currentState!
                                      .validate()) {
                                    context.read<AddUserCubit>().addUser();
                                  }
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
            ),
          ));
        },
      ),
    );
  }
}
