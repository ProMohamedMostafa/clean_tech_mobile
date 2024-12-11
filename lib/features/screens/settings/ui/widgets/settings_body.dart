import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/features/screens/settings/ui/widgets/list_tile_widget.dart';
import 'package:smart_cleaning_application/features/screens/settings/ui/widgets/profile_widget.dart';
import 'package:smart_cleaning_application/features/screens/settings/ui/widgets/toggle_list_tile_widget.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';
import 'package:smart_cleaning_application/src/app_cubit/app_cubit.dart';

class SettingsBody extends StatefulWidget {
  const SettingsBody({super.key});

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  bool isSwitched = false;
  bool isDark = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            profileWidget(),
            verticalSpace(15),
            Text('Mosad Selim', style: TextStyles.font20BlacksemiBold),
            Text('Admin', style: TextStyles.font14GreyRegular),
            verticalSpace(25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  listTileWidget(() {}, S.of(context).settingTitle1,
                      Icons.edit_note_rounded),
                  listTileWidget(
                      () {}, S.of(context).settingTitle2, Icons.password_sharp),
                  listTileWidget(() {}, S.of(context).settingTitle3,
                      Icons.file_copy_outlined),
                  listTileWidget(
                      () {}, S.of(context).settingTitle4, Icons.phone),
                  listTileWidget(() {}, S.of(context).settingTitle5,
                      Icons.desktop_windows_outlined),
                  listTileWidget(
                      () {}, S.of(context).settingTitle6, Icons.language),
                  toggleListTile(() {
                    setState(() {
                      isSwitched = !isSwitched;
                    });
                  }, S.of(context).settingTitle7,
                      Icons.notification_add_outlined, isSwitched),
                  toggleListTile(() {
                    setState(() {
                      isDark = !isDark;
                    });
                  }, S.of(context).settingTitle8, Icons.brightness_4_outlined,
                      isDark),
                  ListTile(
                    onTap: () {},
                    leading: Transform.flip(
                      flipX: context.read<AppCubit>().isArabic() ? false : true,
                      child: Icon(
                        Icons.logout_outlined,
                        size: 20.sp,
                        color: Colors.red,
                      ),
                    ),
                    title: Text(
                      S.of(context).settingTitle9,
                      style: TextStyles.font14Redbold,
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
  }
}
