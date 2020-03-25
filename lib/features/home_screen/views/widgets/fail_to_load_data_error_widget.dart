import 'package:p7app/features/home_screen/providers/dashboard_screen_provider.dart';
import 'package:p7app/main_app/util/strings_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FailToLoadDataErrorWidget extends StatelessWidget {
  final Function onTap;
  final String message;
  final Widget child;

  FailToLoadDataErrorWidget({this.onTap, this.message, this.child});

  @override
  Widget build(BuildContext context) {
    bool isLarge = MediaQuery.of(context).size.width > 720;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
        ),
        InkWell(
          borderRadius: BorderRadius.circular(60),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.exclamation,
                  size: 100,
                  color: Colors.grey.withOpacity(0.2),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    message ?? StringUtils.failedToLoadData,
                    style: TextStyle(
                        color: Colors.grey.withOpacity(0.5), fontSize: 30),
                  ),
                ),
                SizedBox(height: 20),
                child ?? Icon(FontAwesomeIcons.redo,size: 30,color: Colors.grey.withOpacity(0.2)),

              ],
            ),
          ),
        ),
        SizedBox(height: 60),
      ],
    );
  }
}
