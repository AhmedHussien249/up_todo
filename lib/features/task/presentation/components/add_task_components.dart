import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/commons/commons.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_filled.dart';
import '../cubit/task_cubit.dart';

class AddTaskComponents extends StatelessWidget {
  const AddTaskComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 48.h),
        child: BlocConsumer<TaskCubit, TaskState>(
          listener: (context, state) {
            if (state is InsertTaskSuccessState) {
              showToast(
                message: 'Task added successfully',
                state: ToastStates.success,
              );
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Form(
              key: BlocProvider.of<TaskCubit>(context).formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormFilled(
                    hintText: AppTexts.titleHint,
                    controller:
                        BlocProvider.of<TaskCubit>(context).titleController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppTexts.titleErrorMsg;
                      }
                      return null;
                    },
                    label: Text(
                      AppTexts.title,
                      style: Theme.of(
                        context,
                      ).textTheme.displayMedium!.copyWith(
                            fontSize: 20.sp,
                            color: AppColors.textColor.withAlpha(
                              (0.87 * 255).toInt(),
                            ),
                          ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  CustomTextFormFilled(
                    hintText: AppTexts.noteHint,
                    controller:
                        BlocProvider.of<TaskCubit>(context).noteController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppTexts.noteErrorMsg;
                      }
                      return null;
                    },
                    label: Text(
                      AppTexts.note,
                      style: Theme.of(
                        context,
                      ).textTheme.displayMedium!.copyWith(
                            fontSize: 20.sp,
                            color: AppColors.textColor.withAlpha(
                              (0.87 * 255).toInt(),
                            ),
                          ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  CustomTextFormFilled(
                    hintText: DateFormat(
                      'dd-MM-yyyy',
                    ).format(BlocProvider.of<TaskCubit>(context).selectedDate),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        BlocProvider.of<TaskCubit>(context).getDate(context);
                      },
                      icon: Icon(Icons.calendar_month),
                      color: AppColors.textColor.withAlpha(
                        (0.87 * 255).toInt(),
                      ),
                    ),
                    label: Text(
                      AppTexts.date,
                      style: Theme.of(
                        context,
                      ).textTheme.displayMedium!.copyWith(
                            fontSize: 20.sp,
                            color: AppColors.textColor.withAlpha(
                              (0.87 * 255).toInt(),
                            ),
                          ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormFilled(
                          hintText: BlocProvider.of<TaskCubit>(
                            context,
                          ).selectedStartTime,
                          suffixIcon: IconButton(
                            onPressed: () async {
                              BlocProvider.of<TaskCubit>(
                                context,
                              ).getStartTime(context);
                            },
                            icon: Icon(Icons.alarm),
                            color: AppColors.textColor.withAlpha(
                              (0.87 * 255).toInt(),
                            ),
                          ),
                          label: Text(
                            AppTexts.startTime,
                            style: Theme.of(
                              context,
                            ).textTheme.displayMedium!.copyWith(
                                  fontSize: 20.sp,
                                  color: AppColors.textColor.withAlpha(
                                    (0.87 * 255).toInt(),
                                  ),
                                ),
                          ),
                        ),
                      ),
                      SizedBox(width: 27.w),
                      Expanded(
                        child: CustomTextFormFilled(
                          hintText: BlocProvider.of<TaskCubit>(
                            context,
                          ).selectedEndTime,
                          suffixIcon: IconButton(
                            onPressed: () async {
                              BlocProvider.of<TaskCubit>(
                                context,
                              ).getEndTime(context);
                            },
                            icon: Icon(Icons.alarm),
                            color: AppColors.textColor.withAlpha(
                              (0.87 * 255).toInt(),
                            ),
                          ),
                          label: Text(
                            AppTexts.endTime,
                            style: Theme.of(
                              context,
                            ).textTheme.displayMedium!.copyWith(
                                  fontSize: 20.sp,
                                  color: AppColors.textColor.withAlpha(
                                    (0.87 * 255).toInt(),
                                  ),
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    AppTexts.color,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    height: 18.h * 2.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            BlocProvider.of<TaskCubit>(
                              context,
                            ).changeColor(index);
                          },
                          child: CircleAvatar(
                            backgroundColor: BlocProvider.of<TaskCubit>(
                              context,
                            ).getColor(index),
                            radius: 18.r,
                            child: index ==
                                    BlocProvider.of<TaskCubit>(
                                      context,
                                    ).currentIndex
                                ? Icon(
                                    Icons.check,
                                    color: AppColors.backgroundColor,
                                  )
                                : null,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 8.w),
                      itemCount: 6,
                    ),
                  ),
                  SizedBox(height: 90.h),
                  state is InsertTaskLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : CustomButton(
                          text: AppTexts.createTask,
                          onTap: () {
                            if (BlocProvider.of<TaskCubit>(
                              context,
                            ).formKey.currentState!.validate()) {
                              BlocProvider.of<TaskCubit>(context).insertTask();
                            }
                          },
                          color: AppColors.primaryColor,
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
