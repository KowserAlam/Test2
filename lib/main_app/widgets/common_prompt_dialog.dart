import 'package:flutter/material.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';

class CommonPromptDialog extends StatelessWidget {
  final String titleText;
  final Function onCancel;
  final Function onAccept;

  @override
  Widget build(BuildContext context) {
    var accentColor = Theme.of(context).accentColor;
    var buttonTextStyles = TextStyle(color: accentColor);
    
    return AlertDialog(
      title: Text(titleText),
      actions: [
        RawMaterialButton(
          onPressed: onCancel,
          child: Text(StringUtils.noText, style: buttonTextStyles),
        ),
        RawMaterialButton(
          onPressed: onAccept,
          child: Text(
            StringUtils.yesText,
            style: buttonTextStyles,
          ),
        ),
      ],
    );
  }

  const CommonPromptDialog({
    @required this.titleText,
    @required this.onCancel,
    @required this.onAccept,
  });
}
