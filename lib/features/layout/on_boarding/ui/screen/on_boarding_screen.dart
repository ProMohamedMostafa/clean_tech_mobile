import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/features/layout/on_boarding/data/model/on_boarding_model.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';
import 'package:smart_cleaning_application/src/app_cubit/app_cubit.dart';
import 'package:smart_cleaning_application/src/app_cubit/app_states.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        final cubit = context.read<AppCubit>();
        return Scaffold(
          backgroundColor: Colors.white,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light.copyWith(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            textDirection: TextDirection.ltr,
                            Icons.language,
                            color: AppColor.primaryColor,
                            size: 20.sp,
                          ),
                          horizontalSpace(4),
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              padding: EdgeInsets.zero,
                              value: cubit.locale.toString(),
                              dropdownColor: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              icon: SizedBox.shrink(),
                              style: TextStyles.font14Primarybold.copyWith(
                                color: AppColor.primaryColor,
                              ),
                              onChanged: (String? newLang) {
                                if (newLang != null) {
                                  cubit.changeLanguage(newLang);
                                }
                              },
                              items: [
                                DropdownMenuItem(
                                  value: 'en',
                                  child: Text('English'),
                                ),
                                DropdownMenuItem(
                                  value: 'ar',
                                  child: Text('عربي'),
                                ),
                                DropdownMenuItem(
                                  value: 'ur',
                                  child: Text('اردو'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 380.h,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true,
                        viewportFraction: 1.0,
                        onPageChanged: (index, reason) {
                          cubit.changeCarouselIndex(index);
                        },
                      ),
                      items: onBoardingList.map((item) {
                        return Image.asset(
                          item.image!,
                          fit: BoxFit.fill,
                        );
                      }).toList(),
                    ),
                    verticalSpace(10),
                    AnimatedSmoothIndicator(
                      activeIndex: cubit.currentIndex,
                      count: onBoardingList.length,
                      effect: SlideEffect(
                        dotColor: Colors.grey,
                        activeDotColor: AppColor.primaryColor,
                        dotHeight: 10.h,
                        dotWidth: 10.w,
                        spacing: 8.w,
                        radius: 10.r,
                      ),
                    ),
                    verticalSpace(30),
                    Text(
                      S.of(context).welcome,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.font20PrimMedium,
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).experienceDescription,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: TextStyles.font16GreyMedium,
                    ),
                    verticalSpace(30),
                    DefaultElevatedButton(
                      name: S.of(context).nextButton,
                      color: AppColor.primaryColor,
                      onPressed: () {
                        context.pushNamedAndRemoveUntil(
                          Routes.loginScreen,
                          predicate: (route) => false,
                        );
                      },
                      height: 48.h,
                      width: double.infinity,
                      textStyles: TextStyles.font16WhiteSemiBold,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
