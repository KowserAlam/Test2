import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/user_profile/models/company.dart';
import 'package:p7app/features/user_profile/repositories/company_list_repository.dart';
import 'package:p7app/features/user_profile/styles/common_style_text_field.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/debouncer.dart';


class CompanyListScreen extends StatefulWidget {
  @override
  _CompanyListScreenState createState() => _CompanyListScreenState();
}

class _CompanyListScreenState extends State<CompanyListScreen> {
  TextEditingController _companyNameController = TextEditingController();
  Debouncer _debouncer = Debouncer(milliseconds: 400);
  List<Company> companySuggestion = [];
  FocusNode _companyNameFocusNode;
  Company selectedCompany;
  String _companyNameErrorText;

  @override
  void initState() {
    // TODO: implement initState
    _companyNameController.addListener(() {
      if (_companyNameController.text.length > 3) {
        _debouncer.run(() {
          CompanyListRepository()
              .getList(query: _companyNameController.text)
              .then((value) {
            value.fold((l) {
              //left
              print(l);
            }, (List<Company> r) {
//              //right
              companySuggestion = r;
              //_companyAutocompleteKey.currentState.updateSuggestions(r);
              //_companyAutocompleteKey.currentState.updateOverlay();

//            setState(() {
//
//            });
            });
          });
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              ),
              Container(
                height: MediaQuery.of(context).size.height/2,
                child: ListView.builder(
                  itemCount: companySuggestion.length,
                  itemBuilder: (BuildContext context, int index){
                    return ListTile(title: Text(companySuggestion[index].name),);
                  }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
