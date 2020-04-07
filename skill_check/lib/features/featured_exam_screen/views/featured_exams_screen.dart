import 'package:after_layout/after_layout.dart';
import 'package:skill_check/features/featured_exam_screen/providers/featured_exam_list_screen_provider.dart';
import 'package:skill_check/features/home_screen/views/widgets/fail_to_load_data_error_widget.dart';
import 'package:skill_check/features/featured_exam_screen/views/featured_exam_list_tile.dart';
import 'package:skill_check/features/recent_exam/widgets/search_bar_widget.dart';
import 'package:skill_check/main_app/util/strings_utils.dart';
import 'package:skill_check/main_app/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeaturedExamsScreen extends StatefulWidget {
  @override
  _FeaturedExamsScreenState createState() => _FeaturedExamsScreenState();
}

class _FeaturedExamsScreenState extends State<FeaturedExamsScreen>
    with AfterLayoutMixin {
  ScrollController _scrollController = ScrollController();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    var featuredExamListScreenProvider =
        Provider.of<FeaturedExamListScreenProvider>(context,listen: false);

    featuredExamListScreenProvider.sinkSearchQuery("");

    featuredExamListScreenProvider.listenStream();
    
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          featuredExamListScreenProvider.hasMoreData && !featuredExamListScreenProvider.isFetchingMoreData) {
        featuredExamListScreenProvider.getMoreData();
      }
    });
    
  }

  Widget _noDataWidget(BuildContext context) => Container(
      height: 60,
      child: Center(
          child: Text(
        "-- END --",
        style: Theme.of(context).textTheme.title.apply(color: Colors.grey),
      )));

  Widget _loaderWidget(BuildContext context) =>
      Container(height: 60, child: Center(child: CupertinoActivityIndicator()));

  Widget _pageLoader() => Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
        child: Loader(),
      );

  Widget _searchBarWidget() {
    return SearchBarWidget(
      autofocus: false,
      onChanged: (data) {
        Provider.of<FeaturedExamListScreenProvider>(context)
            .sinkSearchQuery(data);
      },
      onClear: () {
        Provider.of<FeaturedExamListScreenProvider>(context)
            .sinkSearchQuery("");
        print("on clear");
      },
    );
  }

  Widget _searchLoader(context) {
    return StreamBuilder(
        stream: Provider.of<FeaturedExamListScreenProvider>(context)
            .searchQueryStream,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              Provider.of<FeaturedExamListScreenProvider>(context)
                  .isBusyLoading)
            return Container(height: 60, child: Loader());
          else
            return SizedBox();
        });
  }

  Widget _buildFeaturedListBody() {
    return Consumer<FeaturedExamListScreenProvider>(
        builder: (context, featuredExamListScreenProvider, child) {
      if (featuredExamListScreenProvider.hasError) {
        return FailToLoadDataErrorWidget(
          onTap: () {
            featuredExamListScreenProvider.getExamListData();
            featuredExamListScreenProvider.resetPageCounter();
          },
        );
      }

      ///  checking for if there is no item and fetch item then show item
      if (featuredExamListScreenProvider.featuredExamModelList.length == 0 &&
          featuredExamListScreenProvider.isBusyLoading) {
        return SizedBox();
      } else {
        return StreamBuilder(
          stream: featuredExamListScreenProvider.searchQueryStream,
          builder: (context, snapshot) {
            if (featuredExamListScreenProvider.featuredExamModelList.length ==
                    0 &&
                snapshot.hasData) {
              if (!featuredExamListScreenProvider.isBusyLoading &&
                  featuredExamListScreenProvider.inSearchMode) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 5),
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
            }

            /// showing page list view
            return ListView.separated(
              padding: EdgeInsets.all(8),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:
                  featuredExamListScreenProvider.featuredExamModelList.length +
                      1,
              itemBuilder: (context, index) {
                /// showing lazy loading item
                if (featuredExamListScreenProvider
                        .featuredExamModelList.length ==
                    index) {
                  if (featuredExamListScreenProvider.hasMoreData) {
                    if (!featuredExamListScreenProvider.isFetchingMoreData) {
                      /// showing nothing when idle
                      return SizedBox();
                    } else {
                      /// showing loader when fetching data
                      return _loaderWidget(context);
                    }
                  } else {
                    /// End Widget when no data
                    return _noDataWidget(context);
                  }
                } else {
                  /// showing exam tile
                  return FeaturedExamListTile(
                    featuredExamModel: featuredExamListScreenProvider
                        .featuredExamModelList[index],
                    index: index,
                  );
                }
              },
              separatorBuilder: (context, i) {
                return Divider(
                  height: 2,
                  color: Theme.of(context).scaffoldBackgroundColor,
                );
              },
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(StringUtils.featuredExamsText),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Provider.of<FeaturedExamListScreenProvider>(context,listen: false).resetState();
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
                    [_searchLoader(context), _buildFeaturedListBody()]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
