import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/user_profile/models/company.dart';
import 'package:p7app/features/user_profile/repositories/company_list_repository.dart';
import 'package:p7app/features/user_profile/styles/common_style_text_field.dart';
import 'package:p7app/features/user_profile/view_models/company_list_view_model.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/debouncer.dart';
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

  void updateSuggestion(){
    var companyViewModel =     Provider.of<CompanyListViewModel>(context);
    _companyNameController.addListener(() {
      if(_companyNameController.text.length > 2){
        companyViewModel.query = _companyNameController.text;

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var companyViewModel = Provider.of<CompanyListViewModel>(context);
    List<Company> companySuggestion = companyViewModel.companyList==null?[]:companyViewModel.companyList;
    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.companyListText),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              TextField(
                controller: _companyNameController,
                onChanged: (v){
                  if(v.length >2){
                    companyViewModel.query = v;
                    companyViewModel.getJobDetails();
                    print(companyViewModel.companyList.length);
                  }else{
                    companyViewModel.query = "";
                    companyViewModel.getJobDetails();
                  }
                },
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: companySuggestion.length,
                    itemBuilder: (BuildContext context, int index){
                      return GestureDetector(
                          onTap: (){
                            print(companySuggestion[index].name);
                          },
                          child: ListTile(title: Text(companySuggestion[index].name),));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
