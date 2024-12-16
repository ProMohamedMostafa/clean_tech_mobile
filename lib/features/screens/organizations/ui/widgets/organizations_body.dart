import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/features/screens/organizations/ui/widgets/add_organization_build.dart';
import 'package:smart_cleaning_application/features/screens/organizations/ui/widgets/organization_details.dart';
import 'package:smart_cleaning_application/features/screens/organizations/ui/widgets/organization_graph.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OrganizationsBody extends StatefulWidget {
  const OrganizationsBody({super.key});

  @override
  State<OrganizationsBody> createState() => _OrganizationsBodyState();
}

class _OrganizationsBodyState extends State<OrganizationsBody> {
  TooltipBehavior? _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  final List<ChartData> chartData = [
    ChartData('Egypt', 20),
    ChartData('Palestine', 25),
    ChartData('Emirats', 30),
    ChartData('Saudia', 45),
    ChartData('Qatar', 40),
    ChartData('Oman', 50),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Number of Area in Countries",
                style: TextStyles.font20BlacksemiBold,
              ),
              verticalSpace(15),
              graph(_tooltipBehavior, chartData),
              verticalSpace(20),
              Text(
                "Add Organization",
                style: TextStyles.font20BlacksemiBold,
              ),
              verticalSpace(10),
              addOrganizationBuild(context),
              verticalSpace(30),
              Text(
                "Organization Details",
                style: TextStyles.font20BlacksemiBold,
              ),
              verticalSpace(5),
              organizationsDetails(context)
            ],
          ),
        ),
      )),
    );
  }
}
