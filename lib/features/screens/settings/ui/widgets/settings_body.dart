import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/features/screens/settings/ui/widgets/list_tile_widget.dart';
import 'package:smart_cleaning_application/features/screens/settings/ui/widgets/profile_widget.dart';
import 'package:smart_cleaning_application/features/screens/settings/ui/widgets/toggle_list_tile_widget.dart';

class SettingsBody extends StatefulWidget {
  const SettingsBody({super.key});

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  bool isSwitched = false;
  bool isDark = false;
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
            verticalSpace(35),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  listTileWidget(() {}, 'Change personal information',
                      Icons.edit_note_rounded),
                  listTileWidget(
                      () {}, 'Change password', Icons.password_sharp),
                  listTileWidget(() {}, 'Reports', Icons.file_copy_outlined),
                  listTileWidget(() {}, 'Contact us', Icons.phone),
                  listTileWidget(
                      () {}, 'Our Website', Icons.desktop_windows_outlined),
                  listTileWidget(() {}, 'Language', Icons.language),
                  toggleListTile(() {
                    setState(() {
                      isSwitched = !isSwitched;
                    });
                  }, 'Notification', Icons.notification_add_outlined,
                      isSwitched),
                  toggleListTile(() {
                    setState(() {
                      isDark = !isDark;
                    });
                  }, 'Theme', Icons.brightness_4_outlined, isDark),
                  ListTile(
                    onTap: () {},
                    leading: Transform.flip(
                      flipX: true,
                      child: Icon(
                        Icons.logout_outlined,
                        size: 20.sp,
                        color: Colors.red,
                      ),
                    ),
                    title: Text(
                      'Log out',
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
