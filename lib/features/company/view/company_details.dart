import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:p7app/features/company/models/company.dart';
import 'package:p7app/features/company/view/widgets/company_details_formatted_text.dart';
import 'package:p7app/features/company/view/widgets/company_section_base.dart';
import 'package:p7app/features/company/view/open_jobs_widget.dart';
import 'package:p7app/main_app/api_helpers/url_launcher_helper.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';
import 'package:p7app/main_app/views/widgets/show_location_on_map_widget.dart';
import 'package:p7app/method_extension.dart';

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

    bool hideBasicInfo = (companyDetails.companyProfile.isEmptyOrNull &&
        companyDetails.yearOfEstablishment == null &&
        companyDetails.basisMemberShipNo.isEmptyOrNull);
    bool hideSocialNetwork = (companyDetails.companyNameFacebook == null &&
        companyDetails.companyNameFacebook == null &&
        companyDetails.companyNameGoogle == null);
    bool hideContactPerson = (companyDetails.contactPerson.isEmptyOrNull &&
        companyDetails.contactPersonDesignation.isEmptyOrNull &&
        companyDetails.contactPersonMobileNo.isEmptyOrNull &&
        companyDetails.contactPersonEmail.isEmptyOrNull);

    var header = CompanySectionBase(
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
                  kCompanyImagePlaceholder,
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
                          companyDetails.name ?? StringResources.noneText,
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
    var basicInfo = hideBasicInfo
        ? SizedBox()
        : CompanySectionBase(
            sectionIcon: FeatherIcons.userCheck,
            sectionLabel: StringResources.companyBasicInfoSectionText,
            sectionBody: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (companyDetails?.companyProfile != null)
                  HtmlWidget(
                    "<b>${StringResources.companyProfileText}: </b> ${companyDetails.companyProfile ?? ""}",
                    textStyle: descriptionFontStyle,
                  ),
//                  Text.rich(
//                    TextSpan(children: [
//                      TextSpan(
//                          text: StringResources.companyProfileText + ': ',
//                          style: descriptionFontStyleBold),
//                      WidgetSpan(
//                        child: HtmlWidget(
//                          companyDetails.companyProfile ?? "",
//                          textStyle: descriptionFontStyle,
//                        ),
//                      ),
////                      TextSpan(
////                          text: companyDetails.companyProfile,
////                          style: descriptionFontStyle),
//
////              WidgetSpan(
////                  child: GestureDetector(
////                      onTap: () {
////                        UrlLauncherHelper.launchUrl(
////                            companyDetails.companyProfile.trim());
////                      },
////                      child: Text(
////                        companyDetails.companyProfile,
////                        style: TextStyle(color: Colors.lightBlue),
////                      )))
//                    ]),
//                    textAlign: TextAlign.justify,
//                  ),
                SizedBox(height: 5),
                CompanyDetailsFormattedText(
                    StringResources.companyYearsOfEstablishmentText,
                    companyDetails.yearOfEstablishment != null
                        ? DateFormatUtil.formatDate(
                            companyDetails.yearOfEstablishment)
                        : StringResources.noneText),
                SizedBox(
                  height: 5,
                ),
                CompanyDetailsFormattedText(
                    StringResources.companyBasisMembershipNoText,
                    companyDetails.basisMemberShipNo),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          );

    var address = (companyDetails.address.isEmptyOrNull &&
            companyDetails.city.isEmptyOrNull &&
            companyDetails.country.isEmptyOrNull)
        ? SizedBox()
        : CompanySectionBase(
            sectionLabel: StringResources.companyAddressSectionText,
            sectionIcon: FeatherIcons.map,
            sectionBody: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CompanyDetailsFormattedText(
                    StringResources.companyAddressText, companyDetails.address),
                SizedBox(height: 5),
//
//          richText(StringUtils.companyIndustryText, companyDetails.companyProfile),
//          SizedBox(height: 5,),

                CompanyDetailsFormattedText(
                    StringResources.companyCityText, companyDetails.city),
                SizedBox(height: 5),

                (companyDetails.country.isEmptyOrNull)
                    ? SizedBox()
                    : CompanyDetailsFormattedText(
                        StringResources.jobCountryText, companyDetails.country),
//                CompanyDetailsFormattedText(
//                    StringResources.companyCountryText, companyDetails.country),
                SizedBox(height: 5),
              ],
            ),
          );

    var contact = (companyDetails.companyContactNoOne.isEmptyOrNull &&
            companyDetails.companyContactNoTwo.isEmptyOrNull &&
            companyDetails.companyContactNoThree.isEmptyOrNull)
        ? SizedBox()
        : CompanySectionBase(
            sectionLabel: StringResources.companyContactSectionText,
            sectionIcon: FeatherIcons.userCheck,
            sectionBody: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: StringResources.companyEmailText + ': ',
                              style: descriptionFontStyleBold),
                          WidgetSpan(
                            child: GestureDetector(
                                onTap: () {
                                  UrlLauncherHelper.sendMail(
                                      companyDetails.email.trim());
                                },
                                child: Text(
                                  companyDetails.email ?? "",
                                  softWrap: true,
                                  style: TextStyle(color: Colors.lightBlue),
                                )),
                          )
                        ])),
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
                            Text.rich(
                              TextSpan(children: [
                                TextSpan(
                                    text:
                                        StringResources.companyWebAddressText +
                                            ': ',
                                    style: descriptionFontStyleBold),
                                WidgetSpan(
                                  child: GestureDetector(
                                      onTap: () {
                                        UrlLauncherHelper.launchUrl(
                                            companyDetails.webAddress.trim());
                                      },
                                      child: Text(
                                        companyDetails.webAddress,
                                        style:
                                            TextStyle(color: Colors.lightBlue),
                                      )),
                                )
                              ]),
                              softWrap: true,
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
            ),
          );

    var socialNetworks = hideSocialNetwork
        ? SizedBox()
        : CompanySectionBase(
            sectionLabel: StringResources.companySocialNetworksSectionText,
            sectionIcon: FeatherIcons.cast,
            sectionBody: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //Company facebook
                  companyDetails.companyNameFacebook == null
                      ? SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Facebook: ',
                                    style: descriptionFontStyleBold),
                                SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      UrlLauncherHelper.launchUrl(companyDetails
                                          .companyNameFacebook
                                          .trim());
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
                                Text('BdJobs: ',
                                    style: descriptionFontStyleBold),
                                SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      UrlLauncherHelper.launchUrl(companyDetails
                                          .companyNameFacebook
                                          .trim());
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
                                      UrlLauncherHelper.launchUrl(companyDetails
                                          .companyNameGoogle
                                          .trim());
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
            ),
          );

    var organizationHead = (companyDetails.organizationHead.isEmptyOrNull &&
            companyDetails.organizationHeadDesignation.isEmptyOrNull &&
            companyDetails.organizationHeadNumber.isEmptyOrNull)
        ? SizedBox()
        : CompanySectionBase(
            sectionIcon: FeatherIcons.userCheck,
            sectionLabel: StringResources.companyOrganizationHeadSectionText,
            sectionBody: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CompanyDetailsFormattedText(
                    StringResources.companyOrganizationHeadNameText,
                    companyDetails.organizationHead),
                SizedBox(height: 5),
                CompanyDetailsFormattedText(
                    StringResources.companyOrganizationHeadDesignationText,
                    companyDetails.organizationHeadDesignation),
                SizedBox(
                  height: 5,
                ),
                CompanyDetailsFormattedText(
                    StringResources.companyOrganizationHeadMobileNoText,
                    companyDetails.organizationHeadNumber),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          );

    var contactPerson = hideContactPerson
        ? SizedBox()
        : CompanySectionBase(
            sectionLabel: StringResources.companyContactPersonSectionText,
            sectionIcon: FeatherIcons.userCheck,
            sectionBody: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CompanyDetailsFormattedText(
                    StringResources.companyContactPersonNameText,
                    companyDetails.contactPerson),
                SizedBox(height: 5),
                CompanyDetailsFormattedText(
                    StringResources.companyContactPersonDesignationText,
                    companyDetails.contactPersonDesignation),
                SizedBox(height: 5),
                CompanyDetailsFormattedText(
                    StringResources.companyContactPersonMobileNoText,
                    companyDetails.contactPersonMobileNo),
                SizedBox(height: 5),
                CompanyDetailsFormattedText(
                    StringResources.companyContactPersonEmailText,
                    companyDetails.contactPersonEmail),
                SizedBox(height: 5),
              ],
            ),
          );

    var otherInfo = (companyDetails.legalStructure.isEmptyOrNull &&
            companyDetails.noOfHumanResources.isEmptyOrNull &&
            companyDetails.noOfResources.isEmptyOrNull)
        ? SizedBox()
        : CompanySectionBase(
            sectionLabel: StringResources.companyOtherInformationText,
            sectionIcon: FontAwesomeIcons.exclamationCircle,
            sectionBody: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CompanyDetailsFormattedText(
                    StringResources.companyLegalStructureText,
                    companyDetails.legalStructure),
                SizedBox(
                  height: 5,
                ),
                CompanyDetailsFormattedText(
                    StringResources.companyNoOFHumanResourcesText,
                    companyDetails.noOfHumanResources),
                SizedBox(
                  height: 5,
                ),
                CompanyDetailsFormattedText(
                    StringResources.companyNoOFItResourcesText,
                    companyDetails.noOfResources),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          );

    var googleMap = (companyDetails?.latitude != null &&
            companyDetails?.longitude != null)
        ? CompanySectionBase(
            sectionLabel: StringResources.companyLocationOnMapText,
            sectionIcon: FeatherIcons.mapPin,
            sectionBody: ShowLocationOnMapWidget(
              latLng: LatLng(companyDetails.latitude, companyDetails.longitude),
              markerLabel: companyDetails.name,
            ))
        : SizedBox();

    var openJobs = OpenJobsWidget(companyDetails.name);

    return Scaffold(
      appBar: AppBar(
        title: Text(StringResources.companyDetailsText),
      ),
      body: ListView(
        key: Key("companyDetailsListViewKey"),
        children: [
          Container(
            padding: EdgeInsets.all(10),
            color: backgroundColor,
            child: Column(
              children: [
                header,
                SizedBox(height: 2),
                basicInfo,
                SizedBox(height: 2),
                address,
                SizedBox(height: 2),
                contact,
//                SizedBox(height: 2),
//                organizationHead,
//                SizedBox(height: 2),
//                contactPerson,
                SizedBox(height: 2),
                socialNetworks,
                SizedBox(height: 2),
                otherInfo,
                SizedBox(height: 2),
                googleMap,
                SizedBox(height: 10),
                openJobs,
                SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}
