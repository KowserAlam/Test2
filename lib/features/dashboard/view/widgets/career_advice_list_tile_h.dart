import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/career_advice/models/career_advice_model.dart';
import 'package:p7app/main_app/resource/const.dart';

import '../../../career_advice/view/career_advice_details_screen.dart';

class CareerAdviceListTileH extends StatelessWidget {
  final CareerAdviceModel adviceModel;
  final int index;

  CareerAdviceListTileH(this.adviceModel, this.index);

  @override
  Widget build(BuildContext context) {
//    logger.i(adviceModel.featuredImage);
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Card(
        key: Key(adviceModel.id.toString()),
        elevation: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: InkWell(
            key: Key('careerAdviceTile${(index + 1)}'),
            onTap: () {
              Navigator.of(context).push(CupertinoPageRoute(
                  builder: (BuildContext context) => CareerAdviceDetailsScreen(
                        careerAdviceModel: adviceModel,
                      )));
            },
            child: Container(
              width: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CachedNetworkImage(
                    height: 100,
                    width: 180,
                    fit: BoxFit.cover,
                    imageUrl: adviceModel.featuredImage ?? "",
                    placeholder: (c, i) => Image.asset(
                      kCareerAdvicePlaceholder,
                      colorBlendMode: BlendMode.color ,
                      height: 100,
                      width: 180,
                      fit: BoxFit.fitWidth,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                    child: Text(
                      adviceModel.title ?? "",
                      style: TextStyle(
                        // color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Icon(Icons.person,size: 12, color: Colors.grey,),
                        SizedBox(width: 3,),
                        Text(
                          adviceModel.author ?? "",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                    child: Text(
                      adviceModel.shortDescription ?? "",
                      style: TextStyle(
                        // color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 12
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
