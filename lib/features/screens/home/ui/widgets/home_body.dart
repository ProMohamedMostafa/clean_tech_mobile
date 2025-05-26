import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/clock_in_out_body.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/graph_complete_task/complete_tasks_rate_body.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/home_app_bar.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/home_statistics_cards/shift.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/home_statistics_cards/show_activity.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/home_statistics_cards/stock.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/graph_stock/stock_quantity_body.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/graph_total_tasks/total_task_body.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/home_statistics_cards/tasks.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/home_statistics_cards/users_attendance.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpace(5),
              HomeAppBar(),
              verticalSpace(15),
              if (role != 'Admin') ...[
                ClockInOutBody(),
                verticalSpace(10),
              ],
              ShowActivity(),
              verticalSpace(10),
              Stock(),
              verticalSpace(10),
              UsersAttendance(),
              verticalSpace(10),
              Shift(),
              verticalSpace(10),
              if (role != 'Admin') ...[
                Tasks(),
                verticalSpace(10),
              ],
              StockQuantityBody(),
              verticalSpace(10),
              CompleteTasksRateBody(),
              verticalSpace(10),
              TotalTaskBody(),
              verticalSpace(10),
            ],
          ),
        ),
      ),
    );
  }
}
