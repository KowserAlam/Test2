import 'package:flutter/material.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';

class CommonPromptDialog extends StatelessWidget {
  final String titleText;
  final Function onCancel;
  final Function onAccept;
  final Widget content;

  @override
  Widget build(BuildContext context) {
//    var accentColor = Theme.of(context).accentColor;
    var buttonTextStyles = TextStyle(color: Colors.black);

    return AlertDialog(
      title: Text(titleText, key: Key('commonPromptText'),),
      content: content,
      actions: [
        RaisedButton(

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          key: Key('commonPromtNo'),
          color: Theme.of(context).primaryColor,
          onPressed: onCancel,
          child: SizedBox(
              height: 30,
              width: 80,
              child: Center(child: Text(StringResources.noText, style: buttonTextStyles))),
        ),

        RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          key: Key('commonPromptYes'),
          color: Theme.of(context).primaryColor,
          onPressed: onAccept,
          child: SizedBox(
            height: 30,
            width: 80,
            child: Center(
              child: Text(
                StringResources.yesText,
                style: buttonTextStyles,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
      ],
    );
  }

  const CommonPromptDialog({
    @required this.titleText,
    @required this.onCancel,
 this.content,
    @required this.onAccept, key,
  });
}
