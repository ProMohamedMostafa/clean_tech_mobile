import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/auditor/data/model/auditor_history_model.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AuditorHistory extends StatelessWidget {
  final List<AuditData> historyItems;

  const AuditorHistory({super.key, required this.historyItems});

  @override
  Widget build(BuildContext context) {
    return (historyItems.isEmpty)
        ? Center(
            child: Text(
              S.of(context).noData,
              style: TextStyles.font14BlackRegular,
            ),
          )
        : ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: historyItems.length,
            separatorBuilder: (context, index) => verticalSpace(10),
            itemBuilder: (context, index) {
              final item = historyItems[index];
              return Card(
                elevation: 1,
                margin: EdgeInsets.zero,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11.r),
                  side: BorderSide(color: Colors.grey[300]!),
                ),
                child: Container(
                  height: 50.h,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.time!, style: TextStyles.font14Primarybold),
                      Text(item.date!, style: TextStyles.font14Primarybold),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
