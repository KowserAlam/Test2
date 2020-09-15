import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/company/models/company.dart';
import 'package:p7app/features/company/view/company_details.dart';
import 'package:p7app/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:p7app/features/job/view/job_details_screen.dart';
import 'package:p7app/main_app/app_theme/common_style.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:provider/provider.dart';
import 'package:p7app/method_extension.dart';
import 'package:shimmer/shimmer.dart';

class FeaturedCompaniesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<DashboardViewModel>(context);
    var list = vm.featuredCompanies;
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
            vm.shouldShowFeaturedCompanyLoader?
            Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              enabled: true,
              child: Container(
                height: 180,
                child: Row(children: [
                  Expanded(child: Material(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.grey,child: Center(),
                  )),
                  SizedBox(width: 8,),
                  Expanded(child: Material(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.grey,child: Center(),
                  )),
                ],),
              ),
            ):
            Container(
              height: 180,
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
        width: 180,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 5),
          child: Card(
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(CupertinoPageRoute(builder:(context)=> CompanyDetails(company: company,)));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                    ),
                    SizedBox(
                      height: 50,
                      child: CachedNetworkImage(
                        imageUrl: company.profilePicture ?? "",
                        placeholder: (c, i) =>
                            Image.asset(kCompanyImagePlaceholder),
                      ),
                    ),
                    SizedBox(height: 5),
                    Spacer(),
                    Text(
                      company.name??"",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                    Spacer(),
                    SizedBox(height: 2),
                    Container(
                      height: 13,
                      child: Center(
                        child: company.city !=null?Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: Colors.grey,
                            ),
                            Flexible(
                              child: Text(
                                company.city.swapValueByComa,
                                maxLines: 1,
                                style: TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ),
                          ],
                        ):SizedBox(),
                      ),
                    ),
                    SizedBox(height: 5),
                    Material(
                      elevation: 2  ,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      color: Theme.of(context).primaryColor,
                      child: SizedBox(
                        width: 200,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${company.numberOfPost??"0"} Job(s)"),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
