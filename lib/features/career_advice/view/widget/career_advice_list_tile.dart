import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/career_advice/models/career_advice_model.dart';
import 'package:p7app/main_app/resource/const.dart';

import '../career_advice_details_screen.dart';

class CareerAdviceListTile extends StatelessWidget {
  const CareerAdviceListTile({
    Key key,
    @required this.advice,
  }) : super(key: key);

  final CareerAdviceModel advice;

  Widget build(BuildContext context) {
//    print(adviceModel.featuredImage);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Card(
        elevation: 4,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Container(
            height: 170,
            child: Stack(
              children: [
                CachedNetworkImage(
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: advice.featuredImage ?? "",
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
                        Colors.black12,
                        Colors.black26,
                        Colors.black54,
                        Colors.black87,
                      ])),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacer(),
                      Text(
                        advice.title ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        advice.shortDescription ?? "",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (BuildContext context) =>
                                CareerAdviceDetailsScreen(
                                  careerAdviceModel: advice,
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
