import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:p7app/features/career_advice/models/career_advice_model.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';
import 'package:p7app/main_app/views/widgets/loader.dart';

class CareerAdviceDetailsScreen extends StatelessWidget {
  final CareerAdviceModel careerAdviceModel;

  CareerAdviceDetailsScreen({@required this.careerAdviceModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(careerAdviceModel.title??""),),
      body: Container(
        padding: EdgeInsets.all(10),
        color: Colors.grey[200],
        child: ListView(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: double.infinity,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: careerAdviceModel.featuredImage ?? "",
                              placeholder: (context, _) => Image.asset(
                                kDefaultUserImageAsset,
                                fit: BoxFit.cover,
                              ),
                              progressIndicatorBuilder: (c, _, p) => Loader(),
                            ),
                          ),
                        ),
                      ),

                      Text(
                        careerAdviceModel.title,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        careerAdviceModel.author,
                        style: TextStyle(fontSize: 13, color: Colors.blueAccent),
                      ),
                      SizedBox(height: 5),
                      Text(
                        DateFormatUtil().dateFormat1(careerAdviceModel.createdAt) ??
                            "",
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                    ],
                  ),


                  SizedBox(height: 12),
                  HtmlWidget(
                    careerAdviceModel.description,
                    textStyle: TextStyle(
                      fontSize: 15,
                    ),
                  ),
//                  Text(
//                    careerAdviceModel.description,
//                    style: TextStyle(fontSize: 15),
//                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
