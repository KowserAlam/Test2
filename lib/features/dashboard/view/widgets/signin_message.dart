import 'package:flutter/material.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';

class SigninMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("To get the best JobXprss experience, please login."),
              RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  color: Colors.white, onPressed: () {},child: Text(StringResources.signInButtonText),),
            ],
          ),
        ),
      ),
    );
  }
}
