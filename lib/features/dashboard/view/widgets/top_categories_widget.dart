import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/dashboard/models/top_categories_model.dart';
import 'package:p7app/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:p7app/main_app/app_theme/common_style.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class TopCategoriesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<DashboardViewModel>(context);
    var list = vm.topCategoryList;
      return vm.shouldShowTopCategoriesLoader? Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 8,
                ),
                Text(
                  StringResources.topCategories,
                  style: CommonStyle.dashboardSectionTitleTexStyle,
                ),
              ],
            ),
            // Text(StringResources.topCategories,style: Theme.of(context).textTheme.subtitle1,),
            SizedBox(
              height: 10,
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              enabled: true,
              child: Container(
                height: 150,
                child: ListView.builder(
                  itemCount: 6,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var category = TopCategoriesModel();
                    return listItem(category);
                  },
                ),
              ),
            ),
          ],
        ),
      ): Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 8,
                ),
                Text(
                  StringResources.topCategories,
                  style: CommonStyle.dashboardSectionTitleTexStyle,
                ),
              ],
            ),
            // Text(StringResources.topCategories,style: Theme.of(context).textTheme.subtitle1,),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 150,
              child: ListView.builder(
                itemCount: list.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var category = list[index];
                  return listItem(category);
                },
              ),
            ),
          ],
        ),
      );
  }

  Widget listItem(TopCategoriesModel category) {
    return LayoutBuilder(builder: (context, c) {
      return SizedBox(
        width: 140,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10, right: 5),
              child: Material(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: double.infinity,
                          ),
                          Expanded(
                            flex: 4,
                            child: CircleAvatar(
                              child: Icon(
                                FontAwesomeIcons.tools,
                                color: Colors.grey,
                                size: 30,
                              ),
                              radius: 30,
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            flex: 5,
                            child: Center(
                              child: Text(
                                category.name,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 0,
                        right: 10,
                        child: Center(
                          child: Container(
                            height: 32,
                            width: 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xff0062DE)),
                            child: Text(
                              "${category.numPosts ?? ""}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
