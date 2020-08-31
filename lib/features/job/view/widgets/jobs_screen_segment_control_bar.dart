import 'package:flutter/material.dart';
import 'package:p7app/features/job/view_model/job_screen_view_model.dart';
import 'package:p7app/main_app/app_theme/common_style.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:provider/provider.dart';

class JobsScreenSegmentControlBar extends StatelessWidget {
  final borderColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<JobScreenViewModel>(context);
//    var currentIndex = vm.currentIndex;
    var divider = Container(
      width: 1,
      color: borderColor,
      height: double.infinity,
    );
    return Material(
      elevation: 4,
      child: Container(
        height: 35,
        decoration: BoxDecoration(
//        boxShadow: CommonStyleTextField.boxShadow,
          color: Theme.of(context).backgroundColor,
//          border: Border.all(color: borderColor,width: 2  ),
//          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
//          mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              barItem(
                context: context,
                label: StringResources.allText,
                buttonKey: Key('jobsSegmentAllText'),
                index: 0,
              ),
              divider,
              barItem(
                  context: context,
                  label: StringResources.appliedText,
                  buttonKey: Key('jobsSegmentAppliedText'),
                  index: 1),
              divider,
              barItem(
                context: context,
                label: StringResources.favoriteText,
                buttonKey: Key('jobsSegmentFavoriteText'),
                index: 2,
              )
            ]),
      ),
    );
  }

  Widget barItem({
    @required context,
    @required String label,
    @required int index, Key buttonKey,
  }) {
    var vm = Provider.of<JobScreenViewModel>(context);
    bool isSelected = vm.currentIndex == index;
    return Expanded(
      child: SizedBox(
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            key: buttonKey,
            onTap: () {
              vm.onChange(index);
            },
            child: Center(
              child: Text(
                label ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isSelected ? Colors.blue : Colors.grey,
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
