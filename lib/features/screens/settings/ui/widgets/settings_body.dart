import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/cache_helper/cache_helper.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/settings/logic/settings_cubit.dart';
import 'package:smart_cleaning_application/features/screens/settings/logic/settings_state.dart';
import 'package:smart_cleaning_application/features/screens/settings/ui/widgets/list_tile_widget.dart';
import 'package:smart_cleaning_application/features/screens/settings/ui/widgets/toggle_list_tile_widget.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class SettingsBody extends StatefulWidget {
  const SettingsBody({super.key});

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  bool isSwitched = true;
  bool isDark = false;

  @override
  void initState() {
    context.read<SettingsCubit>().getUserDetails();
    context.read<SettingsCubit>().getUserStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (context.read<SettingsCubit>().userDetailsModel == null ||
              context.read<SettingsCubit>().userStatusModel == null) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColor.primaryColor,
              ),
            );
          }
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 80.w,
                          height: 80.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: Image.network(
                              '${ApiConstants.apiBaseUrl}${context.read<SettingsCubit>().userDetailsModel!.data!.image}',
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/noImage.png',
                                  fit: BoxFit.fill,
                                );
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 1,
                          right: 10,
                          child: InkWell(
                            onTap: () {
                              // context.read<EditUserCubit>().galleryFile();
                            },
                            child: Container(
                              width: 15.w,
                              height: 15.h,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: context
                                              .read<SettingsCubit>()
                                              .userStatusModel!
                                              .data!
                                              .status ==
                                          'not working'
                                      ? Colors.red
                                      : Colors.green,
                                  border: Border.all(
                                      color: Colors.white, width: 2.w)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  verticalSpace(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          context
                              .read<SettingsCubit>()
                              .userDetailsModel!
                              .data!
                              .firstName!,
                          style: TextStyles.font14Redbold
                              .copyWith(color: Colors.black)),
                      horizontalSpace(5),
                      Text(
                          context
                              .read<SettingsCubit>()
                              .userDetailsModel!
                              .data!
                              .lastName!,
                          style: TextStyles.font14Redbold
                              .copyWith(color: Colors.black)),
                    ],
                  ),
                  Text(
                      context
                          .read<SettingsCubit>()
                          .userDetailsModel!
                          .data!
                          .role!,
                      style: TextStyles.font12GreyRegular
                          .copyWith(color: AppColor.primaryColor)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        listTileWidget(() {}, 'Profile', Icons.person),
                        listTileWidget(() {
                          context.pushNamed(Routes.changepasswordScreen);
                        }, S.of(context).settingTitle2, Icons.password_sharp),
                        listTileWidget(() {
                          context.pushNamed(Routes.technicalSupportScreen);
                        }, S.of(context).settingTitle4, Icons.phone),
                        listTileWidget(() {}, S.of(context).settingTitle5,
                            Icons.desktop_windows_outlined),
                        listTileWidget(
                            () {}, S.of(context).settingTitle3, Icons.share),
                        listTileWidget(() {
                          context.pushNamed(Routes.languageScreen);
                        }, S.of(context).settingTitle6, Icons.language),
                        toggleListTile(() {
                          setState(() {
                            isSwitched = !isSwitched;
                          });
                        }, S.of(context).settingTitle7,
                            Icons.notifications_active, isSwitched),
                        toggleListTile(() {
                          setState(() {
                            isDark = !isDark;
                          });
                        }, S.of(context).settingTitle8,
                            Icons.brightness_4_outlined, isDark),
                        ListTile(
                          onTap: () {
                            CacheHelper.clearAllSecuredData();
                            CacheHelper.clearAllData();
                            context.pushNamedAndRemoveUntil(Routes.loginScreen,
                                predicate: (route) => false);
                          },
                          leading: Transform.flip(
                            flipX:
                                // context.read<AppCubit>().isArabic()
                                //     ? false
                                //     :
                                true,
                            child: Icon(
                              Icons.logout_outlined,
                              size: 20.sp,
                              color: Colors.red,
                            ),
                          ),
                          title: Text(
                            S.of(context).settingTitle9,
                            style: TextStyles.font14GreyRegular
                                .copyWith(color: Colors.red),
                          ),
                          dense: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
