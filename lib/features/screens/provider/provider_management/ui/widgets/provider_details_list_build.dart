import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/provider/provider_management/logic/cubit/provider_cubit.dart';
import 'package:smart_cleaning_application/features/screens/provider/provider_management/ui/widgets/build_provider_item_list.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class ProviderDetailsList extends StatelessWidget {
  const ProviderDetailsList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProviderCubit>();
    final providersData = cubit.selectedIndex == 0
        ? cubit.providersModel?.data?.data
        : cubit.allDeletedProvidersModel?.data;

    if (providersData == null || providersData.isEmpty) {
      return Center(
        child: Text(
          S.of(context).noData,
          style: TextStyles.font13Blackmedium,
        ),
      );
    } else {
      return ListView.separated(
        controller: cubit.selectedIndex == 0 ? cubit.scrollController : null,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: providersData.length,
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[300],
            height: 0,
          );
        },
        itemBuilder: (context, index) {
          return BuildProviderItemList(index: index);
        },
      );
    }
  }
}
