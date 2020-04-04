import 'package:p7app/features/home_screen/models/dashboard_models.dart';
import 'package:p7app/features/featured_exam_screen/models/featured_exam_model.dart';
import 'package:p7app/features/home_screen/providers/dashboard_screen_provider.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/widgets/gredient_buton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeaturedExamCardItem extends StatelessWidget {
  final FeaturedExamModel featuredExamModel;
  final index;

  FeaturedExamCardItem({@required this.featuredExamModel, @required this.index})
      : assert(featuredExamModel != null, index != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      width: 230,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        boxShadow: [
          BoxShadow(color: Colors.black45,blurRadius: 6)
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: FadeInImage(
              width: double.infinity,
              placeholder: AssetImage(kExamCoverImageAsset),
              image: featuredExamModel.image != null
                  ? NetworkImage(featuredExamModel.image)
                  : AssetImage(kExamCoverImageAsset),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Theme.of(context).backgroundColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    featuredExamModel.examName,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "${featuredExamModel.examCode}",
                        maxLines: 3,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "${featuredExamModel.examFee == "0" ? "Free" : "৳${featuredExamModel.examFee}"}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Consumer<DashboardScreenProvider>(
              builder: (context, dashboardScreenProvider, c) {
            return Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.3), blurRadius: 10),
                  ],
                  gradient: !featuredExamModel.isEnrolled
                      ? AppTheme.defaultLinearGradient
                      : LinearGradient(colors: [
                          Colors.green,
                          Colors.green,
                        ])),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: featuredExamModel.isEnrolled
                      ? null
                      : () {
                          _enrollConfirmation(context);
                        },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      featuredExamModel.isEnrolled
                          ? StringUtils.enrolledText
                          : StringUtils.enrollText,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .apply(color: Colors.white),
                    ),
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  _enrollConfirmation(context) {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              height: 200,
              width: 300,
              child: Material(
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          StringUtils.areYouSure,
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: GradientButton(
                              label: StringUtils.noText,
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GradientButton(
                              label: StringUtils.yesText,
                              onTap: () {
                                Provider.of<DashboardScreenProvider>(context,listen: false)
                                    .enrollExam(
                                        examId: featuredExamModel.id.toString(),
                                        index: index);

                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
