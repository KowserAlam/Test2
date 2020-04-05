import 'package:flutter/material.dart';

class Job_Details extends StatefulWidget {
  @override
  _Job_DetailsState createState() => _Job_DetailsState();
}

class _Job_DetailsState extends State<Job_Details> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
      ),
    );
  }
}
