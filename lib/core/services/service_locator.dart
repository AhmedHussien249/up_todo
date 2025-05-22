import 'package:get_it/get_it.dart';

import '../database/cache/cache_helper.dart';
import '../database/sqflite_helper/sqflite.dart';

final sl = GetIt.instance;

Future<void> setup() async {
  sl.registerLazySingleton<CacheHelper>(() => CacheHelper());
  sl.registerLazySingleton<SqfLiteHelper>(() => (SqfLiteHelper()));
}
