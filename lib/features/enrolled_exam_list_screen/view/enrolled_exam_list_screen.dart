import 'package:after_layout/after_layout.dart';
import 'package:p7app/features/enrolled_exam_list_screen/providers/enrolled_exam_list_screen_provider.dart';
import 'package:p7app/features/enrolled_exam_list_screen/view/enroll_exam_list_tile.dart';
import 'package:p7app/features/home_screen/views/widgets/fail_to_load_data_error_widget.dart';
import 'package:p7app/features/recent_exam/widgets/search_bar_widget.dart';
import 'package:p7app/main_app/util/strings_utils.dart';
import 'package:p7app/main_app/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnrolledExamScreen extends StatefulWidget {
  @override
  _EnrolledExamScreenState createState() => _EnrolledExamScreenState();
}

class _EnrolledExamScreenState extends State<EnrolledExamScreen>
    with AfterLayoutMixin {
  ScrollController _scrollController = ScrollController();
  var _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void afterFirstLayout(BuildContext context) {
    var featuredExamListScreenProvider =
        Provider.of<EnrolledExamListScreenProvider>(context,listen: false);

    featuredExamListScreenProvider.sinkSearchQuery("");

    featuredExamListScreenProvider.listenStream();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          featuredExamListScreenProvider.hasMoreData &&
          !featuredExamListScreenProvider.isFetchingMoreData) {
        featuredExamListScreenProvider.getMoreData();
      }
    });
  }

  Widget _searchBarWidget() => SearchBarWidget(
        autofocus: false,
        onChanged: (data) {
          Provider.of<EnrolledExamListScreenProvider>(context)
              .sinkSearchQuery(data);
        },
        onClear: () {
          Provider.of<EnrolledExamListScreenProvider>(context)
              .sinkSearchQuery("");
          print("on clear");
        },
      );

  Widget _placeHolder(context) {
    return Consumer<EnrolledExamListScreenProvider>(
        builder: (context, enrolledExamListScreenProvider, c) {

      return StreamBuilder(
          stream: enrolledExamListScreenProvider.searchQueryStream,
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                enrolledExamListScreenProvider.isBusyLoading)
              return Container(height: 60, child: Loader());
            else if (snapshot.hasData &&
                enrolledExamListScreenProvider.enrolledExamModelList.length ==
                    0 &&
                enrolledExamListScreenProvider.inSearchMode) {
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

  Widget _examListView() => Consumer<EnrolledExamListScreenProvider>(
          builder: (context, enrolledExamListScreenProvider, child) {
        if (enrolledExamListScreenProvider.hasError) {
          return FailToLoadDataErrorWidget(
            onTap: () {
              enrolledExamListScreenProvider.getExamListData();
              enrolledExamListScreenProvider.resetPageCounter();
            },
          );
        }

        if (enrolledExamListScreenProvider.enrolledExamModelList == null &&
            enrolledExamListScreenProvider.isBusyLoading) {
          return Loader();
        } else {
          /// showing page list view
          return ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 10),
            itemCount:
                enrolledExamListScreenProvider.enrolledExamModelList.length + 1,
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
              if (enrolledExamListScreenProvider.enrolledExamModelList.length ==
                  index) {
                if (enrolledExamListScreenProvider.hasMoreData) {
                  if (!enrolledExamListScreenProvider.isFetchingMoreData) {
                    /// showing nothing when idle
                    return SizedBox();
                  } else {
                    /// showing loader when fetching data
                    return _loaderWidget(context);
                  }
                } else {
                  /// End Widget when no data
                  return enrolledExamListScreenProvider
                              .enrolledExamModelList.length ==
                          0
                      ? SizedBox()
                      : _endWidget(context);
                }
              }

              return EnrolledExamListTileWidget(
                index: index,
                enrolledExamModel:
                    enrolledExamListScreenProvider.enrolledExamModelList[index],
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
        title: Text(StringUtils.enrolledExamsText),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Provider.of<EnrolledExamListScreenProvider>(context,listen: false).resetState();
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
