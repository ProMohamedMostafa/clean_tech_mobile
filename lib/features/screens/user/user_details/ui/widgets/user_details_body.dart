import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/row_details_build.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class UserDetailsBody extends StatefulWidget {
  final int id;
  const UserDetailsBody({super.key, required this.id});

  @override
  State<UserDetailsBody> createState() => _UserDetailsBodyState();
}

class _UserDetailsBodyState extends State<UserDetailsBody>
    with TickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    context.read<UserManagementCubit>().getUserDetails(widget.id);
    controller = TabController(length: 2, vsync: this);
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).userDetailsTitle,
          style: TextStyles.font16BlackSemiBold,
        ),
        centerTitle: true,
        leading: customBackButton(context),
        actions: [
          IconButton(
              onPressed: () {
                context.pushNamed(Routes.editUserScreen, arguments: widget.id);
              },
              icon: Icon(
                Icons.edit,
                color: AppColor.primaryColor,
              ))
        ],
      ),
      body: BlocConsumer<UserManagementCubit, UserManagementState>(
        listener: (context, state) {
          if (state is UserDeleteInDetailsSuccessState) {
            toast(
                text: state.deleteUserDetailsModel.message!,
                color: Colors.blue);
            context.pushNamedAndRemoveLastTwo(Routes.userManagmentScreen);
          }
          if (state is UserDeleteInDetailsErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          if (state is UserLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColor.primaryColor,
              ),
            );
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: 100.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColor.primaryColor,
                          width: 3.w,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/profile.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  verticalSpace(25),
                  Container(
                    height: 40.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.r)),
                        border: Border.all(
                          color: AppColor.secondaryColor,
                        )),
                    child: TabBar(
                        tabAlignment: TabAlignment.fill,
                        isScrollable: false,
                        indicatorSize: TabBarIndicatorSize.tab,
                        controller: controller,
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.r)),
                          color: controller.index == controller.index
                              ? AppColor.primaryColor
                              : Colors.transparent,
                        ),
                        tabs: [
                          Tab(
                            child: Text(
                              "User Data",
                              style: TextStyle(
                                  color: controller.index == 0
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "User Location",
                              style: TextStyle(
                                  color: controller.index == 1
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp),
                            ),
                          ),
                        ]),
                  ),
                  verticalSpace(20),
                  Expanded(
                    child: TabBarView(controller: controller, children: [
                      userDetails(),
                      locationUserDetails(),
                    ]),
                  ),
                  verticalSpace(15),
                  (uId == widget.id)
                      ? SizedBox.shrink()
                      : DefaultElevatedButton(
                          name: S.of(context).deleteButton,
                          onPressed: () {
                            showCustomDialog(
                                context, S.of(context).deleteMessage, () {
                              context
                                  .read<UserManagementCubit>()
                                  .userDeleteInDetails(widget.id);
                            });
                          },
                          color: AppColor.primaryColor,
                          height: 48,
                          width: double.infinity,
                          textStyles: TextStyles.font20Whitesemimedium),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget userDetails() {
    final userModel = context.read<UserManagementCubit>().userModel!;

    return SingleChildScrollView(
      child: Column(
        children: [
          rowDetailsBuild(
              context, S.of(context).addUserText5, userModel.data!.userName!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(
              context, S.of(context).addUserText1, userModel.data!.firstName!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(
              context, S.of(context).addUserText2, userModel.data!.lastName!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(
              context, S.of(context).addUserText3, userModel.data!.email!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(context, S.of(context).addUserText10,
              userModel.data!.phoneNumber!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(
              context, S.of(context).addUserText4, userModel.data!.birthdate!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(
              context, S.of(context).addUserText7, userModel.data!.idNumber!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(context, S.of(context).addUserText8,
              userModel.data!.nationalityName!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(context, S.of(context).addUserText12,
              userModel.data!.countryName!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(
              context, S.of(context).addUserText9, userModel.data!.gender!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(context, S.of(context).addUserText15,
              userModel.data!.providerName!),
        ],
      ),
    );
  }

  Widget locationUserDetails() {
    final userModel = context.read<UserManagementCubit>().userModel!;

    return SingleChildScrollView(
      child: Column(
        children: [
          rowDetailsBuild(context, S.of(context).addUserText12,
              userModel.data!.countryName!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(context, 'Area', 'Cairo'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(context, 'City', 'Nasr city'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(context, 'Orginasation', 'Ai Cloud'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(context, 'Floor', '3'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(context, 'Points', '6'),
        ],
      ),
    );
  }
}
