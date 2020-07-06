import 'package:flutter/material.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';

class CompanyDetailsFormattedText extends StatelessWidget {
  final String title;
  final String description;

   CompanyDetailsFormattedText(this.title, this.description);

  @override
  Widget build(BuildContext context) {

    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    TextStyle descriptionFontStyleBold =
    TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
    TextStyle descriptionFontStyle = TextStyle(fontSize: 13);
    double fontAwesomeIconSize = 15;
    TextStyle topSideDescriptionFontStyle = TextStyle(
        fontSize: 14, color: !isDarkMode ? Colors.grey[600] : Colors.grey[500]);
      return Text.rich(
      TextSpan(children: <TextSpan>[
        TextSpan(text: title, style: descriptionFontStyleBold),
        TextSpan(text: ': ', style: descriptionFontStyleBold),
        TextSpan(
            text: description == null
                ? StringResources.unspecifiedText
                : description,
            style: descriptionFontStyle),
      ]),
      style: descriptionFontStyle,
    );
  }
}
