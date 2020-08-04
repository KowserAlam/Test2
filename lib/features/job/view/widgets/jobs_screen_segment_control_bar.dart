import 'package:flutter/material.dart';
import 'package:p7app/features/job/view_model/job_screen_view_model.dart';
import 'package:p7app/features/user_profile/styles/common_style_text_field.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:provider/provider.dart';

class JobsScreenSegmentControlBar extends StatelessWidget {
  final  borderColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<JobScreenViewModel>(context);
    var currentIndex = vm.currentIndex;
    double height = 25;
    var divider = Container(width: 2,color: borderColor,height: height,);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: CommonStyleTextField.boxShadow,
          color: Theme.of(context).backgroundColor,
          border: Border.all(color: borderColor,width: 2  ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            barItem(
              context: context,
                label: StringResources.allText,
                index:  0,),

            divider,
            barItem(
                context: context,
                label: StringResources.appliedText,index: 1),
            divider,
            barItem(
              context: context,
                label: StringResources.favoriteText,
           index: 2,)
          ]
        ),
      ),
    );
  }

  Widget barItem({
    @required context,
    @required String label,
    @required int index,
  }) {
    var vm = Provider.of<JobScreenViewModel>(context);
    bool isSelected = vm.currentIndex == index;
    return SizedBox(
      width: 80,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: (){
            vm.onChange(index);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
            child: Text(
              label ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(color: isSelected ? Colors.blue : Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
