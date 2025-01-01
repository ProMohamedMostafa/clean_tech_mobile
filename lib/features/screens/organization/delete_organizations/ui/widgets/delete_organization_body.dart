import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/organization/delete_organizations/logic/delete_organization_cubit.dart';
import 'package:smart_cleaning_application/features/screens/organization/delete_organizations/logic/delete_organization_state.dart';
import 'package:smart_cleaning_application/features/screens/organization/delete_organizations/ui/widgets/delete_organization_list.dart';

class DeleteOrganizationBody extends StatefulWidget {
  final int selectedIndex;
  const DeleteOrganizationBody({super.key, required this.selectedIndex});

  @override
  State<DeleteOrganizationBody> createState() => _DeleteOrganizationBodyState();
}

class _DeleteOrganizationBodyState extends State<DeleteOrganizationBody> {
  @override
  void initState() {
    widget.selectedIndex == 0
        ? context.read<DeleteOrganizationsCubit>().getAllDeletedArea()
        : widget.selectedIndex == 1
            ? context.read<DeleteOrganizationsCubit>().getAllDeletedCity()
            : widget.selectedIndex == 2
                ? context
                    .read<DeleteOrganizationsCubit>()
                    .getAllDeletedOrganization()
                : widget.selectedIndex == 3
                    ? context
                        .read<DeleteOrganizationsCubit>()
                        .getAllDeletedBuilding()
                    : widget.selectedIndex == 4
                        ? context
                            .read<DeleteOrganizationsCubit>()
                            .getAllDeletedFloor()
                        : context
                            .read<DeleteOrganizationsCubit>()
                            .getAllDeletedPoint();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text(
            widget.selectedIndex == 0
                ? 'Deleted Areas'
                : widget.selectedIndex == 1
                    ? 'Deleted Cities'
                    : widget.selectedIndex == 2
                        ? 'Deleted Organizations'
                        : widget.selectedIndex == 3
                            ? 'Deleted Buildings'
                            : widget.selectedIndex == 4
                                ? 'Deleted Floors'
                                : 'Deleted Points',
            style: TextStyles.font16BlackSemiBold),
        centerTitle: true,
      ),
      body: BlocConsumer<DeleteOrganizationsCubit, DeleteOrganizationsState>(
        listener: (context, state) {
          if (state is DeletedAreaErrorState ||
              state is DeletedCityErrorState ||
              state is DeletedOrganizationErrorState ||
              state is DeletedBuildingErrorState ||
              state is DeletedFloorErrorState ||
              state is DeletedPointErrorState) {
            String? error;

            if (state is DeletedAreaErrorState) {
              error = state.error;
            } else if (state is DeletedCityErrorState) {
              error = state.error;
            } else if (state is DeletedOrganizationErrorState) {
              error = state.error;
            } else if (state is DeletedBuildingErrorState) {
              error = state.error;
            } else if (state is DeletedFloorErrorState) {
              error = state.error;
            } else if (state is DeletedPointErrorState) {
              error = state.error;
            }

            if (error != null) {
              toast(text: error, color: Colors.red);
            }
          }
          if (state is DeleteForceAreaSuccessState ||
              state is DeleteRestoreAreaSuccessState) {
            String? message;

            if (state is DeleteForceAreaSuccessState) {
              message = state.message;
            } else if (state is DeleteRestoreAreaSuccessState) {
              message = state.message;
            }

            if (message != null) {
              toast(text: message, color: Colors.blue);
            }

            context.read<DeleteOrganizationsCubit>().getAllDeletedArea();
          }
          if (state is DeleteForceCitySuccessState ||
              state is DeleteRestoreCitySuccessState) {
            String? message;

            if (state is DeleteForceCitySuccessState) {
              message = state.message;
            } else if (state is DeleteRestoreCitySuccessState) {
              message = state.message;
            }

            if (message != null) {
              toast(text: message, color: Colors.blue);
            }
            context.read<DeleteOrganizationsCubit>().getAllDeletedCity();
          }

          if (state is DeleteForceOrganizationSuccessState ||
              state is DeleteRestoreOrganizationSuccessState) {
            String? message;

            if (state is DeleteForceOrganizationSuccessState) {
              message = state.message;
            } else if (state is DeleteRestoreOrganizationSuccessState) {
              message = state.message;
            }

            if (message != null) {
              toast(text: message, color: Colors.blue);
            }
            context
                .read<DeleteOrganizationsCubit>()
                .getAllDeletedOrganization();
          }
          if (state is DeleteForceBuildingSuccessState ||
              state is DeleteRestoreBuildingSuccessState) {
            String? message;

            if (state is DeleteForceBuildingSuccessState) {
              message = state.message;
            } else if (state is DeleteRestoreBuildingSuccessState) {
              message = state.message;
            }

            if (message != null) {
              toast(text: message, color: Colors.blue);
            }
            context.read<DeleteOrganizationsCubit>().getAllDeletedBuilding();
          }
          if (state is DeleteForceFloorSuccessState ||
              state is DeleteRestoreFloorSuccessState) {
            String? message;

            if (state is DeleteForceFloorSuccessState) {
              message = state.message;
            } else if (state is DeleteRestoreFloorSuccessState) {
              message = state.message;
            }

            if (message != null) {
              toast(text: message, color: Colors.blue);
            }
            context.read<DeleteOrganizationsCubit>().getAllDeletedFloor();
          }
          if (state is DeleteForcePointSuccessState ||
              state is DeleteRestorePointSuccessState) {
            String? message;

            if (state is DeleteForcePointSuccessState) {
              message = state.message;
            } else if (state is DeleteRestorePointSuccessState) {
              message = state.message;
            }

            if (message != null) {
              toast(text: message, color: Colors.blue);
            }
            context.read<DeleteOrganizationsCubit>().getAllDeletedPoint();
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(15),
                    Divider(
                      color: Colors.grey[300],
                    ),
                    deleteOrganizationListBuild(context, widget.selectedIndex),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
