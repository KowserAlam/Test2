import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:p7app/features/career_advice/models/career_advice_model.dart';
import 'package:p7app/features/career_advice/view/career_advice_details_screen.dart';
import 'package:p7app/features/career_advice/view_models/career_advice_view_model.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';
import 'package:p7app/main_app/views/widgets/loader.dart';
import 'package:provider/provider.dart';

class CareerAdviceListScreen extends StatefulWidget {
  CareerAdviceListScreen({Key key}) : super(key: key);

  @override
  _CareerAdviceListScreenState createState() => _CareerAdviceListScreenState();
}

class _CareerAdviceListScreenState extends State<CareerAdviceListScreen>
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
        title: Text(StringResources.careerAdviceText),
      ),
      body: RefreshIndicator(
        onRefresh: vm.refresh,
        child: vm.shouldShowPageLoader
            ? Center(
                child: Loader(),
              )
            : ListView.separated(
                controller: _scrollController,
                itemCount: adviceList.length + 1,
                separatorBuilder: (context,index)=>Divider(thickness: 1,),
                itemBuilder: (BuildContext context, int index) {
                  if (index == adviceList.length) {
                    return vm.isFetchingMoreData
                        ? Padding(padding: EdgeInsets.all(15), child: Loader())
                        : SizedBox();
                  }
                  CareerAdviceModel advice = adviceList[index];
                  return CareerAdviceListTile(
                    advice: advice,
                  );
                }),
      ),
    );
  }
}

class CareerAdviceListTile extends StatelessWidget {
  const CareerAdviceListTile({
    Key key,
    @required this.advice,
  }) : super(key: key);

  final CareerAdviceModel advice;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => CareerAdviceDetailsScreen(
                    careerAdviceModel: advice,
                  )));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: advice.thumbnailImage ?? "",
                        placeholder: (context, _) => Image.asset(
                          kDefaultUserImageAsset,
                          fit: BoxFit.cover,
                        ),
                        progressIndicatorBuilder: (c, _, p) => Loader(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          advice.title,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              advice.author,
                              style: TextStyle(color: Colors.lightBlueAccent),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Text(
                          DateFormatUtil.formatDate(advice.createdAt) ?? "",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              HtmlWidget(
                """${advice.shortDescription} <a style="text-decoration:none">   ${StringResources.moreTextSl}..</a>""",
                hyperlinkColor: Colors.blue,
                textStyle: TextStyle(
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 5),
//                Row(
//                  mainAxisSize: MainAxisSize.max,
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  crossAxisAlignment: CrossAxisAlignment.end,
//                  children: [
//                    Text(
//                      DateFormatUtil.formatDate(advice.createdAt) ?? "",
//                      style: TextStyle(color: Colors.grey),
//                    ),
////                                  Container(
////                                    padding: EdgeInsets.all(10),
////                                    decoration: BoxDecoration(
////                                      color: Colors.grey[200],
////                                      border: Border.all(
////                                          color: Colors.grey[400], width: 1),
////                                      //borderRadius: BorderRadius.circular(3)
////                                    ),
////                                    child: Center(
////                                      child: Text(
////                                        StringResources.readMoreText,
////                                        style: TextStyle(color: Colors.blueAccent),
////                                      ),
////                                    ),
////                                  )
//                  ],
//                )
            ],
          ),
        ),
      ),
    );
  }
}
