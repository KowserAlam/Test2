import 'package:skill_check/main_app/util/strings_utils.dart';
import 'package:flutter/material.dart';

class EditScreenSaveButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  EditScreenSaveButton({
    @required this.onPressed,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).primaryColor,
          child: InkWell(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text,
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .apply(color: Theme.of(context).backgroundColor)),
            ),
          ),
        ),
      ),
    );
  }
}
