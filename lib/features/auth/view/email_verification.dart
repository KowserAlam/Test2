import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/auth/view/sign_in_screen.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/common_button.dart';

class EmailVerification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(StringResources.verifyEmailAppbarTitle),),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(StringResources.verifyEmailMessage, textAlign: TextAlign.center,),
            SizedBox(height: 15,),
            CommonButton(
                width: 200,
                height: 50,
                label: StringResources.okText, onTap: (){
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (BuildContext context) => SignInScreen()));
            })
          ],
        ),
      ),
    );
  }
}
