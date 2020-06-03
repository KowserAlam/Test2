import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/career_advice/view_models/career_advice_view_model.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/flavour/flavour_config.dart';
import 'package:p7app/features/career_advice/models/career_advice_model.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/views/widgets/pge_view_widget.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CareerAdviceScreen extends StatefulWidget {
  CareerAdviceScreen({Key key}) : super(key: key);

  @override
  _CareerAdviceScreenState createState() => _CareerAdviceScreenState();
}

class _CareerAdviceScreenState extends State<CareerAdviceScreen>
    with AfterLayoutMixin {
  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<CareerAdviceViewModel>(context, listen: false).getData();
  }

//  var url = "${FlavorConfig?.instance?.values?.baseUrl}${Urls.careerAdviceWeb}";
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<CareerAdviceViewModel>(context);
    List<CareerAdviceModel> adviceList =
        vm.careerAdviceScreenDataModel?.careerAdviceList ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.careerAdviceText),
      ),
      body: ListView.builder(
          itemCount: adviceList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: AppTheme.lightLinearGradient,
                border: Border.all(width: 1, color: Colors.grey[300]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    adviceList[index].title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    adviceList[index].author,
                    style:
                        TextStyle(fontSize: 12, color: Colors.lightBlueAccent),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    adviceList[index].description,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        adviceList[index].createdDate,
                        style: TextStyle(color: Colors.grey),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border:
                                Border.all(color: Colors.grey[400], width: 1),
                            borderRadius: BorderRadius.circular(3)),
                        child: Center(
                          child: Text(
                            'Read More',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
