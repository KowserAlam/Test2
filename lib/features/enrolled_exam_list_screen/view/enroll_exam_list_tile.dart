import 'package:p7app/features/assessment/views/instruction_screen.dart';
import 'package:p7app/features/assessment/views/proceed_screen.dart';
import 'package:p7app/features/featured_exam_screen/models/featured_exam_model.dart';
import 'package:p7app/features/home_screen/models/dashboard_models.dart';
import 'package:p7app/features/enrolled_exam_list_screen/models/enrolled_exam_model.dart';
import 'package:p7app/features/home_screen/providers/dashboard_screen_provider.dart';
import 'package:p7app/features/home_screen/views/widgets/exam_duration_widget.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/util/const.dart';
import 'package:p7app/main_app/util/strings_utils.dart';
import 'package:p7app/main_app/widgets/gredient_buton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnrolledExamListTileWidget extends StatelessWidget {
  const EnrolledExamListTileWidget(
      {Key key, @required this.enrolledExamModel, this.index})
      : super(key: key);

  final EnrolledExamModel enrolledExamModel;
  final index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Material(
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
              image: NetworkImage(enrolledExamModel.image),
            ),
          ),
          title: Text(
            "${enrolledExamModel.examCode} : " + enrolledExamModel.examName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: ExamDurationWidget(
              duration: enrolledExamModel.examDurationMinutes),
          trailing: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              gradient: AppTheme.defaultLinearGradient,
            ),
            child: Text(
              StringUtils.startText,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => ExamInstructionScreen(
                          enrolledExamModel: enrolledExamModel,
                        )));
          },
        ),
      ),
    );
  }
}
