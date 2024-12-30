import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/add_organizations/logic/add_organization_cubit.dart';
import 'package:smart_cleaning_application/features/screens/add_organizations/logic/add_organization_state.dart';
import 'package:smart_cleaning_application/features/screens/add_organizations/ui/widgets/organization_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/add_organizations/ui/widgets/add_area_dialog.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AddOrganizationBody extends StatefulWidget {
  const AddOrganizationBody({super.key});

  @override
  State<AddOrganizationBody> createState() => _AddOrganizationBodyState();
}

class _AddOrganizationBodyState extends State<AddOrganizationBody> {
  @override
  void initState() {
    context.read<AddOrganizationCubit>().getNationality();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Organization',
          style: TextStyles.font16BlackSemiBold,
        ),
        centerTitle: true,
        leading: customBackButton(context),
      ),
      body: BlocConsumer<AddOrganizationCubit, AddOrganizationState>(
        listener: (context, state) {
          if (state is CreateAreaSuccessState) {
            toast(text: state.message, color: Colors.blue);
            context.pop();
          }
          if (state is CreateCitySuccessState) {
            toast(text: state.message, color: Colors.blue);
            context.pop();
          }
          if (state is CreateAreaErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is CreateCityErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          return SafeArea(
              child: SingleChildScrollView(
            child: Form(
              key: context.read<AddOrganizationCubit>().formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(15),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 100.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // color: Colors.white,
                                border: Border.all(
                                    color: AppColor.primaryColor, width: 3.w)),
                            child: ClipOval(
                                child: Image.asset(
                              'assets/images/noImage.png',
                              fit: BoxFit.fill,
                            )),
                          ),
                          Positioned(
                            bottom: 1,
                            right: 10,
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                  width: 22.w,
                                  height: 22.h,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColor.primaryColor),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                    size: 20.sp,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                    verticalSpace(35),
                    Text(
                      S.of(context).addUserText12,
                      style: TextStyles.font16BlackRegular,
                    ),
                    OrganizationTextFormField(
                      hint: "Select country",
                      items: context
                                  .read<AddOrganizationCubit>()
                                  .nationalityModel
                                  ?.data
                                  ?.isEmpty ??
                              true
                          ? ['No country']
                          : context
                                  .read<AddOrganizationCubit>()
                                  .nationalityModel
                                  ?.data
                                  ?.map((e) => e.name ?? 'Unknown')
                                  .toList() ??
                              [],
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value == 'No country') {
                          return S.of(context).validationNationality;
                        }
                      },
                      onChanged: (value) {
                        context
                            .read<AddOrganizationCubit>()
                            .nationalityController
                            .text = value!;
                        context.read<AddOrganizationCubit>().getArea(value);
                      },
                      suffixIcon: IconBroken.arrowDown2,
                      controller: context
                          .read<AddOrganizationCubit>()
                          .nationalityController,
                      readOnly: false,
                      keyboardType: TextInputType.text,
                    ),
                    verticalSpace(10),
                    Text(
                      "Area",
                      style: TextStyles.font16BlackRegular,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: OrganizationTextFormField(
                            hint: "Select area",
                            items: context
                                        .read<AddOrganizationCubit>()
                                        .areaModel
                                        ?.data
                                        ?.isEmpty ??
                                    true
                                ? ['No areas']
                                : context
                                        .read<AddOrganizationCubit>()
                                        .areaModel
                                        ?.data
                                        ?.map((e) => e.name ?? 'Unknown')
                                        .toList() ??
                                    [],
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == 'No areas') {
                                return "Area is required";
                              }
                            },
                            onChanged: (value) {
                              final selectedArea = context
                                  .read<AddOrganizationCubit>()
                                  .areaModel
                                  ?.data
                                  ?.firstWhere((area) =>
                                      area.name ==
                                      context
                                          .read<AddOrganizationCubit>()
                                          .areaController
                                          .text);

                              context
                                  .read<AddOrganizationCubit>()
                                  .getCity(selectedArea!.id!);
                            },
                            suffixIcon: IconBroken.arrowDown2,
                            controller: context
                                .read<AddOrganizationCubit>()
                                .areaController,
                            readOnly: false,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        horizontalSpace(10),
                        SizedBox(
                          height: 49.h,
                          child: ElevatedButton(
                            onPressed: () {
                              final cubit =
                                  context.read<AddOrganizationCubit>();
                              AddAreaBottomDialog()
                                  .showBottomDialog(context, cubit);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: REdgeInsets.all(0),
                              backgroundColor: AppColor.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              side: BorderSide(
                                color: AppColor.secondaryColor,
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.add_circle_outline_sharp,
                              color: Colors.white,
                              size: 22.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                    verticalSpace(10),
                    Text(
                      "City",
                      style: TextStyles.font16BlackRegular,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: OrganizationTextFormField(
                            hint: "Select city",
                            items: context
                                        .read<AddOrganizationCubit>()
                                        .cityModel
                                        ?.data
                                        ?.isEmpty ??
                                    true
                                ? ['No cities']
                                : context
                                        .read<AddOrganizationCubit>()
                                        .cityModel
                                        ?.data
                                        ?.map((e) => e.name ?? 'Unknown')
                                        .toList() ??
                                    [],
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == 'No cities') {
                                return "City is required";
                              }
                            },
                            onChanged: (value) {
                              final selectedCity = context
                                  .read<AddOrganizationCubit>()
                                  .cityModel
                                  ?.data
                                  ?.firstWhere((city) =>
                                      city.name ==
                                      context
                                          .read<AddOrganizationCubit>()
                                          .cityController
                                          .text);

                              context
                                  .read<AddOrganizationCubit>()
                                  .getOrganization(selectedCity!.id!);
                            },
                            suffixIcon: IconBroken.arrowDown2,
                            controller: context
                                .read<AddOrganizationCubit>()
                                .cityController,
                            readOnly: false,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        horizontalSpace(10),
                        SizedBox(
                          height: 49.h,
                          child: ElevatedButton(
                            onPressed: () {
                              context.pushNamed(Routes.addCityScreen);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: REdgeInsets.all(0),
                              backgroundColor: AppColor.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              side: BorderSide(
                                color: AppColor.secondaryColor,
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.add_circle_outline_sharp,
                              color: Colors.white,
                              size: 22.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                    verticalSpace(10),
                    Text(
                      "Organizations",
                      style: TextStyles.font16BlackRegular,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: OrganizationTextFormField(
                            hint: "Select organizations",
                            items: context
                                        .read<AddOrganizationCubit>()
                                        .organizationModel
                                        ?.data
                                        ?.isEmpty ??
                                    true
                                ? ['No organizations']
                                : context
                                        .read<AddOrganizationCubit>()
                                        .organizationModel
                                        ?.data
                                        ?.map((e) => e.name ?? 'Unknown')
                                        .toList() ??
                                    [],
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == 'No organizations') {
                                return "Organizations is required";
                              }
                            },
                            onChanged: (value) {
                              final selectedOrganization = context
                                  .read<AddOrganizationCubit>()
                                  .organizationModel
                                  ?.data
                                  ?.firstWhere((organization) =>
                                      organization.name ==
                                      context
                                          .read<AddOrganizationCubit>()
                                          .organizationController
                                          .text);

                              context
                                  .read<AddOrganizationCubit>()
                                  .getBuilding(selectedOrganization!.id!);
                            },
                            suffixIcon: IconBroken.arrowDown2,
                            controller: context
                                .read<AddOrganizationCubit>()
                                .organizationController,
                            readOnly: false,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        horizontalSpace(10),
                        SizedBox(
                          height: 49.h,
                          child: ElevatedButton(
                            onPressed: () {
                              context.pushNamed(
                                  Routes.addOrganizationDetailsScreen);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: REdgeInsets.all(0),
                              backgroundColor: AppColor.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              side: BorderSide(
                                color: AppColor.secondaryColor,
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.add_circle_outline_sharp,
                              color: Colors.white,
                              size: 22.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                    verticalSpace(10),
                    Text(
                      "Building",
                      style: TextStyles.font16BlackRegular,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: OrganizationTextFormField(
                            hint: "Select building",
                            items: context
                                        .read<AddOrganizationCubit>()
                                        .buildingModel
                                        ?.data
                                        ?.isEmpty ??
                                    true
                                ? ['No building']
                                : context
                                        .read<AddOrganizationCubit>()
                                        .buildingModel
                                        ?.data
                                        ?.map((e) => e.name ?? 'Unknown')
                                        .toList() ??
                                    [],
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == 'No building') {
                                return "Building is required";
                              }
                            },
                            onChanged: (value) {
                              final selectedBuilding = context
                                  .read<AddOrganizationCubit>()
                                  .buildingModel
                                  ?.data
                                  ?.firstWhere((building) =>
                                      building.name ==
                                      context
                                          .read<AddOrganizationCubit>()
                                          .buildingController
                                          .text);

                              context
                                  .read<AddOrganizationCubit>()
                                  .getFloor(selectedBuilding!.id!);
                            },
                            suffixIcon: IconBroken.arrowDown2,
                            controller: context
                                .read<AddOrganizationCubit>()
                                .buildingController,
                            readOnly: false,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        horizontalSpace(10),
                        SizedBox(
                          height: 49.h,
                          child: ElevatedButton(
                            onPressed: () {
                              context.pushNamed(Routes.addBuildingScreen);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: REdgeInsets.all(0),
                              backgroundColor: AppColor.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              side: BorderSide(
                                color: AppColor.secondaryColor,
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.add_circle_outline_sharp,
                              color: Colors.white,
                              size: 22.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                    verticalSpace(10),
                    Text(
                      "Floor",
                      style: TextStyles.font16BlackRegular,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: OrganizationTextFormField(
                            hint: "Select floor",
                            items: context
                                        .read<AddOrganizationCubit>()
                                        .floorModel
                                        ?.data
                                        ?.isEmpty ??
                                    true
                                ? ['No floors']
                                : context
                                        .read<AddOrganizationCubit>()
                                        .floorModel
                                        ?.data
                                        ?.map((e) => e.name ?? 'Unknown')
                                        .toList() ??
                                    [],
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == 'No floors') {
                                return "Floor is required";
                              }
                            },
                            onChanged: (value) {
                              final selectedFloor = context
                                  .read<AddOrganizationCubit>()
                                  .floorModel
                                  ?.data
                                  ?.firstWhere((floor) =>
                                      floor.name ==
                                      context
                                          .read<AddOrganizationCubit>()
                                          .floorController
                                          .text);

                              context
                                  .read<AddOrganizationCubit>()
                                  .getPoints(selectedFloor!.id!);
                            },
                            suffixIcon: IconBroken.arrowDown2,
                            controller: context
                                .read<AddOrganizationCubit>()
                                .floorController,
                            readOnly: false,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        horizontalSpace(10),
                        SizedBox(
                          height: 49.h,
                          child: ElevatedButton(
                            onPressed: () {
                              context.pushNamed(Routes.addFloorScreen);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: REdgeInsets.all(0),
                              backgroundColor: AppColor.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              side: BorderSide(
                                color: AppColor.secondaryColor,
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.add_circle_outline_sharp,
                              color: Colors.white,
                              size: 22.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                    verticalSpace(10),
                    Text(
                      "Point",
                      style: TextStyles.font16BlackRegular,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: OrganizationTextFormField(
                            hint: "Select point",
                            items: context
                                        .read<AddOrganizationCubit>()
                                        .pointsModel
                                        ?.data
                                        ?.isEmpty ??
                                    true
                                ? ['No point']
                                : context
                                        .read<AddOrganizationCubit>()
                                        .pointsModel
                                        ?.data
                                        ?.map((e) => e.name ?? 'Unknown')
                                        .toList() ??
                                    [],
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == 'No point') {
                                return "Point is required";
                              }
                            },
                            suffixIcon: IconBroken.arrowDown2,
                            controller: context
                                .read<AddOrganizationCubit>()
                                .pointController,
                            readOnly: false,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        horizontalSpace(10),
                        SizedBox(
                          height: 49.h,
                          child: ElevatedButton(
                            onPressed: () {
                              context.pushNamed(Routes.addPointScreen);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: REdgeInsets.all(0),
                              backgroundColor: AppColor.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              side: BorderSide(
                                color: AppColor.secondaryColor,
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.add_circle_outline_sharp,
                              color: Colors.white,
                              size: 22.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                    verticalSpace(10),
                    Text(
                      "Manager Name",
                      style: TextStyles.font16BlackRegular,
                    ),
                    OrganizationTextFormField(
                      hint: "Select manager",
                      items: context
                                  .read<AddOrganizationCubit>()
                                  .usersModel
                                  ?.data
                                  ?.isEmpty ??
                              true
                          ? ['No manager']
                          : context
                                  .read<AddOrganizationCubit>()
                                  .usersModel
                                  ?.data
                                  ?.map((e) => e.userName ?? 'Unknown')
                                  .toList() ??
                              [],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).validationManager;
                        }
                      },
                      suffixIcon: IconBroken.arrowDown2,
                      controller: context
                          .read<AddOrganizationCubit>()
                          .managerNameController,
                      readOnly: false,
                      keyboardType: TextInputType.text,
                    ),
                    verticalSpace(20),
                    state is AddOrganizationLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(
                                color: AppColor.primaryColor),
                          )
                        : Center(
                            child: DefaultElevatedButton(
                                name: S.of(context).saveButtton,
                                onPressed: () {
                                  if (context
                                      .read<AddOrganizationCubit>()
                                      .formKey
                                      .currentState!
                                      .validate()) {
                                    // context.read<AddOrganizationCubit>().addUser();
                                  }
                                },
                                color: AppColor.primaryColor,
                                height: 47,
                                width: double.infinity,
                                textStyles: TextStyles.font20Whitesemimedium),
                          ),
                    verticalSpace(30),
                  ],
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}
