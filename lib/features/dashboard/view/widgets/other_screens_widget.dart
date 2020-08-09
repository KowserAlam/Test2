import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/about_us_screen.dart';
import 'package:p7app/main_app/views/contact_us_screen.dart';
import 'package:p7app/main_app/views/faq_screen.dart';

class OtherScreensWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _navigateTo(Widget page) {
      Navigator.of(context)
          .push(CupertinoPageRoute(builder: (BuildContext context) {
        return page;
      }));
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Items(
              key: Key('dashBoardFaqTile'),
              icon: FontAwesomeIcons.questionCircle,
              label: StringResources.faqText,
              onPressed: () {
                _navigateTo(FAQScreen());
              },
            ),
          ),
          Expanded(
              child: Items(
            key: Key('dashBoardContactUsTile'),
            icon: FontAwesomeIcons.at,
            label: StringResources.contactUsText,
            onPressed: () {
              _navigateTo(ContactUsScreen());
            },
          )),
          Expanded(
              child: Items(
            key: Key('dashBoardAboutUsTile'),
            icon: FontAwesomeIcons.infoCircle,
            label: StringResources.aboutUsText,
            onPressed: () {
              _navigateTo(AboutUsScreen());
            },
          )),
        ],
      ),
    );
  }

  Widget Items({
    @required IconData icon,
    @required String label,
    @required VoidCallback onPressed,
    Key key
  }) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var screenHeight = MediaQuery.of(context).size.height;
        var deviceWidth = MediaQuery.of(context).size.width;
        double iconSize = deviceWidth * .183;
        double textFontSize = iconSize / 3;
        double boxHeight = iconSize * 1.1;
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: RawMaterialButton(
            key: key,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            fillColor: Theme.of(context).backgroundColor,
            elevation: 2,
            onPressed: onPressed,
            child: Container(
              height: boxHeight,
              child: Stack(
                children: [
                  Center(
                      child: Icon(
                    icon,
                    color: Colors.grey.withOpacity(0.1),
                    size: iconSize,
                  )),
                  Center(
                    child: Text(
                      label ?? "",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
