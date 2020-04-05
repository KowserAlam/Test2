import 'package:skill_check/features/user_profile/models/user_profile_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../add_edit_education_screen.dart';

class EducationsListItem extends StatelessWidget {
  final Education educationItemModel;
  final int index;

  EducationsListItem({
    @required this.educationItemModel,
    @required this.index,
  });

  @override
  Widget build(BuildContext context) {
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
                FontAwesomeIcons.university,
                size: 40,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          title: Text(
            educationItemModel.nameOfInstitution,
            style: Theme.of(context)
                .textTheme
                .title
                .apply(color: Theme.of(context).primaryColor),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(educationItemModel.degree ?? ""),
              Text(
                educationItemModel.passingYear != null
                    ? DateFormat()
                    .add_yMMMMd()
                    .format(educationItemModel.passingYear)
                    .toString()
                    : "",
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(FontAwesomeIcons.solidEdit),
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => AddEditEducationScreen(
                        educationModel: educationItemModel,
                        index: index,
                      )));
            },
          ),
        ),
      ),
    );
  }
}