import 'package:p7app/features/user_profile/models/user_profile_models.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ExperienceListItem extends StatelessWidget {
  final Experience experienceModel;
  final Function onTapEdit;

  ExperienceListItem({this.experienceModel, this.onTapEdit});

  @override
  Widget build(BuildContext context) {
    String time = "";
    if (experienceModel.currentlyWorkHere) {
      time =
      "From ${DateFormat().add_yMMMM().format(experienceModel.joiningDate)}";
    } else {
      time = "${DateFormat().add_yMMMM().format(experienceModel.joiningDate)} "
          "- ${experienceModel.leavingDate == null ? "" : DateFormat().add_yMMMM().format(experienceModel.leavingDate)}";
    }

    return Material(
      color: Theme.of(context).canvasColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 5),
          leading: Material(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(5),
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Icon(
                FontAwesomeIcons.star,
                size: 40,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          title: Text(
            experienceModel.organizationName,
            style: Theme.of(context)
                .textTheme
                .title
                .apply(color: Theme.of(context).primaryColor),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(experienceModel.position),
              Text(time),
            ],
          ),
          trailing: IconButton(
            icon: Icon(FontAwesomeIcons.solidEdit),
            onPressed: onTapEdit,
          ),
        ),
      ),
    );
  }
}