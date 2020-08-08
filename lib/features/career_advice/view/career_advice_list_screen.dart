import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:p7app/features/career_advice/models/career_advice_model.dart';
import 'package:p7app/features/career_advice/view/career_advice_details_screen.dart';
import 'package:p7app/features/career_advice/view/widget/career_advice_list_tile.dart';
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                padding: EdgeInsets.symmetric(horizontal: 4,vertical: 12),
                controller: _scrollController,
                itemCount: adviceList.length + 1,
                separatorBuilder: (context, index) => SizedBox(
                      height: 8,
                    ),
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


