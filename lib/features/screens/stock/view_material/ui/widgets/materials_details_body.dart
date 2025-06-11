import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/row_details_build.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/logic/material_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/logic/material_mangement_state.dart';

class MaterialDetailsBody extends StatefulWidget {
  final int id;
  const MaterialDetailsBody({super.key, required this.id});

  @override
  State<MaterialDetailsBody> createState() => _MaterialDetailsBodyState();
}

class _MaterialDetailsBodyState extends State<MaterialDetailsBody> {
  @override
  void initState() {
    context.read<MaterialManagementCubit>().getMaterialDetails(widget.id);
    super.initState();
  }

  bool descTextShowFlag = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Material details"),
        leading: customBackButton(context),
        actions: [
          IconButton(
              onPressed: () {
                context.pushNamed(Routes.editMaterialScreen,
                    arguments: widget.id);
              },
              icon: Icon(
                Icons.edit,
                color: AppColor.primaryColor,
              ))
        ],
      ),
      body: BlocConsumer<MaterialManagementCubit, MaterialManagementState>(
        listener: (context, state) {
          if (state is DeleteMaterialSuccessState) {
            toast(text: state.deleteMaterialModel.message!, color: Colors.blue);
            context.pushNamedAndRemoveUntil(
              Routes.materialScreen,
              predicate: (route) => false,
            );
          }
          if (state is DeleteMaterialErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          if (context.read<MaterialManagementCubit>().materialDetailsModel ==
              null) {
           return Loading();
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  rowDetailsBuild(
                      context,
                      'Name',
                      context
                          .read<MaterialManagementCubit>()
                          .materialDetailsModel!
                          .data!
                          .name!),
                  Divider(
                    height: 30,
                  ),
                  rowDetailsBuild(
                      context,
                      'Category',
                      context
                          .read<MaterialManagementCubit>()
                          .materialDetailsModel!
                          .data!
                          .categoryName!),
                  Divider(
                    height: 30,
                  ),
                  rowDetailsBuild(
                      context,
                      'Quantity',
                      context
                          .read<MaterialManagementCubit>()
                          .materialDetailsModel!
                          .data!
                          .quantity
                          .toString()),
                  Divider(
                    height: 30,
                  ),
                  rowDetailsBuild(
                      context,
                      'Minimum',
                      context
                          .read<MaterialManagementCubit>()
                          .materialDetailsModel!
                          .data!
                          .minThreshold
                          .toString()),
                  Divider(
                    height: 30,
                  ),
                  Text(
                    'Description',
                    style: TextStyles.font16BlackSemiBold,
                  ),
                  verticalSpace(5),
                  Text(
                    context
                        .read<MaterialManagementCubit>()
                        .materialDetailsModel!
                        .data!
                        .description!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: descTextShowFlag ? 40 : 3,
                    style: TextStyles.font14GreyRegular,
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                          borderRadius: BorderRadius.circular(5.r),
                          onTap: () {
                            setState(() {
                              descTextShowFlag = !descTextShowFlag;
                            });
                          },
                          child: descTextShowFlag
                              ? Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: const Text(
                                    "Read less",
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 12),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: const Text(
                                    "Read more",
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 12),
                                  ),
                                ))),
                  verticalSpace(20),
                  state is DeleteMaterialLoadingState
                      ? Loading()
                      : Center(
                          child: DefaultElevatedButton(
                              name: 'Delete',
                              onPressed: () {
                                context
                                    .read<MaterialManagementCubit>()
                                    .deleteMaterial(widget.id);
                              },
                              color: Colors.red,
                              height: 47,
                              width: double.infinity,
                              textStyles: TextStyles.font20Whitesemimedium),
                        ),
                  verticalSpace(20)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
