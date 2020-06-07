import 'package:after_layout/after_layout.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:p7app/features/company/models/company.dart';
import 'package:p7app/features/company/view_model/company_list_view_model.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';
import 'package:p7app/main_app/widgets/loader.dart';
import 'company_details.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/debouncer.dart';
import 'package:p7app/main_app/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class CompanyListScreen extends StatefulWidget {
  @override
  _CompanyListScreenState createState() => _CompanyListScreenState();
}

class _CompanyListScreenState extends State<CompanyListScreen>
    with AfterLayoutMixin {
  TextEditingController _companyNameController = TextEditingController();

//  Company selectedCompany;

  @override
  void afterFirstLayout(BuildContext context) {
    var companyViewModel =
        Provider.of<CompanyListViewModel>(context, listen: false);
    companyViewModel.getCompanyList();
  }

  @override
  Widget build(BuildContext context) {
    var companyViewModel = Provider.of<CompanyListViewModel>(context);
    List<Company> companySuggestion = companyViewModel.companyList == null
        ? []
        : companyViewModel.companyList;
    void search() {
      companyViewModel.query = _companyNameController.text;
      companyViewModel.getCompanyList();
//      print(companyViewModel.companyList.length);
    }

    var backgroundColor = Theme.of(context).backgroundColor;
    var scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var titleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
    double iconSize = 14.0;
    var subtitleColor = isDarkMode ? Colors.white : AppTheme.grey;

    return WillPopScope(
      onWillPop: () async {
        companyViewModel.resetState();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringUtils.companyListAppbarText),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                CustomTextField(
                  controller: _companyNameController,
                  hintText: 'Search',
                  autofocus: true,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (v) {
                    search();
//                    if (_companyNameController.text.length > 2) {
//                      search();
//                    } else {
//                      BotToast.showText(text: StringUtils.searchLetterCapText);
//                    }
                  },
                  onChanged: (v) {
                    if (_companyNameController.text.isEmpty) {
                      companyViewModel.resetState();
                    }
                  },
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      search();
//                      if (_companyNameController.text.length > 2) {
//                        search();
//                      } else {
//                        BotToast.showText(
//                            text: StringUtils.searchLetterCapText);
//                      }
                    },
                  ),
                ),
                companyViewModel.shouldShowCompanyCount
                    ? Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: companyViewModel.isFetchingData
                              ? [Text('Searching..')]
                              : [
                                  Text(companyViewModel.noOfSearchResults
                                      .toString()),
//                                  if(companyViewModel.shouldShowCompanyCount)
                                  companyViewModel.noOfSearchResults > 1
                                      ? Text(' companies found')
                                      : Text(' company found')
                                ],
                        ))
                    : SizedBox(),

                companyViewModel.isFetchingData
                    ? Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Loader(),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: companySuggestion.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                CompanyDetails(
                                                  company:
                                                      companySuggestion[index],
                                                )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: scaffoldBackgroundColor,
//        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              blurRadius: 10),
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              blurRadius: 10),
                                        ]),
                                    margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          color: backgroundColor,
                                          padding: EdgeInsets.all(8),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  color:
                                                      scaffoldBackgroundColor,
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      companySuggestion[index]
                                                              .profilePicture ??
                                                          "",
                                                  placeholder: (context, _) =>
                                                      Image.asset(
                                                          kCompanyImagePlaceholder),
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    companySuggestion[index]
                                                            .name ??
                                                        "",
                                                    style: titleStyle,
                                                  ),
//                                                SizedBox(height: 3),
//                                                Text(
//                                                  companySuggestion[index].yearOfEstablishment ?? "",
//                                                  style: TextStyle(color: subtitleColor),
//                                                ),
                                                  SizedBox(height: 10),
                                                  if (companySuggestion[index]
                                                          .address !=
                                                      null)
                                                    Container(
                                                      child: Row(
                                                        children: <Widget>[
                                                          Icon(
                                                            FeatherIcons.mapPin,
                                                            color:
                                                                subtitleColor,
                                                            size: iconSize,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              companySuggestion[
                                                                          index]
                                                                      .address ??
                                                                  "",
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color:
                                                                      subtitleColor),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                ],
                                              )),
                                              SizedBox(width: 8),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 1),
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          color: backgroundColor,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    'Year of Establishment: ',
                                                    style: TextStyle(
                                                        color: subtitleColor,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    companySuggestion[index]
                                                                .yearOfEstablishment !=
                                                            null
                                                        ? DateFormatUtil.formatDate(
                                                            companySuggestion[
                                                                    index]
                                                                .yearOfEstablishment)
                                                        : StringUtils
                                                            .unspecifiedText,
                                                    style: TextStyle(
                                                        color: subtitleColor,
                                                        fontWeight:
                                                            FontWeight.w100),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                            }),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
