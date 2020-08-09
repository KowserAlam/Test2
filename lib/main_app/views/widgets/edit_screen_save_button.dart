import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:flutter/material.dart';

class EditScreenSaveButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Key key;

  EditScreenSaveButton({
    @required this.onPressed,
    @required this.text,
    this.key
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text??"",
              key: key,
//              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
