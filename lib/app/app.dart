import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/theme/theme.dart';
import '../core/utils/app_texts.dart';
import '../features/auth/presentation/screens/on_boarding_screens/on_boarding_screen.dart';
import '../features/auth/presentation/screens/splash_screen/splash_screen.dart';
import '../features/task/presentation/cubit/task_cubit.dart';
import '../features/task/presentation/screens/add_task_screens/add_task.dart';
import '../features/task/presentation/screens/home_screen/home_screen.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey();

class UpTodo extends StatelessWidget {
  const UpTodo({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            return MaterialApp(
              navigatorKey: navigatorKey,
              title: AppTexts.appTitle,
              debugShowCheckedModeBanner: false,
              routes: {
                'Splash': (context) => const SplashScreen(),
                'OnBoarding': (context) => const OnBoardingScreen(),
                'Home': (context) => const HomeScreen(),
                'AddTask': (context) => const AddTask(),
              },
              theme: getAppLightThemeData(),
              darkTheme: getAppDarkThemeData(),
              themeMode: BlocProvider
                  .of<TaskCubit>(context)
                  .isDark ? ThemeMode.dark : ThemeMode.light,

              home: const SplashScreen(),
            );
          },
        );
      },
    );
  }
}
