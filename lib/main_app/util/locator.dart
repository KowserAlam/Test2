import 'package:get_it/get_it.dart';
import 'package:p7app/features/settings/settings_view_model.dart';
import 'package:p7app/main_app/push_notification_service/push_notification_service.dart';

GetIt locator = GetIt.instance;
void setupLocator(){
  locator.registerLazySingleton(() => PushNotificationService());
  locator.registerLazySingleton(() => SettingsViewModel());
}