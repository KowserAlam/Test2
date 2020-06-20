import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:p7app/features/career_advice/models/career_advice_model.dart';
import 'package:p7app/features/career_advice/view/career_advice_details_screen.dart';
import 'package:p7app/features/career_advice/view_models/career_advice_view_model.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';
import 'package:p7app/main_app/widgets/loader.dart';
import 'package:provider/provider.dart';

class CareerAdviceScreen extends StatefulWidget {
  CareerAdviceScreen({Key key}) : super(key: key);

  @override
  _CareerAdviceScreenState createState() => _CareerAdviceScreenState();
}

class _CareerAdviceScreenState extends State<CareerAdviceScreen>
    with AfterLayoutMixin {
  ScrollController _scrollController = ScrollController();

  @override
  void afterFirstLayout(BuildContext context) {
    var vm = Provider.of<CareerAdviceViewModel>(context, listen: false);
    vm.getData(isFromOnPageLoad: true);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (vm.shouldFetchMoreData) vm.getMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

//  var url = "${FlavorConfig?.instance?.values?.baseUrl}${Urls.careerAdviceWeb}";
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<CareerAdviceViewModel>(context);
    List<CareerAdviceModel> adviceList = vm.careerAdviceList;

    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.careerAdviceText),
      ),
      body: RefreshIndicator(
        onRefresh: vm.refresh,
        child: vm.shouldShowPageLoader
            ? Center(
                child: Loader(),
              )
            : ListView.builder(
                controller: _scrollController,
                itemCount: adviceList.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == adviceList.length) {
                    return vm.isFetchingMoreData
                        ? Padding(padding: EdgeInsets.all(15), child: Loader())
                        : SizedBox();
                  }

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => CareerAdviceDetailsScreen(
                                careerAdviceModel: adviceList[index],
                              )));
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        //borderRadius: BorderRadius.circular(5),
                        gradient: AppTheme.lightLinearGradient,
                        border: Border.all(width: 1, color: Colors.grey[300]),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10),
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            adviceList[index].title,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            adviceList[index].author,
                            style: TextStyle(
                                fontSize: 12, color: Colors.lightBlueAccent),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Html(
                            data: adviceList[index].shortDescription,
                            defaultTextStyle: TextStyle(
                              fontSize: 14,
                            ),
                          ),
//                          Text(
//                            adviceList[index].shortDescription,
//                            style: TextStyle(
//                              fontSize: 14,
//                            ),
//                            maxLines: 2,
//                            overflow: TextOverflow.ellipsis,
//                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                DateFormatUtil.formatDate(
                                        adviceList[index].createdAt) ??
                                    "",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  border: Border.all(
                                      color: Colors.grey[400], width: 1),
                                  //borderRadius: BorderRadius.circular(3)
                                ),
                                child: Center(
                                  child: Text(
                                    StringUtils.readMoreText,
                                    style: TextStyle(color: Colors.blueAccent),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}
