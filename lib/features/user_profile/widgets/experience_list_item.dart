import 'package:p7app/features/user_profile/models/user_profile_models.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:p7app/main_app/resource/const.dart';

class ExperienceListItem extends StatelessWidget {
  final Experience experienceModel;
  final Function onTapEdit;

  ExperienceListItem({this.experienceModel, this.onTapEdit});

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).backgroundColor;
    String time = "";

    time = "${DateFormat().add_yMMMd().format(experienceModel.joiningDate)} "
        "- ${experienceModel.leavingDate == null ? "Ongoing" : DateFormat().add_yMMMd().format(experienceModel.leavingDate)}";

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 2),
        ],),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Image.asset(
          kImagePlaceHolderAsset,
          height: 55,
          width: 55,
        ),
        title: Text(
          experienceModel.position,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(experienceModel.organizationName),
            Text(
              time,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(FontAwesomeIcons.edit),
          onPressed: onTapEdit,
        ),
      ),
    );
  }
}
