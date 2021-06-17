import 'package:apps_todo/repository/account_repository.dart';
import 'package:apps_todo/viewmodel/account_viewmodel.dart';
import 'package:apps_todo/viewmodel/category_viewmodel.dart';
import 'package:apps_todo/viewmodel/todo_viewmodel.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AccountRepository());
  locator.registerFactory(() => CategoryViewModel());
  locator.registerFactory(() => TodoViewModel());
  locator.registerFactory(() => AccountViewModel());
}
