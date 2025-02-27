import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/features/screens/settings/logic/settings_cubit.dart';
import 'package:smart_cleaning_application/features/screens/settings/logic/settings_state.dart';
import 'package:smart_cleaning_application/features/screens/settings/ui/widgets/list_tile_widget.dart';
import 'package:smart_cleaning_application/features/screens/settings/ui/widgets/toggle_list_tile_widget.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';
import 'package:smart_cleaning_application/src/app_cubit/app_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/widgets/default_toast/default_toast.dart';

class SettingsBody extends StatefulWidget {
  const SettingsBody({super.key});

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  bool isNotOpenNotif = true;
  bool isNotDark = true;

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
        listener: (context, state) {
          if (state is LogOutSuccessState) {
            toast(text: state.messsage, color: Colors.blue);
            context.pushNamedAndRemoveUntil(Routes.loginScreen,
                predicate: (route) => false);
          }
        },
        builder: (context, state) {
          if (context.read<SettingsCubit>().profileModel == null ||
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
                                          '${ApiConstants.apiBaseUrl}${context.read<SettingsCubit>().profileModel!.data!.image}',
                                        ),
                                        errorBuilder:
                                            (context, error, stackTrace) {
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
                                width: 80.w,
                                height: 80.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    '${ApiConstants.apiBaseUrl}${context.read<SettingsCubit>().profileModel!.data!.image}',
                                    fit: BoxFit.fill,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/noImage.png',
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
                              .profileModel!
                              .data!
                              .firstName!,
                          style: TextStyles.font14Redbold
                              .copyWith(color: Colors.black)),
                      horizontalSpace(5),
                      Text(
                          context
                              .read<SettingsCubit>()
                              .profileModel!
                              .data!
                              .lastName!,
                          style: TextStyles.font14Redbold
                              .copyWith(color: Colors.black)),
                    ],
                  ),
                  Text(context.read<SettingsCubit>().profileModel!.data!.role!,
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
                        listTileWidget(() {
                          context.pushNamed(Routes.profileScreen);
                        }, 'Profile', Icons.person),
                        listTileWidget(() {
                          context.pushNamed(Routes.changepasswordScreen);
                        }, S.of(context).settingTitle2, Icons.password_sharp),
                        listTileWidget(() {
                          context.pushNamed(Routes.technicalSupportScreen);
                        }, S.of(context).settingTitle4, Icons.phone),
                        listTileWidget(() async {
                          Uri url = Uri.https('aicloud.sa');
                          await launchUrl(url);
                        }, S.of(context).settingTitle5,
                            Icons.desktop_windows_outlined),
                        listTileWidget(() {
                          Share.share(
                              'check out my website https://example.com');
                        }, S.of(context).settingTitle3, Icons.share),
                        listTileWidget(() {
                          context.pushNamed(Routes.languageScreen);
                        }, S.of(context).settingTitle6, Icons.language),
                        toggleListTile(() {
                          setState(() {
                            isNotOpenNotif = !isNotOpenNotif;
                          });
                        }, S.of(context).settingTitle7,
                            Icons.notifications_active, isNotOpenNotif),
                        toggleListTile(() {
                          setState(() {
                            isNotDark = !isNotDark;
                          });
                        }, S.of(context).settingTitle8,
                            Icons.brightness_4_outlined, isNotDark),
                        ListTile(
                          onTap: () {
                            context.read<SettingsCubit>().logout();
                          },
                          leading: Transform.flip(
                            flipX: context.read<AppCubit>().isArabic()
                                ? false
                                : true,
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
