
import 'package:flutter/material.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';

class UserInfoListItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final Function onTapAddNewAction;
  final Function onTapEditAction;
  final List<Widget> children;
  final bool useSeparator;
  final bool isInEditMode;

  UserInfoListItem({
    @required this.icon,
    @required this.label,
    this.onTapAddNewAction,
    this.onTapEditAction,
    this.isInEditMode =  false,
    this.useSeparator = true,
    @required this.children,
  });

  @override
  _UserInfoListItemState createState() => _UserInfoListItemState();
}

class _UserInfoListItemState extends State<UserInfoListItem> {




  @override
  Widget build(BuildContext context) {
    var titleTextStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);

    var  addNewButton =  widget.isInEditMode
        ? InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: widget.onTapAddNewAction,
          child: Material(
          borderRadius: BorderRadius.circular(50),
          color: Theme.of(context).primaryColor.withOpacity(.1),
          child: Icon(Icons.add,
              color: Theme.of(context).primaryColor.withOpacity(.8))),
        ):SizedBox();
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
            Text(widget.label, style: titleTextStyle),
            Spacer(),
            addNewButton,
            SizedBox(width: 8,),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  widget.isInEditMode?Icons.done:Icons.edit,
                  size: 18,
                  color: Theme.of(context).primaryColor,
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