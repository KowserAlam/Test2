import 'package:flutter/material.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/widgets/edit_screen_save_button.dart';

class EditPortfolio extends StatefulWidget {
  @override
  _EditPortfolioState createState() => _EditPortfolioState();
}

class _EditPortfolioState extends State<EditPortfolio> {
  final _formKey = GlobalKey<FormState>();

  //TextEditingController
  final _portfolioNameController = TextEditingController();
  final _portfolioDescriptionController = TextEditingController();


  //FocusNodes
  final _portfolioNameFocusNode = FocusNode();
  final _portfolioDescriptionFocusNode = FocusNode();

  //widgets
  var spaceBetweenFields = SizedBox(height: 15,);

  @override
  Widget build(BuildContext context) {
    Function _handleSave = (){
      if(_formKey.currentState.validate()){
        print('validated');
      }else{
        print('not validated');
      }
    };
    return Scaffold(
      appBar: AppBar(
        title: Text('Portfolio'),
        actions: <Widget>[
          EditScreenSaveButton(
            text: StringUtils.saveText,
            onPressed: _handleSave,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //Name
                  CustomTextFormField(
                    validator: Validator().nullFieldValidate,
                    keyboardType: TextInputType.text,
                    focusNode: _portfolioNameFocusNode,
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (a) {
//                      FocusScope.of(context)
//                          .requestFocus(_currentPositionFocusNode);
                    },
                    controller: _portfolioNameController,
                    labelText: StringUtils.referenceNameText,
                    hintText: StringUtils.referenceNameText,
                  ),
                  spaceBetweenFields,
                  //Description
                  //Name
                  CustomTextFormField(
                    validator: Validator().nullFieldValidate,
                    keyboardType: TextInputType.text,
                    focusNode: _portfolioDescriptionFocusNode,
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (a) {
//                      FocusScope.of(context)
//                          .requestFocus(_currentPositionFocusNode);
                    },
                    controller: _portfolioDescriptionController,
                    labelText: StringUtils.referenceNameText,
                    hintText: StringUtils.referenceNameText,
                  ),
                  spaceBetweenFields,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
