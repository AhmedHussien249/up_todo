import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/database/cache/cache_helper.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_texts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToOnBoarding();
  }

  void navigateToOnBoarding() {
    final bool isVisited =
        sl<CacheHelper>().getData(key: AppTexts.onBoardingKey) ?? false;
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // <=

        isVisited
            ? Navigator.pushReplacementNamed(context, 'Home')
            : Navigator.pushReplacementNamed(context, 'OnBoarding');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.logo),
            SizedBox(height: 35.h),
            Text(
              AppTexts.appTitle,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 40.sp,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
