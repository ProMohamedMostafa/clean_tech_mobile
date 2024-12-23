import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/features/screens/organizations/logic/organizations_cubit.dart';
import 'package:smart_cleaning_application/features/screens/organizations/logic/organizations_states.dart';
import 'package:smart_cleaning_application/features/screens/organizations/ui/widgets/add_organization_build.dart';
import 'package:smart_cleaning_application/features/screens/organizations/ui/widgets/data_view_build.dart';
import 'package:smart_cleaning_application/features/screens/organizations/ui/widgets/organization_details.dart';

class OrganizationsBody extends StatefulWidget {
  const OrganizationsBody({super.key});

  @override
  State<OrganizationsBody> createState() => _OrganizationsBodyState();
}

class _OrganizationsBodyState extends State<OrganizationsBody> {
  // TooltipBehavior? _tooltipBehavior;
  // @override
  // void initState() {
  //   _tooltipBehavior = TooltipBehavior(enable: true);
  //   super.initState();
  // }

  // final List<ChartData> chartData = [
  //   ChartData('EGY', 20),
  //   ChartData('PAL', 25),
  //   ChartData('UEA', 30),
  //   ChartData('KSA', 45),
  //   ChartData('QAT', 40),
  //   ChartData('OMA', 50),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
      ),
      body: BlocProvider(
        create: (context) => OrganizationsCubit(),
        child: BlocConsumer<OrganizationsCubit, OrganizationsState>(
          listener: (context, state) {},
          builder: (context, state) {
            return SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addOrganizationBuild(context),
                    verticalSpace(20),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [

                    // Text(
                    //   "Countries overview",
                    //   style: TextStyles.font18PrimBold,
                    // ),
                    //     Spacer(),
                    //     Text(
                    //       "Weekly",
                    //       style: TextStyles.font12GreyRegular,
                    //     ),
                    //     Icon(
                    //       Icons.keyboard_arrow_down_rounded,
                    //       size: 20.sp,
                    //       color: AppColor.thirdColor,
                    //     )
                    //   ],
                    // ),

                    // graph(_tooltipBehavior, chartData),
                    // verticalSpace(25),
                    Text(
                      "Organization Details",
                      style: TextStyles.font18PrimBold,
                    ),
                    verticalSpace(10),
                    dataViewOrgnizationBuild(),
                    verticalSpace(15),
                    organizationsDetails(
                        context.read<OrganizationsCubit>(), context),
                  ],
                ),
              ),
            ));
          },
        ),
      ),
    );
  }
}
