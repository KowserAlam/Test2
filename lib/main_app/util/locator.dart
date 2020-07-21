import 'package:get_it/get_it.dart';
import 'package:p7app/features/settings/settings_view_model.dart';
import 'package:p7app/main_app/push_notification_service/push_notification_service.dart';
import 'package:p7app/main_app/views/widgets/restart_widget.dart';

GetIt locator = GetIt.instance;
void setupLocator(){
  locator.registerLazySingleton<PushNotificationService>(() => PushNotificationService());
  locator.registerLazySingleton<SettingsViewModel>(() => SettingsViewModel());
  locator.registerLazySingleton<RestartNotifier>(() => RestartNotifier());
}