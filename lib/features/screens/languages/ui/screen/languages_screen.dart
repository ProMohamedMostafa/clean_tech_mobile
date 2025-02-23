import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/src/app_cubit/app_cubit.dart';
import 'package:smart_cleaning_application/src/app_cubit/app_states.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({super.key});

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  List<bool> isChecked = [false, false, false]; // Default selection

  @override
  void initState() {
    super.initState();
    _initializeLanguage();
  }

  // Initialize the language selection based on saved language
  Future<void> _initializeLanguage() async {
    // Get the saved language code
    final savedLanguage = await LanguageCacheHelper().getCachedLanguageCode();

    // Update the `isChecked` list based on the saved language
    setState(() {
      if (savedLanguage == 'en') {
        isChecked = [true, false, false];
      } else if (savedLanguage == 'ar') {
        isChecked = [false, true, false];
      } else if (savedLanguage == 'ur') {
        isChecked = [false, false, true];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language'),
        leading: customBackButton(context),
      ),
      body: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          var appCubit = AppCubit.get(context);

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isChecked = [true, false, false];
                    });
                    appCubit.changeLanguage('en');
                  },
                  child: _buildLanguageItem('English', isChecked[0]),
                ),
                Divider(),
                Text(
                  'Others',
                  style: TextStyles.font16PrimSemiBold
                      .copyWith(color: Colors.black),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isChecked = [false, true, false];
                    });
                    appCubit.changeLanguage('ar');
                  },
                  child: _buildLanguageItem('العربية', isChecked[1]),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isChecked = [false, false, true];
                    });
                    appCubit.changeLanguage('ur');
                  },
                  child: _buildLanguageItem('Urdu', isChecked[2]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLanguageItem(String language, bool isSelected) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 5),
      leading: Text(
        language,
        style: TextStyles.font16BlackSemiBold,
      ),
      trailing: Container(
        width: 22.w,
        height: 22.h,
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.transparent
              : AppColor.primaryColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(
            color: isSelected
                ? AppColor.primaryColor
                : AppColor.primaryColor.withOpacity(0.4),
            width: isSelected ? 6.w : 2.w,
          ),
        ),
      ),
    );
  }
}
