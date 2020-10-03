

import 'package:get/get.dart';
import 'package:p7app/features/recentactivity/recent_activity_repository.dart';
import 'package:p7app/features/recentactivity/recentactivitymodel.dart';
import 'package:p7app/main_app/failure/app_error.dart';

class RecentActivityViewModel extends GetxController{

  var appError = AppError.none.obs;
  var activityList = <RecentActivityModel>[].obs;
  var isLoading = false.obs;


  Future getData()async{
  isLoading.value = true;
    var res = await RecentActivityRepository().getActivities();
    return res.fold((l) {
      appError.value = l;
      isLoading.value = false;
      return ;
    }, (r) {
      appError.value = AppError.none;
      isLoading.value = false;
      activityList.value= r;

      return;
    });
  }

  bool get shouldShowLoader => isLoading.value && activityList.length == 0;
  bool get shouldShowError => appError.value != AppError.none && activityList.length == 0;


}