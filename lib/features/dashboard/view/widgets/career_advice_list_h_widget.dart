import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/career_advice/view/career_advice_list_screen.dart';
import 'package:p7app/features/dashboard/view/widgets/career_advice_list_tile_h.dart';
import 'package:p7app/features/career_advice/view_models/career_advice_view_model.dart';
import 'package:p7app/main_app/app_theme/common_style.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CareerAdviceListHWidget extends StatefulWidget {
  @override
  _CareerAdviceListHWidgetState createState() =>
      _CareerAdviceListHWidgetState();
}

class _CareerAdviceListHWidgetState extends State<CareerAdviceListHWidget> {
  @override
  void initState() {
    var vm = Provider.of<CareerAdviceViewModel>(context, listen: false);
    if (vm.careerAdviceList.length == 0) {
      Future.delayed(Duration.zero).then((value) {
        vm.getData();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<CareerAdviceViewModel>(context);
    var list = vm.careerAdviceList;
    var length = list.length < 5 ? list.length : 5;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                StringResources.careerAdviceText,
                style: CommonStyle.dashboardSectionTitleTexStyle,
              ),
            ),
            RawMaterialButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (BuildContext context) =>
                        CareerAdviceListScreen()));
              },
              child: Text(
                StringResources.viewAllText,
                key: Key('careerAdviceViewAll'),
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .apply(color: Colors.blue),
              ),
            ),
          ],
        ),
        vm.isFetchingData
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  height: 130.0,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.white,
                    child: Row(
                        children: List.generate(
                            2,
                            (index) => Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Material(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(5),
                                      child: Center(),
                                    ),
                                  ),
                                ))),
                  ),
                ),
              )
            : Container(
                height: 130,
                child: ListView.builder(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: length,
                    itemBuilder: (context, index) {
                      var advice = list[index];
                      return CareerAdviceListTileH(advice, index);
                    }),
              ),
      ],
    );
  }
}
