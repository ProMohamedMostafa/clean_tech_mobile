import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/src/app_cubit/app_cubit.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({super.key});

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  late String _selectedLanguage;
  final List<Map<String, String>> _allLanguages = [
    {'code': 'en', 'label': 'English'},
    {'code': 'ar', 'label': 'العربية'},
    {'code': 'ur', 'label': 'Urdu'},
  ];

  @override
  void initState() {
    super.initState();
    _initializeLanguage();
  }

  Future<void> _initializeLanguage() async {
    final savedLanguage = await LanguageCacheHelper().getCachedLanguageCode();
    setState(() {
      _selectedLanguage = savedLanguage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appCubit = context.read<AppCubit>();

    final currentLanguage =
        _allLanguages.firstWhere((lang) => lang['code'] == _selectedLanguage);

    final otherLanguages = _allLanguages
        .where((lang) => lang['code'] != _selectedLanguage)
        .toList();

    return Scaffold(
      appBar:
          AppBar(title: const Text('Language'), leading: CustomBackButton()),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selected language on top
            InkWell(
              onTap: () {},
              child: _buildLanguageItem(currentLanguage['label']!, true),
            ),
            const Divider(),
            Text(
              'Others',
              style:
                  TextStyles.font16PrimSemiBold.copyWith(color: Colors.black),
            ),
            ...otherLanguages.map((lang) => InkWell(
                  onTap: () {
                    setState(() {
                      _selectedLanguage = lang['code']!;
                    });
                    appCubit.changeLanguage(lang['code']!);
                  },
                  child: _buildLanguageItem(
                    lang['label']!,
                    false,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageItem(String language, bool isSelected) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
      leading: Text(
        language,
        style: TextStyles.font16BlackSemiBold,
      ),
      trailing: Container(
        width: 22.r,
        height: 22.r,
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
