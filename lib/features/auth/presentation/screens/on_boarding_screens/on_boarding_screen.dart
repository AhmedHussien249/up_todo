import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/database/cache/cache_helper.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_texts.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../core/widgets/custom_text_button.dart';
import '../../../data/model/on_boarding_model.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: PageView.builder(
            itemCount: OnBoardingModel.onBoardingList.length,
            controller: controller,
            itemBuilder: (context, index) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //skip text
                if (index == 2)
                  SizedBox(height: 54.h)
                else
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomTextButton(
                      text: AppTexts.skip,
                      onPressed: () {
                        controller.jumpToPage(2);
                      },
                    ),
                  ),

                Spacer(),
                //image
                Image.asset(
                  OnBoardingModel.onBoardingList[index].image,
                  height: 300.h,
                  width: 300.w,
                ),
                SizedBox(height: 15.h),
                SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    activeDotColor: AppColors.primaryColor,
                    dotColor: AppColors.textColor.withAlpha(
                      (0.87 * 255).toInt(),
                    ),
                    dotHeight: 4.h,
                    dotWidth: 26.w,
                  ),
                ),
                //dots
                SizedBox(height: 70.h),
                // title
                Text(
                  OnBoardingModel.onBoardingList[index].title,
                  style: Theme.of(context).textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 42.h),
                // subtitle
                Text(
                  OnBoardingModel.onBoardingList[index].subTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.displayMedium!.copyWith(
                        color: AppColors.textColor.withAlpha(
                          (0.87 * 255).toInt(),
                        ),
                      ),
                ),
                Spacer(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // back button
                    if (index == 0)
                      Container()
                    else
                      CustomTextButton(
                        text: AppTexts.back,
                        onPressed: () {
                          controller.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                      ),
                    // next button
                    if (index != 2)
                      CustomElevatedButton(
                        text: AppTexts.next,
                        onPressed: () {
                          controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                      )
                    else
                      CustomElevatedButton(
                        text: AppTexts.getStarted,
                        onPressed: () async {
                          await sl<CacheHelper>()
                              .saveData(
                            key: AppTexts.onBoardingKey,
                            value: true,
                          )
                              .then((value) {
                            Navigator.pushReplacementNamed(
                              context,
                              'Home',
                            );
                          });
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
