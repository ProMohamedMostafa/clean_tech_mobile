import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/features/screens/profile/logic/profile_cubit.dart';
import 'package:smart_cleaning_application/features/screens/profile/logic/profile_state.dart';
import 'package:smart_cleaning_application/features/screens/profile/ui/widgets/history/user_attendance_details.dart';
import 'package:smart_cleaning_application/features/screens/profile/ui/widgets/leaves/user_leaves_details.dart';
import 'package:smart_cleaning_application/features/screens/profile/ui/widgets/shifts/user_shift_details.dart';
import 'package:smart_cleaning_application/features/screens/profile/ui/widgets/tasks/user_tasks_details.dart';
import 'package:smart_cleaning_application/features/screens/profile/ui/widgets/user_details.dart/user_details.dart';
import 'package:smart_cleaning_application/features/screens/profile/ui/widgets/work_location.dart/work_location_user_details.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: role != 'Admin' ? 6 : 1, vsync: this);
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
    final cubit = context.read<ProfileCubit>();
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
              // generateAndSavePDF(context);
            },
            icon: Icon(
              CupertinoIcons.tray_arrow_down,
              color: Colors.red,
              size: 22.sp,
            ),
          ),
          IconButton(
              onPressed: () {
                context.pushNamed(Routes.editProfileScreen, arguments: uId);
              },
              icon: Icon(
                Icons.edit,
                color: AppColor.primaryColor,
              ))
        ],
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (cubit.profileModel?.data == null) {
            return Center(
              child: Image.asset(
                'assets/images/loading.gif',
                width: 100.w,
                height: 100.h,
                fit: BoxFit.contain,
              ),
            );
          }
          if (role != 'Admin') {
            if (cubit.profileModel?.data == null ||
                cubit.userShiftDetailsModel?.data == null ||
                cubit.userTaskDetailsModel?.data == null ||
                cubit.userWorkLocationDetailsModel?.data == null ||
                cubit.attendanceLeavesModel?.data == null) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                ),
              );
            }
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Stack(
                    children: [
                      GestureDetector(
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
                                      imageProvider: NetworkImage(
                                        '${ApiConstants.apiBaseUrlImage}${cubit.profileModel?.data?.image}',
                                      ),
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/images/person.png',
                                          fit: BoxFit.fill,
                                        );
                                      },
                                      backgroundDecoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                              width: 80.w,
                              height: 80.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  '${ApiConstants.apiBaseUrlImage}${cubit.profileModel!.data!.image}',
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/person.png',
                                      fit: BoxFit.fill,
                                    );
                                  },
                                ),
                              ))),
                      if (role != 'Admin')
                        Positioned(
                          bottom: 1,
                          right: 10,
                          child: Container(
                            width: 15.w,
                            height: 15.h,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: cubit.profileModel!.data == null
                                    ? Colors.red
                                    : cubit.profileModel!.data!.isWorking ==
                                            true
                                        ? Colors.green
                                        : Colors.red,
                                border: Border.all(
                                    color: Colors.white, width: 2.w)),
                          ),
                        )
                    ],
                  ),
                ),
                verticalSpace(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(cubit.profileModel?.data?.firstName ?? '',
                        style: TextStyles.font14Redbold
                            .copyWith(color: Colors.black)),
                    horizontalSpace(5),
                    Text(cubit.profileModel?.data?.lastName ?? '',
                        style: TextStyles.font14Redbold
                            .copyWith(color: Colors.black)),
                  ],
                ),
                verticalSpace(5),
                Text(cubit.profileModel!.data!.role!,
                    style: TextStyles.font12GreyRegular
                        .copyWith(color: AppColor.primaryColor)),
                verticalSpace(15),
                SizedBox(
                  height: 42.h,
                  width: double.infinity,
                  child: TabBar(
                      tabAlignment: TabAlignment.center,
                      isScrollable: true,
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
                            S.of(context).userDetails,
                            style: TextStyle(
                                color: controller.index == 0
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp),
                          ),
                        ),
                        if (role != 'Admin') ...[
                          Tab(
                            child: Text(
                              S.of(context).integ2,
                              style: TextStyle(
                                  color: controller.index == 1
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp),
                            ),
                          ),
                          Tab(
                            child: Text(
                              S.of(context).integ4,
                              style: TextStyle(
                                  color: controller.index == 2
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp),
                            ),
                          ),
                          Tab(
                            child: Text(
                              S.of(context).integ5,
                              style: TextStyle(
                                  color: controller.index == 3
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp),
                            ),
                          ),
                          Tab(
                            child: Text(
                              S.of(context).attendance,
                              style: TextStyle(
                                  color: controller.index == 4
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp),
                            ),
                          ),
                          Tab(
                            child: Text(
                              S.of(context).leaves,
                              style: TextStyle(
                                  color: controller.index == 5
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp),
                            ),
                          ),
                        ]
                      ]),
                ),
                Divider(
                  color: Colors.grey[300],
                  height: 2,
                ),
                verticalSpace(5),
                Expanded(
                  child: TabBarView(controller: controller, children: [
                    UserDetails(),
                    if (role != 'Admin') ...[
                      WorkLocationUserDetails(),
                      UserShiftDetails(),
                      UserTasksDetails(),
                      UserAttendanceDetails(),
                      UserLeavesDetails()
                    ]
                  ]),
                ),
                verticalSpace(20),
              ],
            ),
          );
        },
      ),
    );
  }
}
