import 'package:get_it/get_it.dart';
import 'package:p7app/main_app/push_notification_service/push_notification_service.dart';

GetIt locator = GetIt.instance;
void setupLocator(){
  locator.registerFactory(() => PushNotificationService());
}