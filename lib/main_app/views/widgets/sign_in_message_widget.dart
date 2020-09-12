import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/auth/view/sign_in_screen.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/app_logo.dart';

class SignInMessageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppLogo(size: 100,),
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  StringResources.pleaseSignInToProceed,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(

                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(StringResources.signInButtonText),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => SignInScreen()));

                    }),
                SizedBox(
                  height: 10,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
