import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p7app/main_app/app_theme/common_style.dart';
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

    return Column(
      children: [
        Row(children: [
          SizedBox(width: 15,),
          Text(StringResources.moreInfoTitleText,
            style: CommonStyle.dashboardSectionTitleTexStyle,
          ),
        ],),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Items(
                  key: Key('dashBoardFAQTile'),
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
        ),
        SizedBox(height: 14,),
      ],
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
        var deviceWidth = MediaQuery.of(context).size.width;

        double iconSize = deviceWidth * .183;
        double textFontSize =  constraints.maxWidth/8;
        double boxHeight = iconSize * 1.1;
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: RawMaterialButton(
            key: key,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            fillColor: Theme.of(context).primaryColor,
            elevation: 2,
            onPressed: onPressed,
            child: Container(
              height: boxHeight,
              child: Stack(
                children: [
                  Center(
                      child: Icon(
                    icon,
                    color: Colors.grey.withOpacity(0.15),
                    size: iconSize,
                  )),
                  Center(
                    child: Text(
                      label ?? "",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(fontSize: textFontSize,fontWeight: FontWeight.bold),
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
