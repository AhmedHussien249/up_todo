import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_texts.dart';

class NoTaskComponent extends StatelessWidget {
  const NoTaskComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(AppAssets.noTasks),
          SizedBox(height: 10.h),
          Text(
            AppTexts.noTaskTitle,
            style: Theme.of(
              context,
            ).textTheme.displayMedium!.copyWith(fontSize: 20.sp),
          ),
          SizedBox(height: 10.h),
          Text(
            AppTexts.noTaskSubTitle,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ],
      ),
    );
  }
}
