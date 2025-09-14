import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/custom_row/row_details_build.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/auditor/logic/cubit/auditor_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/auditor/ui/widget/auditor_history.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AuditLocationDetailsScreen extends StatelessWidget {
  final int id;
  const AuditLocationDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text(S.of(context).section_details),
      ),
      body: BlocBuilder<AuditorCubit, AuditorState>(
        builder: (context, state) {
          final cubit = context.read<AuditorCubit>();
          if (cubit.auditLocationDetailsModel?.data == null ||
              cubit.auditorHistory?.data == null) {
            return Loading();
          }
          final details = cubit.auditLocationDetailsModel!.data!;
          final historyData = cubit.auditorHistory!.data!.data!;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  rowDetailsBuild(
                      context, S.of(context).country, details.countryName!),
                  Divider(),
                  rowDetailsBuild(
                      context, S.of(context).Area, details.areaName!),
                  Divider(),
                  rowDetailsBuild(
                      context, S.of(context).City, details.cityName!),
                  Divider(),
                  rowDetailsBuild(context, S.of(context).Organization,
                      details.organizationName!),
                  Divider(),
                  rowDetailsBuild(
                      context, S.of(context).Building, details.buildingName!),
                  Divider(),
                  rowDetailsBuild(
                      context, S.of(context).Floor, details.floorName!),
                  Divider(),
                  rowDetailsBuild(context, S.of(context).Section, details.name!,
                      leadingColor: AppColor.primaryColor,
                      suffixColor: AppColor.primaryColor),
                  Divider(),
                  rowDetailsBuild(
                      context, S.of(context).audit, details.auditName!,
                      leadingColor: AppColor.primaryColor,
                      suffixColor: AppColor.primaryColor),
                  Divider(),
                  Text(
                    S.of(context).description,
                    style: TextStyles.font14GreyRegular
                        .copyWith(color: Colors.black),
                  ),
                  verticalSpace(5),
                  Text(
                    details.description!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: cubit.descTextShowFlag ? 40 : 3,
                    style: TextStyles.font14GreyRegular,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(5.r),
                      onTap: () => cubit.toggleDescText(),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          cubit.descTextShowFlag
                              ? S.of(context).ReadLessButton
                              : S.of(context).ReadMoreButton,
                          style:
                              const TextStyle(color: Colors.blue, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  verticalSpace(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 105.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(S.of(context).audit_history,
                                style: TextStyles.font16PrimSemiBold),
                            Container(
                              margin: const EdgeInsets.only(top: 2),
                              height: 2.h,
                              color: AppColor.primaryColor,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 130.w,
                        height: 40.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                          onPressed: () {
                            context.pushNamed(Routes.auditorQuestionsScreen,
                                arguments: id);
                          },
                          child: Text(S.of(context).start,
                              style: TextStyles.font16WhiteSemiBold),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(15),
                  AuditorHistory(historyItems: historyData),
                  verticalSpace(20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
