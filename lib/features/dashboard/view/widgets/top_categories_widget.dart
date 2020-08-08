import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/dashboard/models/top_categories_model.dart';
import 'package:p7app/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:provider/provider.dart';

class TopCategoriesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<DashboardViewModel>(context);
    var list = vm.topCategoryList;
    if(vm.topCategoryList.length ==0)
      return SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
      child: Column(
        children: [
          Text(StringResources.topCategories,style: Theme.of(context).textTheme.subtitle1,),
          SizedBox(height: 10,),
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
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
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
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: SizedBox(height: 40,width: 40,
                child: Stack(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xff6EE9F3)),
                    ),
                    Center(
                      child: Container(
                        height: 32,
                        width: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xff0062DE)),
                        child: Text("${category.numPosts??""}",style: TextStyle(color: Colors.white),),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
