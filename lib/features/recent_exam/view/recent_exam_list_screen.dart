import 'package:after_layout/after_layout.dart';
import 'package:p7app/features/enrolled_exam_list_screen/providers/enrolled_exam_list_screen_provider.dart';
import 'package:p7app/features/home_screen/views/widgets/fail_to_load_data_error_widget.dart';
import 'package:p7app/features/recent_exam/models/recent_exam_model.dart';
import 'package:p7app/features/recent_exam/view/recent_exam_list_tile_widget.dart';
import 'package:p7app/features/recent_exam/providers/recent_exam_list_provider.dart';

import 'package:p7app/features/recent_exam/widgets/search_bar_widget.dart';
import 'package:p7app/main_app/widgets/loader.dart';
import 'package:p7app/main_app/widgets/search_bar_view_widget.dart';
import 'package:p7app/main_app/util/strings_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentExamScreen extends StatefulWidget {
  @override
  _RecentExamScreenState createState() => _RecentExamScreenState();
}

class _RecentExamScreenState extends State<RecentExamScreen>
    with AfterLayoutMixin {
  ScrollController _scrollController = ScrollController();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void afterFirstLayout(BuildContext context) {
    var recentExamListScreenProvider =
        Provider.of<RecentExamListScreenProvider>(context,listen: false);

    recentExamListScreenProvider.sinkSearchQuery("");

    recentExamListScreenProvider.listenStream();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          recentExamListScreenProvider.hasMoreData &&
          !recentExamListScreenProvider.isFetchingMoreData) {
        recentExamListScreenProvider.getMoreData();
      }
    });
  }

  Widget _searchBarWidget() => SearchBarWidget(
        autofocus: false,
        onChanged: (data) {
          Provider.of<RecentExamListScreenProvider>(context)
              .sinkSearchQuery(data);
        },
        onClear: () {
          Provider.of<RecentExamListScreenProvider>(context)
              .sinkSearchQuery("");
//          print("on clear");
        },
      );

  Widget _placeHolder(context) {
    return Consumer<RecentExamListScreenProvider>(
        builder: (context, recentExamListScreenProvider, child) {

      return StreamBuilder(
          stream: recentExamListScreenProvider.searchQueryStream,
          builder: (context, snapshot) {
//            print("place holder");
            if (snapshot.hasData && recentExamListScreenProvider.isBusyLoading)
              return Container(height: 60, child: Loader());
            else if (snapshot.hasData &&
                recentExamListScreenProvider.recentExamModelList.length == 0 &&
                recentExamListScreenProvider.inSearchMode) {
              return Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  StringUtils.noExamFoundText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey.withOpacity(0.5), fontSize: 28),
                ),
              );
            } else {
              return SizedBox();
            }
          });
    });
  }

  Widget _endWidget(BuildContext context) => Container(
      height: 60,
      child: Center(
          child: Text(
        "-- END --",
        style: Theme.of(context).textTheme.title.apply(color: Colors.grey),
      )));

  Widget _loaderWidget(BuildContext context) =>
      Container(height: 60, child: Center(child: CupertinoActivityIndicator()));

  Widget _examListView() => Consumer<RecentExamListScreenProvider>(
          builder: (context, recentExamListScreenProvider, child) {
        if (recentExamListScreenProvider.hasError) {
          return FailToLoadDataErrorWidget(
            onTap: () {
              recentExamListScreenProvider.getExamListData();
            },
          );
        }
        if (recentExamListScreenProvider.recentExamModelList == null &&
            recentExamListScreenProvider.isBusyLoading) {
          return Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
            child: Loader(),
          );
        } else {
          return ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 10),
            itemCount: recentExamListScreenProvider.recentExamModelList.length+1,
            separatorBuilder: (BuildContext context, int index) {

              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 0.5,
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Divider(),
                ),
              );
            },
            itemBuilder: (BuildContext context, int index) {
              /// showing lazy loading item
              if (recentExamListScreenProvider.recentExamModelList.length ==
                  index) {
                if (recentExamListScreenProvider.hasMoreData) {
                  if (!recentExamListScreenProvider.isFetchingMoreData) {
                    /// showing nothing when idle
                    return SizedBox();
                  } else {
                    /// showing loader when fetching data
                    return _loaderWidget(context);
                  }
                } else {
                  /// End Widget when no data
                  return recentExamListScreenProvider
                              .recentExamModelList.length ==
                          0
                      ? SizedBox()
                      : _endWidget(context);
                }
              }

              return RecentExamListTileWidget(
                index: index,
                recentExamModel:
                    recentExamListScreenProvider.recentExamModelList[index],
              );
            },
          );
        }
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(StringUtils.recentExamsText),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Provider.of<RecentExamListScreenProvider>(context,listen: false).resetState();
          return true;
        },
        child: SafeArea(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                  automaticallyImplyLeading: false,
                  floating: true,
                  snap: true,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: _searchBarWidget()),
              SliverList(
                delegate: SliverChildListDelegate.fixed(
                    [_placeHolder(context), _examListView()]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
