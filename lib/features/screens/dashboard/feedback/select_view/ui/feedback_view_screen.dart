import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  Widget feedbackTile(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColor.secondaryColor),
      ),
      child: ListTile(
        minTileHeight: 70.h,
        dense: true,
        leading: Icon(icon, color: AppColor.primaryColor),
        title: Text(title, style: TextStyles.font16PrimSemiBold),
        trailing: Icon(Icons.arrow_forward_ios, color: AppColor.primaryColor),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(S.of(context).feedback), leading: CustomBackButton()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            verticalSpace(20),
            feedbackTile(
              context,
              Icons.question_answer_outlined,
              S.of(context).question,
              () => context.pushNamed(Routes.questionScreen),
            ),
            verticalSpace(10),
            feedbackTile(
              context,
              Icons.feed_outlined,
              S.of(context).feedbackAndAudit,
              () => context.pushNamed(Routes.feedbackAndAuditViewScreen),
            ),
            verticalSpace(10),
            feedbackTile(
              context,
              Icons.devices,
              S.of(context).devices,
              () => context.pushNamed(Routes.devicesScreen),
            ),
          ],
        ),
      ),
    );
  }
}
