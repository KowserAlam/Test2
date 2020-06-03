import 'package:flutter/material.dart';
import 'package:p7app/features/career_advice/models/career_advice_model.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';

class CareerAdviceDetailsScreen extends StatelessWidget {
  final CareerAdviceModel careerAdviceModel;
  CareerAdviceDetailsScreen({@required this.careerAdviceModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(10),
        color: Colors.grey[200],
        child: ListView(children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(careerAdviceModel.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                SizedBox(height: 5,),
                Text(careerAdviceModel.author, style: TextStyle(fontSize: 13, color: Colors.blueAccent),),
                SizedBox(height: 5,),
                Text(DateFormatUtil().dateFormat1(DateTime.parse(careerAdviceModel.createdDate)).toString().toString(), style: TextStyle(fontSize: 13, color: Colors.grey[600]),),
                SizedBox(height: 12,),
                Text(careerAdviceModel.description, style: TextStyle(fontSize: 15),)
              ],
            ),
          )
        ],),
      ),
    );
  }
}
