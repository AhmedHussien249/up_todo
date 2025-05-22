import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/commons/commons.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../data/model/task_model.dart';
import '../cubit/task_cubit.dart';

class TaskComponent extends StatelessWidget {
  const TaskComponent({super.key, required this.task});

  final TaskModel task;

  Color getColor(index) {
    switch (index) {
      case 0:
        return AppColors.c1;
      case 1:
        return AppColors.c2;
      case 2:
        return AppColors.c3;
      case 3:
        return AppColors.c4;
      case 4:
        return AppColors.c5;
      case 5:
        return AppColors.c6;
      default:
        return AppColors.c7;
    }
  }

  @override
  Widget build(BuildContext context) {
    final originalContext = context;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            color: AppColors.bottomSheetBackground,
            padding: EdgeInsets.all(24.r),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                task.isCompleted == 1
                    ? Container()
                    : CustomButton(
                        text: AppTexts.taskCompleted,
                        color: AppColors.primaryColor,
                        onTap: () {
                          BlocProvider.of<TaskCubit>(
                            originalContext,
                          ).updateTask(task.id ?? 0);
                          showToast(
                            message: 'Task Completed',
                            state: ToastStates.success,
                          );

                          Navigator.pop(originalContext);
                        },
                      ),
                CustomButton(
                  text: AppTexts.deleteTask,
                  color: AppColors.deleteTaskColor,
                  onTap: () {
                    BlocProvider.of<TaskCubit>(
                      originalContext,
                    ).deleteTask(task.id ?? 0);
                    showToast(
                      message: 'Task Deleted',
                      state: ToastStates.success,
                    );
                    Navigator.pop(originalContext);
                  },
                ),
                CustomButton(
                  text: AppTexts.cancel,
                  color: AppColors.primaryColor,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(8.r),
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: getColor(task.color),
          borderRadius: BorderRadius.circular(16.r),
        ),
        // Row
        child: Row(
          children: [
            // column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Text
                  Text(
                    task.title,
                    style: Theme.of(
                      context,
                    ).textTheme.displayMedium!.copyWith(fontSize: 24.sp),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.alarm, color: Colors.white),
                      SizedBox(width: 8.w),
                      Text(
                        '${task.startTime} - ${task.endTime}',
                        style: Theme.of(
                          context,
                        ).textTheme.displayMedium!.copyWith(fontSize: 16.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    task.note,
                    style: Theme.of(
                      context,
                    ).textTheme.displayMedium!.copyWith(fontSize: 24.sp),
                  ),
                ],
              ),
            ),
            Container(height: 75.h, width: 1.w, color: Colors.white),
            SizedBox(width: 10.w),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task.isCompleted == 1 ? AppTexts.completed : AppTexts.toDo,
                style: Theme.of(
                  context,
                ).textTheme.displayMedium!.copyWith(fontSize: 16.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
