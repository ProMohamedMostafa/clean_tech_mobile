import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/features/layout/ip_screen/logic/cubit/ip_cubit.dart';
import 'package:smart_cleaning_application/features/layout/ip_screen/ui/widget/ip_text_form_field.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class IpScreenBody extends StatelessWidget {
  const IpScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<IpCubit>();
    return BlocConsumer<IpCubit, IpState>(
      listener: (context, state) {
        if (state is IpSuccessState) {
          toast(text: state.message, isSuccess: true);
          context.pushNamedAndRemoveUntil(
            Routes.loginScreen,
            predicate: (route) => false,
          );
        }
        if (state is IpErrorState) {
          toast(text: state.error, isSuccess: false);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/images/clean.png',
                          height: 40,
                          width: 120,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).enter_network_ip,
                          style: TextStyles.font14GreyRegular,
                        ),
                        verticalSpace(40),
                        CustomIpTextFormField(
                          controller: cubit.ipController,
                          onlyRead: false,
                          label: S.of(context).network_ip,
                        ),
                        verticalSpace(60),
                        state is IpLoadingState
                            ? Loading()
                            : Center(
                                child: DefaultElevatedButton(
                                  name: S.of(context).check_ip,
                                  color: AppColor.primaryColor,
                                  textStyles: TextStyles.font16WhiteSemiBold,
                                  onPressed: () {
                                    if (cubit.formKey.currentState!
                                        .validate()) {
                                      cubit.checkIp();
                                    }
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
