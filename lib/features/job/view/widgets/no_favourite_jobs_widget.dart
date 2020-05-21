import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';

class NoFavouriteJobsWidget extends StatelessWidget {
  final onTap;

  @override
  Widget build(BuildContext context) {
    var color = Colors.grey;
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        onTap: onTap,
        child: Center(child: Column(
          mainAxisSize:MainAxisSize.min ,children: [
          Icon(FontAwesomeIcons.heart,color: color,),
          SizedBox(height: 15,),
          Text(StringUtils.youDoNotHaveAnyFavoriteJob,style: TextStyle(color: color),)
        ],),),
      ),
    );
  }

  const NoFavouriteJobsWidget({
     this.onTap,
  });
}
