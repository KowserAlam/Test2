

import 'package:get/get.dart';
import 'package:p7app/features/settings/repositories/web_setting_repository.dart';
import 'package:p7app/main_app/models/web_settings_model.dart';
import 'package:p7app/main_app/util/logger_helper.dart';

class WebSettingsViewModel extends GetxController{
  var settings = WebSettingsModel().obs;
  var isLoading = false.obs;


  @override
  void onInit() {
    _getSettings();
    super.onInit();
  }


  _getSettings()async{
    isLoading.value = true;
    var res = await WebSettingsRepository().getSettingInfo();
    res.fold((l){
      isLoading.value = false;
      logger.e(l);
    }, (r) {
      isLoading.value = false;
      settings.value = r;
    });
  }

}