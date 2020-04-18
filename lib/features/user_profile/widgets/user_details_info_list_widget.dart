import 'package:p7app/features/user_profile/providers/user_provider.dart';
import 'package:p7app/features/user_profile/styles/profile_common_style.dart';
import 'package:p7app/features/user_profile/widgets/personal_info_widget.dart';
import 'package:p7app/features/user_profile/widgets/technical_skill_list_item.dart';
import 'package:p7app/features/user_profile/widgets/user_info_list_item.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../add_edit_education_screen.dart';
import '../add_edit_experience_screen.dart';
import '../add_edit_technical_skill_screen.dart';
import 'educations_list_item.dart';
import 'experience_list_item.dart';

class UserDetailsInfoListWidget extends StatefulWidget {
  @override
  _UserDetailsInfoListWidgetState createState() =>
      _UserDetailsInfoListWidgetState();
}

class _UserDetailsInfoListWidgetState extends State<UserDetailsInfoListWidget> {




  @override
  Widget build(BuildContext context) {

    var itemList = [

      /// about me



      ///Experience


    ];

    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemCount: itemList.length,
      separatorBuilder: (context, int) => SizedBox(
        height: 15,
      ),
      itemBuilder: (context, index) => itemList[index],
    );
  }
}
