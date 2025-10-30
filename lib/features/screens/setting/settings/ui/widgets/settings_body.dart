import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/features/screens/setting/settings/logic/settings_cubit.dart';
import 'package:smart_cleaning_application/features/screens/setting/settings/logic/settings_state.dart';
import 'package:smart_cleaning_application/features/screens/setting/settings/ui/widgets/list_tile_widget.dart';
import 'package:smart_cleaning_application/features/screens/setting/settings/ui/widgets/toggle_list_tile_widget.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/widgets/default_toast/default_toast.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    return BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {
      if (state is LogOutSuccessState) {
        toast(text: state.messsage, isSuccess: true);
        context.pushNamedAndRemoveUntil(Routes.loginScreen,
            predicate: (route) => false);
      }
    }, builder: (context, state) {
      final isLoading = cubit.profileModel == null;
      final profile = cubit.profileModel?.data;

      return Skeletonizer(
        enabled: isLoading,
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
                          if (isLoading) return;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (contextt) => Scaffold(
                                appBar: AppBar(
                                  leading: CustomBackButton(),
                                ),
                                body: Center(
                                  child: PhotoView(
                                    imageProvider: NetworkImage(
                                      profile?.image ?? '',
                                    ),
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/person.png',
                                        fit: BoxFit.fill,
                                      );
                                    },
                                    backgroundDecoration: const BoxDecoration(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 100.r,
                          height: 100.r,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: ClipOval(
                            child: isLoading
                                ? Container(color: Colors.grey[300])
                                : Image.network(
                                    profile?.image ?? '',
                                    fit: BoxFit.fill,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/person.png',
                                        fit: BoxFit.fill,
                                      );
                                    },
                                  ),
                          ),
                        )),
                    if (!isLoading && role != 'Admin')
                      Positioned(
                        bottom: 1,
                        right: 10,
                        child: Container(
                          width: 15.w,
                          height: 15.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: profile == null
                                ? Colors.red
                                : profile.isWorking == true
                                    ? Colors.green
                                    : Colors.red,
                            border: Border.all(color: Colors.white, width: 2.w),
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
                  Text(profile?.firstName ?? '----',
                      style: TextStyles.font14Redbold
                          .copyWith(color: Colors.black)),
                  horizontalSpace(5),
                  Text(profile?.lastName ?? '----',
                      style: TextStyles.font14Redbold
                          .copyWith(color: Colors.black)),
                ],
              ),
              Text(profile?.role ?? '------',
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
                    }, S.of(context).settingTitle1, Icons.person),
                    listTileWidget(() {
                      context.pushNamed(Routes.changepasswordScreen);
                    }, S.of(context).settingTitle2, Icons.password_sharp),
                    listTileWidget(() async {
                      Uri url = Uri.parse('https://ai-cloud.sa');
                      await launchUrl(url);
                    }, S.of(context).settingTitle5,
                        Icons.desktop_windows_outlined),
                    listTileWidget(() {
                      context.pushNamed(Routes.languageScreen);
                    }, S.of(context).settingTitle6, Icons.language),
                    toggleListTile(
                      () {
                        cubit.toggleNotification();
                      },
                      S.of(context).settingTitle7,
                      Icons.notifications_active,
                      !cubit.isNotificationEnabled,
                    ),
                    ListTile(
                      onTap: () {
                        cubit.logout();
                      },
                      leading: Transform.flip(
                        flipX: cubit.isEnglish() ? true : false,
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
    });
  }
}
