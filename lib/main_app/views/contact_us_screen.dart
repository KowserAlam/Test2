import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  static double _cameraZoom = 10.4746;
  Completer<GoogleMapController> _controller = Completer();
  final CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(23.7104, 90.40744),
    zoom: _cameraZoom,
  );

  List<Marker> markers = [];

  Future<void> _goToPosition({double lat, double long}) async {
    var markId = MarkerId("Ishraak Solutions");
    Marker _marker = Marker(
      onTap: () {
        print("tapped");
      },
      position: LatLng(lat, long),
      infoWindow: InfoWindow(title: "Ishraak Solutions"),
      markerId: markId,
    );
    markers.add(_marker);
    final GoogleMapController _googleMapController = await _controller.future;
    var position = CameraPosition(
      target: LatLng(lat, long),
      zoom: _cameraZoom,
    );

    _googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(position));
  }

  @override
  void initState() {
    double lat = 23.773222;
    double long = 90.411298;

    if (lat != null && long != null) {
      _goToPosition(lat: lat, long: long);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle sectionTitleFont = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
    TextStyle descriptionFontStyle = TextStyle(fontSize: 13);
    TextStyle descriptionFontStyleBold = TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
    double fontAwesomeIconSize = 15;
    
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
    var googleMap = Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            FaIcon(
              FeatherIcons.mapPin,
              size: fontAwesomeIconSize,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              StringUtils.contactUsLocationText,
              style: sectionTitleFont,
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            markers: markers.toSet(),
            gestureRecognizers: Set()
              ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
              ..add(Factory<ScaleGestureRecognizer>(
                      () => ScaleGestureRecognizer()))
              ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
              ..add(Factory<VerticalDragGestureRecognizer>(
                      () => VerticalDragGestureRecognizer())),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            initialCameraPosition: initialCameraPosition,
          ),
        ),
      ],
    );
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
          ),
          SizedBox(height: 30,),
          Container(
            margin: EdgeInsets.all(15),
            child: googleMap,
          )
        ],
      ),
    );
  }
}
