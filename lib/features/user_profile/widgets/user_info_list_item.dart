import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class UserInfoListItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function onTapAddNewAction;
  final List<Widget> expandedChildren;
  final bool useSeparator;

  UserInfoListItem({
    @required this.icon,
    @required this.label,
    this.onTapAddNewAction,
    this.useSeparator = true,
    @required this.expandedChildren,
  });

  Widget _addNewWidget(context) => onTapAddNewAction == null
      ? SizedBox()
      : InkWell(
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
                  width: 8,
                ),
                Material(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).primaryColor.withOpacity(.1),
                    child: Icon(Icons.add,
                        color: Theme.of(context).primaryColor.withOpacity(.8)))
              ],
            ),
          ),
        );

  Widget _expendedWidget(context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(color: Colors.grey.withOpacity(0.5)))),
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: expandedChildren.length,
            separatorBuilder: (c, i) => useSeparator?Divider(
              height: 2,
              thickness: 2,
            ):SizedBox(),
            itemBuilder: (c, i) => expandedChildren[i],
          ),
        ),
        _addNewWidget(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: ExpandableNotifier(
        child: ScrollOnExpand(
          child: ExpandablePanel(
            header: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Material(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        icon,
                        size: 40,
                        color: Theme.of(context).unselectedWidgetColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.title,
                  ),
                ],
              ),
            ),
            expanded: _expendedWidget(context),
            tapHeaderToExpand: true,
            hasIcon: true,
          ),
        ),
      ),
    );
  }
}
