import 'package:after_layout/after_layout.dart';
import 'package:assessment_ishraak/features/featured_exam_screen/models/featured_exam_model.dart';
import 'package:assessment_ishraak/features/home_screen/providers/featured_exam_search_provider.dart';
import 'package:assessment_ishraak/features/recent_exam/widgets/search_bar_widget.dart';
import 'package:assessment_ishraak/main_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../featured_exam_screen/views/featured_exam_list_tile.dart';

class FeaturedExamSearchScreen extends StatefulWidget {
  @override
  _FeaturedExamSearchScreenState createState() =>
      _FeaturedExamSearchScreenState();
}

class _FeaturedExamSearchScreenState extends State<FeaturedExamSearchScreen>
    with AfterLayoutMixin {
  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<FeaturedExamSearchProvider>(context).listenStream();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<FeaturedExamSearchProvider>(context).resetState();
        return true;
      },
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Consumer<FeaturedExamSearchProvider>(
                builder: (context, featuredExamSearchProvider, c) {
              return SearchBarWidget(
                onBackPressed: () {
                  featuredExamSearchProvider.resetState();
                  Navigator.pop(context);
                },
                onClear: () {
                  featuredExamSearchProvider.changeQuery("");
                  featuredExamSearchProvider.featuredExamList =
                      <FeaturedExamModel>[];
                },
                onChanged: (data) {
                  featuredExamSearchProvider.changeQuery(data);
                },
              );
            }),
            Consumer<FeaturedExamSearchProvider>(
                builder: (context, featuredExamSearchProvider, c) {
                  if(featuredExamSearchProvider.isSearching){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Loader(),
                    );
                  }else{
                    return SizedBox();
                  }

            }),
            Consumer<FeaturedExamSearchProvider>(
              builder: (context, featuredExamSearchProvider, c) {
                if (featuredExamSearchProvider.featuredExamList != null) {
                  if (featuredExamSearchProvider.featuredExamList.length == 0 && !featuredExamSearchProvider.isSearching) {
                    return StreamBuilder(
                      stream: featuredExamSearchProvider.searchQuery,
                      builder: (context, snapshot) {
                        return Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 5),
                          child: Text(
                            "Your search - ${snapshot.data ?? ""} - did not match any exams",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey.withOpacity(0.5),
                                fontSize: 28),
                          ),
                        );
                      },
                    );
                  }

                  return ListView.separated(
                    padding: EdgeInsets.all(8),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:
                        featuredExamSearchProvider.featuredExamList.length,
                    itemBuilder: (context, index) {
                      return FeaturedExamListTile(
                        featuredExamModel:
                            featuredExamSearchProvider.featuredExamList[index],
                        index: index,
                      );
                    },
                    separatorBuilder: (context, i) {
                      return Divider(
                        height: 2,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      );
                    },
                  );
                }

                return SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
