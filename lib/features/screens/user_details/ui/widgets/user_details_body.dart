import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/features/screens/user_details/logic/user_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user_details/logic/user_state.dart';
import 'package:smart_cleaning_application/features/screens/user_details/ui/widgets/buttons_details_build.dart';
import 'package:smart_cleaning_application/features/screens/user_details/ui/widgets/row_details_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class UserDetailsBody extends StatefulWidget {
  const UserDetailsBody({super.key});

  @override
  State<UserDetailsBody> createState() => _UserDetailsBodyState();
}

class _UserDetailsBodyState extends State<UserDetailsBody> {
  @override
  void initState() {
    context.read<UserCubit>().getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).userDetailsTitle,
          style: TextStyles.font24PrimsemiBold,
        ),
        centerTitle: true,
        leading: customBackButton(context),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(15),
                  Center(
                    child: Container(
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
                  ),
                  verticalSpace(35),
                  rowDetailsBuild(context, S.of(context).addUserText1,
                      context.read<UserCubit>().userModel!.data!.firstName!),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Divider(),
                  ),
                  rowDetailsBuild(context, S.of(context).addUserText2,
                      context.read<UserCubit>().userModel!.data!.lastName!),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Divider(),
                  ),
                  rowDetailsBuild(context, S.of(context).addUserText3,
                      context.read<UserCubit>().userModel!.data!.email!),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Divider(),
                  ),
                  rowDetailsBuild(context, S.of(context).addUserText10,
                      context.read<UserCubit>().userModel!.data!.phoneNumber!),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Divider(),
                  ),
                  rowDetailsBuild(context, S.of(context).addUserText4,
                      context.read<UserCubit>().userModel!.data!.birthdate!),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Divider(),
                  ),
                  rowDetailsBuild(context, S.of(context).addUserText5,
                      context.read<UserCubit>().userModel!.data!.userName!),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Divider(),
                  ),
                  rowDetailsBuild(context, S.of(context).addUserText7,
                      context.read<UserCubit>().userModel!.data!.idNumber!),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Divider(),
                  ),
                  rowDetailsBuild(
                      context,
                      S.of(context).addUserText8,
                      context
                          .read<UserCubit>()
                          .userModel!
                          .data!
                          .nationalityName!),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Divider(),
                  ),
                  rowDetailsBuild(context, S.of(context).addUserText9,
                      context.read<UserCubit>().userModel!.data!.gender!),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Divider(),
                  ),
                  verticalSpace(35),
                  ButtonsDetailsBuild(),
                  verticalSpace(30),
                ],
              ),
            ),
          ));
        },
      ),
    );
  }
}
