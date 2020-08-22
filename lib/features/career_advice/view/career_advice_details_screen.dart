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
  
  final  coverImageHeight = 170.0;
  final  profileImageHW = 120.0;

  @override
  Widget build(BuildContext context) {
   var left =( MediaQuery.of(context).size.width/2)-(profileImageHW/2)-16;
    return Scaffold(
      appBar: AppBar(
        title: Text(careerAdviceModel.title ?? ""),
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 4,
          margin: EdgeInsets.all(8),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4)),
                    child: CachedNetworkImage(
                      width: double.infinity,
                      height: coverImageHeight,
                      fit: BoxFit.cover,
                      imageUrl: careerAdviceModel.featuredImage ?? "",
                      placeholder: (c, i) => Image.asset(
                        kCareerAdvicePlaceholder,
                        colorBlendMode: BlendMode.color,
                        width: double.infinity,
                        height: coverImageHeight,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: left,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: profileImageHW,
                        width: profileImageHW,
                        child: Card( elevation: 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: careerAdviceModel.thumbnailImage ?? "",

                              placeholder: (context, _) => Image.asset(
                                kDefaultUserImageAsset,
                                fit: BoxFit.cover,
                              ),
                              progressIndicatorBuilder: (c, _, p) => Loader(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(

                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                        ),
                        Text(
                          careerAdviceModel.title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          careerAdviceModel.author,
                          style:
                              TextStyle(fontSize: 13, color: Colors.blueAccent),
                        ),
                        SizedBox(height: 5),
                        Text(
                          DateFormatUtil()
                                  .dateFormat1(careerAdviceModel.postedAt) ??
                              "",
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[600]),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
