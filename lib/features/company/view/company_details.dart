import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:p7app/features/company/models/company.dart';
import 'package:p7app/features/company/view/company_section_base.dart';
import 'package:p7app/features/company/view/open_jobs_widget.dart';
import 'package:p7app/main_app/api_helpers/url_launcher_helper.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';
import 'package:p7app/method_extension.dart';
import 'package:uuid/uuid.dart';

class CompanyDetails extends StatefulWidget {
  final Company company;

  CompanyDetails({@required this.company});

  @override
  _CompanyDetailsState createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  static double _cameraZoom = 10.4746;
  Completer<GoogleMapController> _controller = Completer();
  final CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(23.7104, 90.40744),
    zoom: _cameraZoom,
  );

  List<Marker> markers = [];

  Future<void> _goToPosition({double lat, double long}) async {
    var markId = MarkerId(widget.company.name);
    Marker _marker = Marker(
      onTap: () {
        print("tapped");
      },
      position: LatLng(lat, long),
      infoWindow: InfoWindow(title: widget.company.name ?? ""),
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
    double lat = widget.company.latitude;
    double long = widget.company.longitude;

    if (lat != null && long != null) {
      _goToPosition(lat: lat, long: long);
    }
    super.initState();
  }

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

    Text richText(String title, String description) {
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
    var header = ProfileSectionBase(
      sectionBody: Container(
        padding: EdgeInsets.only(bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey[300])),
              margin: EdgeInsets.only(right: 10),
              child: CachedNetworkImage(
                placeholder: (context, _) => Image.asset(
                  kImagePlaceHolderAsset,
                  fit: BoxFit.cover,
                ),
                imageUrl: companyDetails.profilePicture ?? "",
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
                        child: Text(
                          companyDetails.name ??
                              StringResources.unspecifiedText,
                          style: headerTextStyle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    var basicInfo = ProfileSectionBase(
      sectionIcon: FeatherIcons.userCheck,
      sectionLabel: StringResources.companyBasicInfoSectionText,
      sectionBody: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (companyDetails?.companyProfile != null)
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: StringResources.companyProfileText + ': ',
                  style: descriptionFontStyleBold),
              WidgetSpan(
                  child: GestureDetector(
                      onTap: () {
                        UrlLauncherHelper.launchUrl(
                            companyDetails.companyProfile.trim());
                      },
                      child: Text(
                        companyDetails.companyProfile,
                        style: TextStyle(color: Colors.lightBlue),
                      )))
            ])),
          SizedBox(height: 5),
          richText(
              StringResources.companyYearsOfEstablishmentText,
              companyDetails.yearOfEstablishment != null
                  ? DateFormatUtil.formatDate(
                  companyDetails.yearOfEstablishment)
                  : StringResources.unspecifiedText),
          SizedBox(
            height: 5,
          ),
          richText(StringResources.companyBasisMembershipNoText,
              companyDetails.basisMemberShipNo),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );

    var address = ProfileSectionBase(
      sectionLabel: StringResources.companyAddressSectionText,
      sectionIcon: FeatherIcons.map,
      sectionBody: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          richText(StringResources.companyAddressText, companyDetails.address),
          SizedBox(height: 5),
//
//          richText(StringUtils.companyIndustryText, companyDetails.companyProfile),
//          SizedBox(height: 5,),

          richText(
              StringResources.companyCityText, companyDetails.city),
          SizedBox(height: 5),

          richText(
              StringResources.companyPostCodeText, companyDetails.postCode),
          SizedBox(height: 5),
        ],
      ),
    );



    var contact = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              FaIcon(
                FeatherIcons.userCheck,
                size: fontAwesomeIconSize,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                StringResources.companyContactSectionText,
                style: sectionTitleFont,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),

          //Company contact one
          companyDetails.companyContactNoOne == null
              ? SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.phone_android,
                          size: fontAwesomeIconSize,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(companyDetails.companyContactNoOne),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),

          //Company contact two
          companyDetails.companyContactNoTwo == null
              ? SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.phone_android,
                          size: fontAwesomeIconSize,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(companyDetails.companyContactNoTwo),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),

          //Company contact three
          companyDetails.companyContactNoThree == null
              ? SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.phone_android,
                          size: fontAwesomeIconSize,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(companyDetails.companyContactNoThree),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
