import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/user_profile/models/company.dart';
import 'package:p7app/features/user_profile/repositories/company_list_repository.dart';
import 'package:p7app/features/user_profile/styles/common_style_text_field.dart';
import 'package:p7app/features/user_profile/view_models/company_list_view_model.dart';
import 'package:p7app/features/user_profile/views/screens/company_details.dart';
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
  void initState() {
    // TODO: implement initState
    //updateSuggestion();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var companyViewModel = Provider.of<CompanyListViewModel>(context);
    List<Company> companySuggestion = companyViewModel.companyList==null?[]:companyViewModel.companyList;
    void updateSuggestion(){
      companyViewModel.query = _companyNameController.text;
      companyViewModel.getJobDetails();
      print(companyViewModel.companyList.length);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.companyListText),
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
                            padding: EdgeInsets.symmetric(vertical: 10),
                              margin: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(width: 1,color: Colors.grey[400]),
                              ),
                              child: ListTile(
                                leading: CachedNetworkImage(
                                  placeholder: (context, _) => Image.asset(
                                    kImagePlaceHolderAsset,
                                    fit: BoxFit.cover,
                                  ),
                                  imageUrl: companySuggestion[index]?.profilePicture ?? "",
                                ),
                                title: Text(companySuggestion[index].name),)));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }


}
