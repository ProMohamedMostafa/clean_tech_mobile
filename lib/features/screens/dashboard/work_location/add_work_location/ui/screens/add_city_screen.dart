import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/custom_multi_dropdown/custom_multi_dropdown.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/core/widgets/custom_drop_down_list/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/core/widgets/default_text_form_field/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/add_work_location/logic/add_work_location_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/add_work_location/logic/add_work_location_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AddCityScreen extends StatelessWidget {
  const AddCityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddWorkLocationCubit>();
    return Scaffold(
      appBar: AppBar(
          leading: CustomBackButton(), title: Text(S.of(context).addCity)),
      body: SingleChildScrollView(
          child: BlocConsumer<AddWorkLocationCubit, AddWorkLocationState>(
        listener: (context, state) {
          if (state is CreateCitySuccessState) {
            toast(text: state.message, isSuccess: true);
            context.popWithTrueResult();
          }
          if (state is CreateCityErrorState) {
            toast(text: state.error, isSuccess: false);
          }
        },
        builder: (context, state) {
          if (cubit.usersModel == null || cubit.nationalityListModel == null) {
            return Loading();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: cubit.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailsField(context, cubit),
                  verticalSpace(20),
                  _buildContinueButton(context, cubit, state),
                  verticalSpace(20),
                ],
              ),
            ),
          );
        },
      )),
    );
  }

  Widget _buildDetailsField(BuildContext context, AddWorkLocationCubit cubit) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(S.of(context).addUserText12,
              style: TextStyles.font16BlackRegular),
          CustomDropDownList(
            hint: S.of(context).selectCountry,
            items:
                cubit.nationalityData.map((e) => e.name ?? 'un known').toList(),
            onChanged: (value) {
              cubit.getArea();
            },
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  value == S.of(context).noCountry) {
                return S.of(context).validationNationality;
              }
              return null;
            },
            suffixIcon: IconBroken.arrowDown2,
            controller: cubit.nationalityController,
            isRead: false,
            keyboardType: TextInputType.text,
          ),
          verticalSpace(10),
          Text(S.of(context).areaName, style: TextStyles.font16BlackRegular),
          CustomDropDownList(
            hint: S.of(context).selectArea,
            controller: cubit.areaController,
            items: cubit.areaItem.map((e) => e.name ?? 'Unknown').toList(),
            onChanged: (value) {
              final selectedArea = cubit.areaListModel?.data?.data
                  ?.firstWhere((area) => area.name == cubit.areaController.text)
                  .id
                  ?.toString();

              if (selectedArea != null) {
                cubit.areaIdController.text = selectedArea;
              }
            },
            suffixIcon: IconBroken.arrowDown2,
            keyboardType: TextInputType.text,
          ),
          verticalSpace(10),
          Text(
            S.of(context).cityName,
            style: TextStyles.font16BlackRegular,
          ),
          CustomTextFormField(
            controller: cubit.addCityController,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).cityNameRequired;
              } else if (value.length > 55) {
                return S.of(context).cityNameTooLong;
              } else if (value.length < 3) {
                return S.of(context).cityNameTooShort;
              }
              return null;
            },
            hint: '',
            onlyRead: false,
          ),
          verticalSpace(10),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: S.of(context).managers,
                  style: TextStyles.font16BlackRegular,
                ),
                TextSpan(
                  text: S.of(context).labelOptional,
                  style: TextStyles.font14GreyRegular,
                ),
              ],
            ),
          ),
          CustomMultiDropdown(
            items: cubit.usersModel!.data!.users!
                    .where((user) => user.role == 'Manager')
                    .isEmpty
                ? [
                    DropdownItem(
                      label: S.of(context).noManagers,
                      value: UserItem(
                          id: null, userName: S.of(context).noManagers),
                    )
                  ]
                : cubit.usersModel!.data!.users!
                    .where((user) => user.role == 'Manager')
                    .map((manager) => DropdownItem(
                          label: manager.userName!,
                          value: manager,
                        ))
                    .toList(),
            controller: cubit.allManagersController,
            onSelectionChange: (selectedItems) {
              cubit.selectedManagersIds =
                  selectedItems.map((item) => (item).id!).toList();
            },
            hint: S.of(context).selectManagers,
          ),
          verticalSpace(10),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: S.of(context).supervisors,
                  style: TextStyles.font16BlackRegular,
                ),
                TextSpan(
                  text: S.of(context).labelOptional,
                  style: TextStyles.font14GreyRegular,
                ),
              ],
            ),
          ),
          CustomMultiDropdown(
            items: cubit.usersModel!.data!.users!
                    .where((user) => user.role == 'Supervisor')
                    .isEmpty
                ? [
                    DropdownItem(
                      label: S.of(context).noSupervisors,
                      value: UserItem(
                          id: null, userName: S.of(context).noSupervisors),
                    )
                  ]
                : cubit.usersModel!.data!.users!
                    .where((user) => user.role == 'Supervisor')
                    .map((supervisor) => DropdownItem(
                          label: supervisor.userName!,
                          value: supervisor,
                        ))
                    .toList(),
            controller: cubit.allSupervisorsController,
            onSelectionChange: (selectedItems) {
              cubit.selectedSupervisorsIds =
                  selectedItems.map((item) => (item).id!).toList();
            },
            hint: S.of(context).selectSupervisors,
          ),
          verticalSpace(10),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: S.of(context).cleaners,
                  style: TextStyles.font16BlackRegular,
                ),
                TextSpan(
                  text: S.of(context).labelOptional,
                  style: TextStyles.font14GreyRegular,
                ),
              ],
            ),
          ),
          CustomMultiDropdown(
            items: cubit.usersModel!.data!.users!
                    .where((user) => user.role == 'Cleaner')
                    .isEmpty
                ? [
                    DropdownItem(
                      label: S.of(context).noCleaners,
                      value: UserItem(
                          id: null, userName: S.of(context).noCleaners),
                    )
                  ]
                : cubit.usersModel!.data!.users!
                    .where((user) => user.role == 'Cleaner')
                    .map((cleaner) => DropdownItem(
                          label: cleaner.userName!,
                          value: cleaner,
                        ))
                    .toList(),
            controller: cubit.allCleanersController,
            onSelectionChange: (selectedItems) {
              cubit.selectedCleanersIds =
                  selectedItems.map((item) => (item).id!).toList();
            },
            hint: S.of(context).selectCleaners,
          ),
          verticalSpace(10),
        ]);
  }

  Widget _buildContinueButton(BuildContext context, AddWorkLocationCubit cubit,
      AddWorkLocationState state) {
    return state is CreateCityLoadingState
        ? Loading()
        : DefaultElevatedButton(
            name: S.of(context).addButton,
            onPressed: () {
              if (cubit.formKey.currentState!.validate()) {
                cubit.createCity();
              }
            },
            color: AppColor.primaryColor,
            textStyles: TextStyles.font20Whitesemimedium,
          );
  }
}
