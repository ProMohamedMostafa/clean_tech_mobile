import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/layout/main_layout/logic/bottom_navbar_cubit.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_cubit.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_state.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/notification_build.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        final data = cubit.profileModel?.data;
        final isLoading = data == null;

        return Skeletonizer(
          enabled: isLoading,
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      offset: const Offset(0, 1),
                      blurRadius: 4,
                    )
                  ],
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14.r),
                  child: isLoading
                      ? Container(color: Colors.grey[300])
                      : Image.network(
                          '${ApiConstants.apiBaseUrlImage}${data.image ?? ''}',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/person.png',
                              fit: BoxFit.fill,
                            );
                          },
                        ),
                ),
              ),
              horizontalSpace(6),
              InkWell(
                onTap: () {
                  context.read<BottomNavbarCubit>().changeBottomNavbar(3);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Hey, ',
                            style: TextStyles.font12BlackSemi,
                          ),
                          TextSpan(
                            text: data?.firstName ?? '',
                            style: TextStyles.font12BlackSemi,
                          ),
                          TextSpan(
                            text: '..👋',
                            style: TextStyles.font12BlackSemi,
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(3),
                    Text(
                      data?.role ?? '',
                      style: TextStyles.font11lightPrimary,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  context.pushNamed(Routes.notificationScreen);
                },
                icon: NotificationBuild(),
              )
            ],
          ),
        );
      },
    );
  }
}
