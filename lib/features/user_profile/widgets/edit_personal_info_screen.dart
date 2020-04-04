import 'package:p7app/main_app/resource/strings_utils.dart';
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
