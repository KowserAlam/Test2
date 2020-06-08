import 'package:flutter/material.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';

class JobsOnMap extends StatefulWidget {
  @override
  _JobsOnMapState createState() => _JobsOnMapState();
}

class _JobsOnMapState extends State<JobsOnMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.jobsOnMapText),
      ),
    );
  }
}
