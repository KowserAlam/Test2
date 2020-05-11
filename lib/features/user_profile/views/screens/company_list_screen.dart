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
  var _companyAutocompleteKey = new GlobalKey<AutoCompleteTextFieldState<Company>>();
  List<Company> companySuggestion = [];
  FocusNode _companyNameFocusNode;
  Company selectedCompany;
  String _companyNameErrorText;

  @override
  void initState() {
    // TODO: implement initState
    _companyNameController.addListener(() {
      if (_companyNameController.text.length > 3) {
        _companyAutocompleteKey.currentState.suggestions = [];
        _debouncer.run(() {
          CompanyListRepository()
              .getList(query: _companyNameController.text)
              .then((value) {
            value.fold((l) {
              //left
              print(l);
              _companyAutocompleteKey.currentState.suggestions = [];
            }, (List<Company> r) {
//              //right
              companySuggestion = r;
              _companyAutocompleteKey.currentState.updateSuggestions(r);
              _companyAutocompleteKey.currentState.updateOverlay();

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
    var nameOfCompany = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("  " + StringUtils.nameOfCompany ?? "",
            style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(7),
            boxShadow: CommonStyleTextField.boxShadow,
          ),
          child: AutoCompleteTextField<Company>(
            focusNode: _companyNameFocusNode,
            decoration: InputDecoration(
              hintText: StringUtils.currentCompanyHint,
              border: InputBorder.none,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              focusedBorder: CommonStyleTextField.focusedBorder(context),
            ),
            controller: _companyNameController,
            itemFilter: (Company suggestion, String query) => true,
            suggestions: companySuggestion,
            itemSorter: (Company a, Company b) => a.name.compareTo(b.name),
            key: _companyAutocompleteKey,
            itemBuilder: (BuildContext context, Company suggestion) {
              return ListTile(
                title: Text(suggestion.name ?? ""),
              );
            },
            clearOnSubmit: false,
            itemSubmitted: (Company data) {
              selectedCompany = data;
//                    _companyNameController.text = data.name;
              _companyAutocompleteKey.currentState.updateSuggestions([]);
              setState(() {});
            },
          ),
        ),
        if (_companyNameErrorText != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _companyNameErrorText,
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );

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
              nameOfCompany,
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
