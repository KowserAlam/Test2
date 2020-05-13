import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:p7app/features/company/models/company.dart';
import 'package:p7app/features/company/view_model/company_list_view_model.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
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

class _CompanyListScreenState extends State<CompanyListScreen> {
  TextEditingController _companyNameController = TextEditingController();
  Debouncer _debouncer = Debouncer(milliseconds: 400);
  Company selectedCompany;

  


  @override
  Widget build(BuildContext context) {
    var companyViewModel = Provider.of<CompanyListViewModel>(context);
    List<Company> companySuggestion = companyViewModel.companyList==null?[]:companyViewModel.companyList;
    void updateSuggestion(){
      companyViewModel.query = _companyNameController.text;
      companyViewModel.getJobDetails();
      print(companyViewModel.companyList.length);
    }

    var backgroundColor = Theme.of(context).backgroundColor;
    var scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var titleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
    double iconSize = 14.0;
    var subtitleColor = isDarkMode ? Colors.white : AppTheme.grey;


    return WillPopScope(
      onWillPop: () async{
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
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                CustomTextField(
                  controller: _companyNameController,
                  hintText: 'Search',
                  onSubmitted: (v){
                    if(_companyNameController.text.length>2){
                      updateSuggestion();
                    }else{
                      BotToast.showText(text: StringUtils.searchLetterCapText);
                    }
                  },
                  onChanged: (v){
                    if(_companyNameController.text.length==0){
                      companyViewModel.resetState();
                    }
                  },
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: (){
                      if(_companyNameController.text.length>2){
                        updateSuggestion();
                      }else{
                        BotToast.showText(text: StringUtils.searchLetterCapText);
                      }
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: companySuggestion.length,
                      itemBuilder: (BuildContext context, int index){
                        return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => CompanyDetails(company: companySuggestion[index],)));
                            },
                            child: Container(
                              decoration: BoxDecoration(color: scaffoldBackgroundColor,
                                  boxShadow: [
                                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
                                    BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10),
                                  ]),
                              margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    color: backgroundColor,
                                    padding: EdgeInsets.all(8),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: scaffoldBackgroundColor,
                                          ),
                                          child: CachedNetworkImage(
                                            placeholder: (context, _) => Image.asset(
                                              kImagePlaceHolderAsset,
                                              fit: BoxFit.cover,
                                            ),
                                            imageUrl: companySuggestion[index].profilePicture ?? "",
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(companySuggestion[index].name, style: TextStyle(fontWeight: FontWeight.bold),),
                                                SizedBox(height: 10,),
                                                companySuggestion[index].address==null?SizedBox():Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        FeatherIcons.mapPin,
                                                        color: subtitleColor,
                                                        size: iconSize,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          companySuggestion[index].address ?? "",
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(color: subtitleColor),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )),
                                        //heartButton,
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
