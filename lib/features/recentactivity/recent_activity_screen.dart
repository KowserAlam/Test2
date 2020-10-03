import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p7app/features/recentactivity/recentactivity_view_model.dart';
import 'package:p7app/features/recentactivity/recentactivitymodel.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/page_state_builder.dart';

class RecentActivityScreen extends StatelessWidget {
  final _ = Get.put(RecentActivityViewModel());
  final vm = Get.find<RecentActivityViewModel>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(StringResources.recentActivityText),),
      body: Obx((){
        var activityList = vm.activityList;
        return PageStateBuilder(
          onRefresh: vm.getData,
            showLoader: vm.shouldShowLoader,
            showError: vm.shouldShowError,
            appError: vm.appError.value,

            child: ListView.builder(
              itemCount: activityList.length,
              itemBuilder: (context,index){
              var activity = activityList[index];
              return ListTile(
                title: _getTitle(activity),
              );
            },));
      }),
    );
  }

  Widget _getTitle(RecentActivityModel activity){

    String prefix = "";
    String suffix = "";

    if(activity.type == "update_pro"){
      prefix = "You updated your ";
      suffix = "${activity.updatedSection}" ??"";
    }
    if(activity.type == "apply_pro"){
    prefix = "You Applied a Job ";
       suffix = activity?.reletedJob?.title??"";

    }

    return Text.rich(TextSpan(children: [

      TextSpan(text: prefix),
      TextSpan(text: suffix,style: TextStyle(fontWeight: FontWeight.bold)),
    ]));
  }
}
