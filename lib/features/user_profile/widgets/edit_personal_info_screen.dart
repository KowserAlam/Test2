import 'package:assessment_ishraak/main_app/util/strings_utils.dart';
import 'package:flutter/material.dart';

class EditPersonalInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.personalInfoText),
      ),
    );
  }
}
