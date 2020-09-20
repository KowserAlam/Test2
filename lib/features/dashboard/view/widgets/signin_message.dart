import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:p7app/features/auth/view/sign_in_screen.dart';
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
              Text(StringResources.dashboardLoginMessage,textAlign: TextAlign.center,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    color: Colors.white, onPressed: () {

                      Get.to(SignInScreen());
                },child: Text(StringResources.signInButtonText),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
