
import 'package:flutter/material.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';

class UserInfoListItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function onTapAddNewAction;
  final Function onTapAddEditAction;
  final List<Widget> children;
  final bool useSeparator;

  UserInfoListItem({
    @required this.icon,
    @required this.label,
    this.onTapAddNewAction,
    this.onTapAddEditAction,
    this.useSeparator = true,
    @required this.children,
  });

  Widget _addNewWidget(context) => onTapAddNewAction == null
      ? SizedBox()
      : Material(
    borderRadius: BorderRadius.circular(5),
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: onTapAddNewAction,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Add New",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor.withOpacity(.8),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 8
                  ),
                  Material(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).primaryColor.withOpacity(.1),
                      child: Icon(Icons.add,
                          color: Theme.of(context).primaryColor.withOpacity(.8)))
                ],
              ),
            ),
        ),
      );


  @override
  Widget build(BuildContext context) {
    var titleTextStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              icon,
              size: 15,
            ),
            SizedBox(
              width: 8,
            ),
            Text(label, style: titleTextStyle),
            Spacer(),
            onTapAddEditAction == null? SizedBox():
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.edit,
                  size: 18,
                ),
              ),
              onTap: onTapAddEditAction,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: children.length,
          itemBuilder: (c, i) => children[i],
        ),
        _addNewWidget(context),
      ],
    );
  }
}
