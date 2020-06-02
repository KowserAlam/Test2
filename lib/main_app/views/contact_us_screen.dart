import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/flavour/flavour_config.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/views/widgets/pge_view_widget.dart';
import 'package:p7app/main_app/widgets/common_button.dart';
import 'package:p7app/main_app/widgets/custom_text_field.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContactUsScreen extends StatefulWidget {
  ContactUsScreen({Key key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  var url = "${FlavorConfig?.instance?.values?.baseUrl}${Urls.contactUsWeb}";

  @override
  Widget build(BuildContext context) {
    
    TextStyle titleStyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 18);
    Widget contactInfoItems(IconData iconData, String data){
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(iconData, size: 15,),
          SizedBox(width: 5,),
          Text(data, style: TextStyle(fontSize: 13),)
        ],
      );
    };

    var spaceBetweenLines = SizedBox(height: 10,);
    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.contactUsText),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: AppTheme.lightLinearGradient,
                      border: Border.all(width: 1, color: Colors.grey[300]),
                      //color: Colors.grey[200]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(StringUtils.contactUsContactInfoText,style: titleStyle,),
                      Divider(height: 25,),
                      contactInfoItems(Icons.pin_drop, 'House 76, Level 4,'),
                      spaceBetweenLines,
                      contactInfoItems(Icons.mail_outline, 'support@ishraak.com'),
                      spaceBetweenLines,
                      contactInfoItems(Icons.phone_in_talk, '01714111977'),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Text(StringUtils.contactUsKeepInTouchText, style: titleStyle,),
                SizedBox(height: 10,),
                CustomTextField(
                  hintText: StringUtils.contactUsNameText,
                ),
                spaceBetweenLines,
                CustomTextField(
                  hintText: StringUtils.contactUsEmailText,
                ),
                spaceBetweenLines,
                CustomTextField(
                  hintText: StringUtils.contactUsPhoneText,
                ),
                spaceBetweenLines,
                CustomTextField(
                  hintText: StringUtils.contactUsSubjectText,
                ),
                spaceBetweenLines,
                CustomTextField(
                  hintText: StringUtils.contactUsMessageText,
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 80),
            child: CommonButton(
              label: 'Submit',
              onTap: (){},
            ),
          )
        ],
      ),
    );
  }
}
