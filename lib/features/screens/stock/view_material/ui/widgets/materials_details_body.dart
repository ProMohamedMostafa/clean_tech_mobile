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
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/row_details_build.dart';

import 'package:smart_cleaning_application/features/screens/stock/view_material/logic/cubit/material_details_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class MaterialDetailsBody extends StatefulWidget {
  final int id;
  const MaterialDetailsBody({super.key, required this.id});

  @override
  State<MaterialDetailsBody> createState() => _MaterialDetailsBodyState();
}

class _MaterialDetailsBodyState extends State<MaterialDetailsBody> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MaterialDetailsCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).materialDetails),
        leading: CustomBackButton(),
        actions: [
          IconButton(
              onPressed: () {
                context.pushNamed(Routes.editMaterialScreen,
                    arguments: widget.id);
              },
              icon: Icon(Icons.edit, color: AppColor.primaryColor))
        ],
      ),
      body: BlocConsumer<MaterialDetailsCubit, MaterialDetailsState>(
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
          if (cubit.materialDetailsModel == null) {
            return Loading();
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  rowDetailsBuild(context, S.of(context).name,
                      cubit.materialDetailsModel!.data!.name!),
                  Divider(
                    height: 30,
                  ),
                  rowDetailsBuild(context, S.of(context).category,
                      cubit.materialDetailsModel!.data!.categoryName!),
                  Divider(
                    height: 30,
                  ),
                  rowDetailsBuild(context, S.of(context).quantity,
                      cubit.materialDetailsModel!.data!.quantity.toString()),
                  Divider(
                    height: 30,
                  ),
                  rowDetailsBuild(
                      context,
                      S.of(context).minimum,
                      cubit.materialDetailsModel!.data!.minThreshold
                          .toString()),
                  Divider(
                    height: 30,
                  ),
                  Text(
                    S.of(context).description,
                    style: TextStyles.font16BlackSemiBold,
                  ),
                  verticalSpace(5),
                  Text(
                    cubit.materialDetailsModel!.data!.description!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: cubit.descTextShowFlag ? 40 : 3,
                    style: TextStyles.font14GreyRegular,
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                          borderRadius: BorderRadius.circular(5.r),
                          onTap: () {
                            cubit.toggleDescText();
                          },
                          child: cubit.descTextShowFlag
                              ? Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    S.of(context).ReadLessButton,
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 12),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    S.of(context).ReadMoreButton,
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 12),
                                  ),
                                ))),
                  verticalSpace(20),
                  state is DeleteMaterialLoadingState
                      ? Loading()
                      : Center(
                          child: DefaultElevatedButton(
                              name: S.of(context).deleteButton,
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return PopUpMessage(
                                          title: S.of(context).TitleDelete,
                                          body: S.of(context).material,
                                          onPressed: () {
                                            cubit.deleteMaterial(widget.id);
                                          });
                                    });
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
