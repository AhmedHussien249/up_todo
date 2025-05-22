import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../components/no_task_component.dart';
import '../../components/task_component.dart';
import '../../cubit/task_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'AddTask');
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(24.0.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        // التاريخ الكامل
                        DateFormat('yMMMMd').format(
                          context.read<TaskCubit>().selectedDate,
                        ), // التاريخ الكامل
                        style: Theme.of(
                          context,
                        ).textTheme.displayLarge!.copyWith(fontSize: 24.sp),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          context.read<TaskCubit>().isDark
                              ? Icons.light_mode
                              : Icons.dark_mode,
                          color: context.read<TaskCubit>().isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                        onPressed: () {
                          context.read<TaskCubit>().changeTheme();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    context.read<TaskCubit>().selectedDate ==
                            DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day,
                            )
                        ? 'Today'
                        : DateFormat('EEEE').format(
                            context.read<TaskCubit>().selectedDate,
                          ), // اسم اليوم
                    style: Theme.of(
                      context,
                    ).textTheme.displayLarge!.copyWith(fontSize: 24.sp),
                  ),
                  SizedBox(height: 6.h),
                  DatePicker(
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: AppColors.primaryColor,
                    width: 51.w,
                    height: 94.h,
                    selectedTextColor: Colors.white,
                    dayTextStyle: Theme.of(
                      context,
                    ).textTheme.displayMedium!.copyWith(fontSize: 10.sp),
                    dateTextStyle: Theme.of(
                      context,
                    ).textTheme.displayMedium!.copyWith(fontSize: 10.sp),
                    monthTextStyle: Theme.of(
                      context,
                    ).textTheme.displayMedium!.copyWith(fontSize: 10.sp),
                    onDateChange: (date) {
                      BlocProvider.of<TaskCubit>(context).getSelectedDate(date);
                    },
                  ),
                  SizedBox(height: 11.h),
                  BlocProvider.of<TaskCubit>(context).tasks.isEmpty
                      ? const NoTaskComponent()
                      : Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) => TaskComponent(
                              task: BlocProvider.of<TaskCubit>(
                                context,
                              ).tasks[index],
                            ),
                            itemCount: BlocProvider.of<TaskCubit>(context)
                                .tasks
                                .length,
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
