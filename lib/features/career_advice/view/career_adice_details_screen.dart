import 'package:flutter/material.dart';
import 'package:p7app/features/career_advice/models/career_advice_model.dart';

class CareerAdviceDetailsScreen extends StatelessWidget {
  final CareerAdviceModel careerAdviceModel;
  CareerAdviceDetailsScreen({@required this.careerAdviceModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          ],
        )
      ],),
    );
  }
}