//
//          richText(StringUtils.companyIndustryText, companyDetails.companyProfile),
//          SizedBox(height: 5,),

          //Email
          if (companyDetails.email != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(StringResources.companyEmailText + ': ',
                        style: descriptionFontStyleBold),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                        onTap: () {
                          UrlLauncherHelper.sendMail(
                              companyDetails.email.trim());
                        },
                        child: Text(
                          companyDetails.email ?? "",
                          style: TextStyle(color: Colors.lightBlue),
                        )),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),

          //Web address
          companyDetails.webAddress == null
              ? SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(StringResources.companyWebAddressText + ': ',
                            style: descriptionFontStyleBold),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                            onTap: () {
                              UrlLauncherHelper.launchUrl(
                                  companyDetails.webAddress.trim());
                            },
                            child: Text(
                              companyDetails.webAddress,
                              style: TextStyle(color: Colors.lightBlue),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );

    var socialNetworks = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              FaIcon(
                FeatherIcons.cast,
                size: fontAwesomeIconSize,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                StringResources.companySocialNetworksSectionText,
                style: sectionTitleFont,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),

          //Company facebook
          companyDetails.companyNameFacebook == null
              ? SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Facebook: ', style: descriptionFontStyleBold),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                            onTap: () {
                              UrlLauncherHelper.launchUrl(
                                  companyDetails.companyNameFacebook.trim());
                            },
                            child: Text(
                              companyDetails.companyNameFacebook,
                              style: TextStyle(color: Colors.lightBlue),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),

          //Company bdjobs
          companyDetails.companyNameBdjobs == null
              ? SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('BdJobs: ', style: descriptionFontStyleBold),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                            onTap: () {
                              UrlLauncherHelper.launchUrl(
                                  companyDetails.companyNameFacebook.trim());
                            },
                            child: Text(
                              companyDetails.companyNameBdjobs,
                              style: TextStyle(color: Colors.lightBlue),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),

          //Company google
          companyDetails.companyNameGoogle == null
              ? SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Google: ',
                          style: descriptionFontStyleBold,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                            onTap: () {
                              UrlLauncherHelper.launchUrl(
                                  companyDetails.companyNameGoogle.trim());
                            },
                            child: Text(
                              companyDetails.companyNameGoogle,
                              style: TextStyle(color: Colors.lightBlue),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
        ],
      ),
    );

    var organizationHead = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              FaIcon(
                FeatherIcons.userCheck,
                size: fontAwesomeIconSize,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                StringResources.companyOrganizationHeadSectionText,
                style: sectionTitleFont,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),

          richText(StringResources.companyOrganizationHeadNameText,
              companyDetails.organizationHead),
          SizedBox(
            height: 5,
          ),

          richText(StringResources.companyOrganizationHeadDesignationText,
              companyDetails.organizationHeadDesignation),
          SizedBox(
            height: 5,
          ),

          richText(StringResources.companyOrganizationHeadMobileNoText,
              companyDetails.organizationHeadNumber),
          SizedBox(
            height: 5,
          ),
//
//          richText(StringUtils.companyPostCodeText, companyDetails.postCode),
//          SizedBox(height: 5,),
        ],
      ),
    );

    var contactPerson = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              FaIcon(
                FeatherIcons.userCheck,
                size: fontAwesomeIconSize,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                StringResources.companyContactPersonSectionText,
                style: sectionTitleFont,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),

          richText(StringResources.companyContactPersonNameText,
              companyDetails.contactPerson),
          SizedBox(
            height: 5,
          ),

          richText(StringResources.companyContactPersonDesignationText,
              companyDetails.contactPersonDesignation),
          SizedBox(
            height: 5,
          ),

          richText(StringResources.companyContactPersonMobileNoText,
              companyDetails.contactPersonMobileNo),
          SizedBox(
            height: 5,
          ),

          richText(StringResources.companyContactPersonEmailText,
              companyDetails.contactPersonEmail),
          SizedBox(
            height: 5,
          ),
//
//          richText(StringUtils.companyPostCodeText, companyDetails.postCode),
//          SizedBox(height: 5,),
        ],
      ),
    );

    var otherInfo = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.exclamationCircle,
                size: fontAwesomeIconSize,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                StringResources.companyOtherInformationText,
                style: sectionTitleFont,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          richText(StringResources.companyLegalStructureText,
              companyDetails.legalStructure),
          SizedBox(
            height: 5,
          ),
          richText(StringResources.companyNoOFHumanResourcesText,
              companyDetails.noOfHumanResources),
          SizedBox(
            height: 5,
          ),
          richText(StringResources.companyNoOFItResourcesText,
              companyDetails.noOfResources),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );

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
              StringResources.companyLocationOnMapText,
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
    
    var openJobs = OpenJobsWidget(companyDetails.name);

    return Scaffold(
      appBar: AppBar(
        title: Text(StringResources.companyDetailsText),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            color: backgroundColor,
            child: Column(
              children: [
                header,
                SizedBox(
                    height: 2
                ),
basicInfo,
                SizedBox(
                    height: 2
                ),
                address,
                SizedBox(
                  height: 2
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                  decoration: BoxDecoration(
                      color: sectionColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(3),
                          topRight: Radius.circular(3))),
                  child: address,
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                  decoration: BoxDecoration(
                      color: sectionColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(3),
                          topRight: Radius.circular(3))),
                  child: contact,
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                  decoration: BoxDecoration(
                      color: sectionColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(3),
                          topRight: Radius.circular(3))),
                  child: organizationHead,
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                  decoration: BoxDecoration(
                      color: sectionColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(3),
                          topRight: Radius.circular(3))),
                  child: contactPerson,
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                  decoration: BoxDecoration(
                      color: sectionColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(3),
                          topRight: Radius.circular(3))),
                  child: socialNetworks,
                ),
                SizedBox(height: 2),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                  decoration: BoxDecoration(
                      color: sectionColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(3),
                          topRight: Radius.circular(3))),
                  child: otherInfo,
                ),
                SizedBox(height: 2),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                  decoration: BoxDecoration(
                      color: sectionColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(3),
                          topRight: Radius.circular(3))),
                  child: googleMap,
                ),
                SizedBox(height: 2),
                openJobs
              ],
            ),
          )
        ],
      ),
    );
  }
}
