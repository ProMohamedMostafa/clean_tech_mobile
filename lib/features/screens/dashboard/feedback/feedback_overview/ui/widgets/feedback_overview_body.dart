import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_overview/logic/cubit/feedback_overview_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_overview/ui/widgets/graph_feedback_overview/feedback_quantity_body.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_overview/ui/widgets/overview_cards.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_overview/ui/widgets/system_overview_graph.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_overview/ui/widgets/table_overview_part.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class FeedbackOverviewBody extends StatelessWidget {
  const FeedbackOverviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).feedback_overview),
        leading: CustomBackButton(),
      ),
      body: BlocConsumer<FeedbackOverviewCubit, FeedbackOverviewState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  OverviewCards(),
                  verticalSpace(10),
                  FeedbackQuantityBody(),
                  verticalSpace(10),
                  SystemOverviewGraph(),
                  verticalSpace(10),
                  BuildingsOverviewTable(),
                  verticalSpace(10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
