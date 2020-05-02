import 'package:skill_check/features/featured_exam_screen/providers/featured_exam_list_screen_provider.dart';
import 'package:skill_check/features/home_screen/models/dashboard_models.dart';
import 'package:skill_check/features/featured_exam_screen/models/featured_exam_model.dart';
import 'package:skill_check/features/home_screen/providers/dashboard_screen_provider.dart';
import 'package:skill_check/main_app/util/app_theme.dart';
import 'package:skill_check/main_app/util/const.dart';
import 'package:skill_check/main_app/util/strings_utils.dart';
import 'package:skill_check/main_app/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeaturedExamListTile extends StatelessWidget {
  final FeaturedExamModel featuredExamModel;
  final index;

  FeaturedExamListTile({@required this.featuredExamModel, @required this.index})
      : assert(featuredExamModel != null);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 8, right: 8),
        leading: Container(
          decoration:
              BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
          child: FadeInImage(
            height: 50,
            width: 60,
            fit: BoxFit.cover,
            placeholder: AssetImage(kExamCoverImageAsset),
            image: NetworkImage(featuredExamModel.image),
          ),
        ),
        title: Text(
            "${featuredExamModel.examCode} : ${featuredExamModel.examName} "),
        subtitle: Text("${featuredExamModel.examFee=="0"?"Free":"৳ 0"}"),
        trailing: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(color: Colors.black12,blurRadius: 10)
              ],
              gradient: featuredExamModel.isEnrolled
                  ? LinearGradient(colors: [
                      Colors.green,
                      Colors.green,
                    ])
                  : AppTheme.defaultLinearGradient),
          child: InkWell(
            onTap: () {
              Provider.of<FeaturedExamListScreenProvider>(context,listen: false)
                  .updateSateOnEnroll(index);
              _enrollConfirmation(context, featuredExamModel);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                StringUtils.enrollText,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _enrollConfirmation(context, FeaturedExamModel featuredExamModel) {
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
                                  examId: featuredExamModel.profSkillId.toString(),
                                );
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
