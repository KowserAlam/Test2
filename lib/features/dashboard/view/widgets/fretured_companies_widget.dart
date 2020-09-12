import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/company/models/company.dart';
import 'package:p7app/features/dashboard/models/top_categories_model.dart';
import 'package:p7app/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:p7app/main_app/app_theme/common_style.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:provider/provider.dart';

class FeaturedCompaniesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<DashboardViewModel>(context);
    var list = vm.featuredCompanies;
    if (vm.topCategoryList.length == 0) return SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 8,
              ),
              Text(
                StringResources.featuredCompanies,
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
                var company = list[index];
                return listItem(company);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget listItem(Company company) {
    return LayoutBuilder(builder: (context, c) {
      return SizedBox(
        width: 140,
        child: Padding(
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
                        child: CachedNetworkImage(
                          imageUrl: company.profilePicture??"",
                          placeholder: (c,i)=>Image.asset(kCompanyImagePlaceholder),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        flex: 5,
                        child: Center(
                          child: Text(
                            company.name,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
