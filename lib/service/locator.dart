import 'package:get_it/get_it.dart';
import 'package:my_notes/service/shared_prefs_service.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  // Register SharedPreferencesService as a lazy singleton

  locator.registerLazySingleton(() => SharedPreferencesService());

  // Initialize SharedPreferencesService asynchronously
  final sharedPreferencesService = locator<SharedPreferencesService>();
  await sharedPreferencesService.init();
}
