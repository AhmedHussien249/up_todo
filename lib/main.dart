import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_todo_project/core/services/local_notifications_service.dart';
import 'package:up_todo_project/core/services/wok_manger_Service.dart';

import 'app/app.dart';
import 'core/bloc/bloc_observer.dart';
import 'core/database/cache/cache_helper.dart';
import 'core/database/sqflite_helper/sqflite.dart';
import 'core/services/service_locator.dart';
import 'features/task/presentation/cubit/task_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await setup();
  await sl<CacheHelper>().init();
  await sl<SqfLiteHelper>().initDB();
  Future.wait([LocalNotificationService.init(), WorkManagerService().init()]);
  runApp(
    BlocProvider(
        create: (context) => TaskCubit()
          ..getTheme()
          ..getTasks(),
        child: UpTodo()),
  );
}
