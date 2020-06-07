import 'package:after_layout/after_layout.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:p7app/features/company/models/company.dart';
import 'package:p7app/features/company/view/company_list_tile.dart';
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
        companyViewModel.clearSearch();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringUtils.companyListAppbarText),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height-AppBar().preferredSize.height-30,
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                CustomTextField(
                  controller: _companyNameController,
                  hintText: StringUtils.companyListSearchText,
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
                SizedBox(height: 5,),
                companyViewModel.shouldShowCompanyCount
                    ? Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: companyViewModel.isFetchingData
                              ? [Text(StringUtils.companyListSearchingText)]
                              : [
                                  Text(companyViewModel.noOfSearchResults
                                      .toString()),
//                                  if(companyViewModel.shouldShowCompanyCount)
                                  companyViewModel.noOfSearchResults > 1
                                      ? Text(' '+StringUtils.companyListMultipleCompaniesFoundText)
                                      : Text(' '+StringUtils.companyListSingleCompanyFoundText)
                                ],
                        ))
                    : SizedBox(),

                companyViewModel.shouldShowLoader
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
                                  child: CompanyListTile(company: companySuggestion[index],));
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
