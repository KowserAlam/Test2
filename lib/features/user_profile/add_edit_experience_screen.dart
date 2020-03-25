import 'package:after_layout/after_layout.dart';
import 'package:assessment_ishraak/features/user_profile/providers/experiance_provider.dart';
import 'package:assessment_ishraak/features/user_profile/models/user_profile_models.dart';
import 'package:assessment_ishraak/main_app/util/strings_utils.dart';
import 'package:assessment_ishraak/main_app/util/validator.dart';
import 'package:assessment_ishraak/main_app/widgets/edit_screen_save_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNewExperienceScreen extends StatefulWidget {
  final Experience experienceModel;
  final int index;

  AddNewExperienceScreen({this.experienceModel, this.index});

  @override
  _AddNewExperienceScreenState createState() =>
      _AddNewExperienceScreenState(experienceModel, index);
}

class _AddNewExperienceScreenState extends State<AddNewExperienceScreen>
    with AfterLayoutMixin {
  final Experience experienceModel;
  final int index;

  _AddNewExperienceScreenState(this.experienceModel, this.index);

  TextEditingController organizationNameController = TextEditingController();
  TextEditingController positionNameController = TextEditingController();
  TextEditingController roleNameController = TextEditingController();

  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void afterFirstLayout(BuildContext context) {
    var expProvider = Provider.of<ExperienceProvider>(context);

    if (experienceModel != null) {
      organizationNameController.text = experienceModel.organizationName;
      positionNameController.text = experienceModel.position;
      roleNameController.text = experienceModel.role;
      expProvider.currentLyWorkingHere = experienceModel.currentlyWorkHere;
      expProvider.joiningDate = experienceModel.joiningDate;
      expProvider.leavingDate = experienceModel.leavingDate;
    }
  }


  _handleSave() {
    var isSuccess = _formKey.currentState.validate();
    var addEditProvider = Provider.of<ExperienceProvider>(context);

    if (isSuccess) {
      var exp = Experience(
        organizationName: organizationNameController.text,
        currentlyWorkHere: addEditProvider.currentLyWorkingHere,
        joiningDate: addEditProvider.joiningDate,
        leavingDate: addEditProvider.leavingDate,
        role: roleNameController.text,
        position: positionNameController.text,
      );

      if (experienceModel == null || index == null) {
        exp.id= Uuid().v1();
        addEditProvider.addData(_formKey.currentContext, exp);
      } else {
        exp.id= experienceModel.id;
        addEditProvider.updateData(
            _formKey.currentContext, exp, index);
      }

      /// Navigate to previous screen
      Navigator.pop(_scaffoldKey.currentContext);
      addEditProvider.clearState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<ExperienceProvider>(context).clearState();
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(StringUtils.experienceText),
          actions: <Widget>[
            EditScreenSaveButton(
              text: StringUtils.saveText,
              onPressed: _handleSave,
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Consumer<ExperienceProvider>(
            builder: (context, addEditExperienceProvider, ch) {
              return Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ///Name

                      TextFormField(
                        validator: Validator().nullFieldValidate,
                        controller: organizationNameController,
                        style: Theme.of(context).textTheme.title,
                        decoration: InputDecoration(
                            labelText: StringUtils.nameOfOrganizationText,
                            hintText: StringUtils.nameOfOrganizationEg),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      /// Position

                      TextFormField(
                        validator: Validator().nullFieldValidate,
                        style: Theme.of(context).textTheme.title,
                        controller: positionNameController,
                        decoration: InputDecoration(
                            labelText: StringUtils.positionText,
                            hintText: StringUtils.positionTextEg),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      /// Role

                      TextFormField(
                        controller: roleNameController,
                        keyboardType: TextInputType.multiline,
                        style: Theme.of(context).textTheme.title,
                        maxLines: null,
                        decoration: InputDecoration(
                            labelText: StringUtils.roleText,
                            hintText: StringUtils.roleTextEg),
                      ),

                      /// Joining Date
                      SizedBox(
                        height: 16,
                      ),

                      Row(
                        children: <Widget>[
                          Text(
                            StringUtils.joiningDateText,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.title,
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              addEditExperienceProvider.currentLyWorkingHere =
                                  !addEditExperienceProvider
                                      .currentLyWorkingHere;
                            },
                            child: Text(
                              StringUtils.currentlyWorkingHereText,
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Checkbox(
                            value:
                                addEditExperienceProvider.currentLyWorkingHere,
                            onChanged: (v) {
                              addEditExperienceProvider.currentLyWorkingHere =
                                  v;
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),

                      InkWell(
                        onTap: () {
                          _showJoinDatePicker(context);
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(.6))),
                          padding: EdgeInsets.all(8),
                          child: Text(
                            addEditExperienceProvider.joiningDate != null
                                ? DateFormat()
                                    .add_yMMMMd()
                                    .format(
                                        addEditExperienceProvider.joiningDate)
                                    .toString()
                                : "",
                            style: Theme.of(context).textTheme.title,
                          ),
                        ),
                      ),

                      /// Leaving Date
                      SizedBox(
                        height: 16,
                      ),

                      Text(
                        StringUtils.leavingDateText,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.title.apply(
                            color:
                                addEditExperienceProvider.currentLyWorkingHere
                                    ? Colors.grey
                                    : null),
                      ),

                      SizedBox(
                        height: 8,
                      ),

                      InkWell(
                        onTap: !addEditExperienceProvider.currentLyWorkingHere
                            ? () {
                                _showLeavingDatePicker(context);
                              }
                            : null,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(.6))),
                          padding: EdgeInsets.all(8),
                          child: Text(
                            addEditExperienceProvider.leavingDate != null
                                ? DateFormat()
                                    .add_yMMMMd()
                                    .format(
                                        addEditExperienceProvider.leavingDate)
                                    .toString()
                                : "",
                            style: Theme.of(context).textTheme.title.apply(
                                color: addEditExperienceProvider
                                        .currentLyWorkingHere
                                    ? Colors.grey
                                    : null),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _showJoinDatePicker(context) {
    var provider = Provider.of<ExperienceProvider>(context);
    var initialDate = DateTime.now();
    if (provider.joiningDate == null) {
      provider.onJoiningDateChangeEvent(DateTime.now());
    } else {
      initialDate = provider.joiningDate;
    }
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 1.3,
              child: Material(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: CupertinoTheme(
                        data: CupertinoThemeData(),
                        child: CupertinoDatePicker(
                          initialDateTime: initialDate,
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: provider.onJoiningDateChangeEvent,
                        ),
                      ),
                    ),
                    InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.done,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _showLeavingDatePicker(context) {
    var provider = Provider.of<ExperienceProvider>(context);
    var initialDate = DateTime.now();
    if (provider.leavingDate == null) {
      provider.onLeavingDateChangeEvent(DateTime.now());
    } else {
      initialDate = provider.leavingDate;
    }
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 1.3,
              child: Material(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: CupertinoTheme(
                        data: CupertinoThemeData(),
                        child: CupertinoDatePicker(
                          initialDateTime: initialDate,
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: provider.onLeavingDateChangeEvent,
                        ),
                      ),
                    ),
                    InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.done,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }


}

class ErrorWidget extends StatelessWidget {
  final String errorText;
  final Widget child;

  ErrorWidget({
    this.errorText,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (errorText == null) {
      return child;
    } else {
      return Container(
        child: Wrap(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).errorColor, width: 2)),
              child: child,
            )
          ],
        ),
      );
    }
  }
}
