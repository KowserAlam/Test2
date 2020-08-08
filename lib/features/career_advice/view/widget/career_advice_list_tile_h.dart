import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/career_advice/models/career_advice_model.dart';
import 'package:p7app/main_app/resource/const.dart';

import '../career_advice_details_screen.dart';

class CareerAdviceListTileH extends StatelessWidget {
  final CareerAdviceModel adviceModel;

  CareerAdviceListTileH(this.adviceModel);

  @override
  Widget build(BuildContext context) {
//    print(adviceModel.featuredImage);
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Card(
        elevation: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Container(
            width: 180,
            child: Stack(
              children: [
                CachedNetworkImage(
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: adviceModel.featuredImage ?? "",
                  placeholder: (c, i) => Image.asset(
                    kCareerAdvicePlaceholder,
                    colorBlendMode: BlendMode.color,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black12,
                            Colors.black45,
                            Colors.black87,
                          ])),
                ),
                Column(
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        adviceModel.title ?? "",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (BuildContext context) =>
                                CareerAdviceDetailsScreen(
                                  careerAdviceModel: adviceModel,
                                )));
                      },
                      child: Center(),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}