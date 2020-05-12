import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:p7app/features/user_profile/models/company.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';

class CompanyDetails extends StatefulWidget {
  final Company company;
  CompanyDetails({@required this.company});
  @override
  _CompanyDetailsState createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {

  @override
  Widget build(BuildContext context) {
    Company companyDetails = widget.company;

    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color sectionColor = Theme.of(context).backgroundColor;
    Color summerySectionBorderColor = Colors.grey[300];
    Color summerySectionColor =
    !isDarkMode ? Colors.grey[200] : Colors.grey[600];
    Color backgroundColor = !isDarkMode ? Colors.grey[200] : Colors.grey[700];

    //Styles
    TextStyle headerTextStyle =
    new TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    TextStyle sectionTitleFont =
    TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
    TextStyle descriptionFontStyle = TextStyle(fontSize: 13);
    TextStyle topSideDescriptionFontStyle = TextStyle(
        fontSize: 14, color: !isDarkMode ? Colors.grey[600] : Colors.grey[500]);
    TextStyle descriptionFontStyleBold =
    TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
    double fontAwesomeIconSize = 15;

    double iconSize = 14;
    double sectionIconSize = 20;
    Color clockIconColor = Colors.orange;

    Text jobSummeryRichText(String title, String description) {
      return Text.rich(
        TextSpan(children: <TextSpan>[
          TextSpan(text: title, style: descriptionFontStyleBold),
          TextSpan(text: ': ', style: descriptionFontStyleBold),
          TextSpan(text: description, style: descriptionFontStyle),
        ]),
        style: descriptionFontStyle,
      );
    }


    var dividerUpperSide = Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey[300])),
            margin: EdgeInsets.only(right: 10),
            child: Image.asset(
              kImagePlaceHolderAsset,
              fit: BoxFit.cover,
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        child: Text(
                          companyDetails.name != null
                              ? companyDetails.name
                              : StringUtils.unspecifiedText,
                          style: headerTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      companyDetails.email != null
                          ? companyDetails.email
                          : StringUtils.unspecifiedText,
                      style: topSideDescriptionFontStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          FeatherIcons.mapPin,
                          size: iconSize,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Text(
                            companyDetails.address != null
                                ? companyDetails.address
                                : StringUtils.unspecifiedText,
                            style: topSideDescriptionFontStyle,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );

    Widget titleHeader(IconData icon, String title){
      return Row(
        children: <Widget>[
          Icon(icon),
          Text(
            title,
            style: sectionTitleFont,
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.companyListText),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            color: backgroundColor,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: sectionColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(3),
                          topRight: Radius.circular(3))),
                  child: dividerUpperSide,
                ),
                SizedBox(height: 5,),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: sectionColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(3),
                          topRight: Radius.circular(3))),
                  child: Column(
                    children: [
                      titleHeader(Icons.person_outline, "Organization Head"),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            //gradient: isDarkMode?AppTheme.darkLinearGradient:AppTheme.lightLinearGradient,
                            border: Border.all(width: 1, color: summerySectionBorderColor),
                            color: summerySectionColor),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: <Widget>[
                                jobSummeryRichText(
                                    StringUtils.companyHeadNameText,
                                    companyDetails.organizationHead != null
                                        ? companyDetails.organizationHead.toString()
                                        : StringUtils.unspecifiedText)
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: <Widget>[
                                jobSummeryRichText(
                                    StringUtils.companyHeadDesignationText,
                                    companyDetails.organizationHeadDesignation != null
                                        ? companyDetails.organizationHeadDesignation.toString()
                                        : StringUtils.unspecifiedText)
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: <Widget>[
                                jobSummeryRichText(
                                    StringUtils.companyHeadNumberText,
                                    companyDetails.organizationHeadNumber != null
                                        ? companyDetails.organizationHeadNumber.toString()
                                        : StringUtils.unspecifiedText)
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
