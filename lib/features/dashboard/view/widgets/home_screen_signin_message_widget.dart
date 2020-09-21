import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p7app/features/auth/view/sign_in_screen.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreenSigninMessageWidget extends StatelessWidget {
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
              Text(StringResources.dashboardLoginMessage,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w800)),
              SizedBox(
                height: 8,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: Colors.white,
                onPressed: () {
                  Get.to(SignInScreen());
                },
                child: Shimmer.fromColors(
                    baseColor: Colors.black,
                    highlightColor: Colors.yellow,

                  period : Duration(seconds: 2),
                    child: Text(
                  StringResources.signInButtonText,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                )),
              ),
              // SizedBox(height: 8,),
            ],
          ),
        ),
      ),
    );
  }
}
