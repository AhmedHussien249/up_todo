import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/database/cache/cache_helper.dart';
import '../../../../core/database/sqflite_helper/sqflite.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/model/task_model.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitialState());
  DateTime selectedDate = DateTime.now();
  String selectedStartTime = DateFormat('hh:mm a').format(DateTime.now());
  String selectedEndTime = DateFormat(
    'hh:mm a',
  ).format(DateTime.now().add(Duration(hours: 1)));
  int currentIndex = 0;
  final TextEditingController titleController = TextEditingController();

  final TextEditingController noteController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void getDate(context) async {
    emit(GetDateLoadingState());
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      selectedDate = pickedDate;
      emit(GetDateSuccessState());
    } else {
      selectedDate = DateTime.now();
      emit(GetDateErrorState());
    }
  }

  void getStartTime(context) async {
    emit(GetStartTimeLoadingState());
    TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );

    if (pickedStartTime != null) {
      selectedStartTime = pickedStartTime.format(context);
      emit(GetStartTimeSuccessState());
    } else {
      selectedStartTime = DateFormat('hh:mm a').format(DateTime.now());
      emit(GetStartTimeErrorState());
    }
  }

  void getEndTime(context) async {
    emit(GetEndTimeLoadingState());
    TimeOfDay? pickedEndTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );

    if (pickedEndTime != null) {
      selectedEndTime = pickedEndTime.format(context);
      emit(GetEndTimeSuccessState());
    } else {
      selectedEndTime = DateFormat('hh:mm a').format(DateTime.now());
      emit(GetEndTimeErrorState());
    }
  }

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

  void changeColor(index) {
    currentIndex = index;
    emit(ChangeColorSuccessState());
  }

  getSelectedDate(date) {
    emit(GetSelectedDateLoadingState());
    selectedDate = date;
    emit(GetSelectedDateSuccessState());
    getTasks();
  }

  List<TaskModel> tasks = [];

  Future<void> insertTask() async {
    emit(InsertTaskLoadingState());
    try {
      await Future.delayed(Duration(seconds: 1));
      // test with dommy data
      // tasks.add(
      //   TaskModel(
      //     id: '1',
      //     date: DateFormat('yMd').format(selectedDate),
      //     title: titleController.text,
      //     note: noteController.text,
      //     startTime: selectedStartTime,
      //     endTime: selectedEndTime,
      //     isCompleted: false,
      //     color: currentIndex,
      //   ),
      // );
      await sl<SqfLiteHelper>().insertToDB(
        TaskModel(
          date: DateFormat('yMd').format(selectedDate),
          title: titleController.text,
          note: noteController.text,
          startTime: selectedStartTime,
          endTime: selectedEndTime,
          isCompleted: 0,
          color: currentIndex,
        ),
      );
      getTasks();
      titleController.clear();
      noteController.clear();
      selectedDate = DateTime.now();
      selectedStartTime = DateFormat('hh:mm a').format(DateTime.now());
      selectedEndTime = DateFormat('hh:mm a').format(DateTime.now());
      currentIndex = 0;

      emit(InsertTaskSuccessState());
    } catch (e) {
      emit(InsertTaskErrorState());
    }
  }

  Future<void> getTasks() async {
    emit(GetTaskLoadingState());
    await sl<SqfLiteHelper>()
        .getFromDB()
        .then((value) {
          tasks =
              value
                  .map((e) => TaskModel.fromJson(e))
                  .toList()
                  .where(
                    (element) =>
                        element.date == DateFormat('yMd').format(selectedDate),
                  )
                  .toList();
          emit(GetTaskSuccessState());
        })
        .catchError((e) {
          log(e.toString());
          emit(GetTaskErrorState());
        });
  }

  Future<void> updateTask(int id) async {
    emit(UpdateTaskLoadingState());
    await sl<SqfLiteHelper>()
        .updatedDB(id)
        .then((value) async {
          emit(UpdateTaskSuccessState());
          await Future.delayed(Duration(seconds: 1));
          getTasks();
        })
        .catchError((e) {
          log(e.toString());
          emit(UpdateTaskErrorState());
        });
  }

  Future<void> deleteTask(int id) async {
    emit(DeleteTaskLoadingState());
    await sl<SqfLiteHelper>()
        .deleteFromDB(id)
        .then((value) async {
          emit(DeleteTaskSuccessState());
          await Future.delayed(Duration(seconds: 1));
          getTasks();
        })
        .catchError((e) {
          log(e.toString());
          emit(DeleteTaskErrorState());
        });
  }
  bool isDark = false;
  void changeTheme()async{
    isDark = !isDark;
    await sl<CacheHelper>().saveData(key: 'isDark', value: isDark);
    emit(ChangeThemeState());
  }
void getTheme()async{
  isDark = await sl<CacheHelper>().getData(key: 'isDark');
  emit(GetThemeState());
}
}
