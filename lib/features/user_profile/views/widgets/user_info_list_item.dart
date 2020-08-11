import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';

class UserInfoListItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final Function onTapAddNewAction;
  final Function onTapEditAction;
  final List<Widget> children;
  final bool useSeparator;
  final bool isInEditMode;
  final Key penKey, addKey;

  UserInfoListItem({
    @required this.icon,
    @required this.label,
    this.onTapAddNewAction,
    this.onTapEditAction,
    this.isInEditMode = false,
    this.useSeparator = true,
    @required this.children,
    this.penKey,
    this.addKey
  });

  @override
  _UserInfoListItemState createState() => _UserInfoListItemState();
}

class _UserInfoListItemState extends State<UserInfoListItem> {
  @override
  Widget build(BuildContext context) {
    var titleTextStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);

    var addNewButton = widget.isInEditMode
        ? InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: widget.onTapAddNewAction,
            child: Material(
                borderRadius: BorderRadius.circular(50),
                color: Theme.of(context).accentColor.withOpacity(.1),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(FontAwesomeIcons.plus,
                      key: widget.addKey,
                      size: 20,
                      color: Theme.of(context).accentColor),
                )),
          )
        : SizedBox();
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              widget.icon,
              size: 15,
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(child: Text(widget.label, style: titleTextStyle)),
            
            addNewButton,
            SizedBox(
              width:15,
            ),
            if(widget.onTapEditAction != null)
            InkWell(
              borderRadius: BorderRadius.circular(50),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Icon(
                  widget.isInEditMode ? FontAwesomeIcons.check : Icons.edit,
                  size: 20,
                  key: widget.penKey,
                  color: Theme.of(context).accentColor,
                ),
              ),
              onTap: widget.onTapEditAction,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.children.length,
          itemBuilder: (c, i) => widget.children[i],
        ),
      ],
    );
  }
}
