import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/career_advice/models/career_advice_model.dart';
import 'package:p7app/features/career_advice/view/career_advice_details_screen.dart';
import 'package:p7app/features/career_advice/view/career_advice_list_screen.dart';
import 'package:p7app/features/career_advice/view_models/career_advice_view_model.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:provider/provider.dart';

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
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            RawMaterialButton(
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (BuildContext context) =>
                        CareerAdviceListScreen(
                        )));
              },
              child: Text(
                StringResources.viewAllText,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .apply(color: Colors.blue),
              ),
            ),
          ],
        ),
        Container(
          height: 120,
          child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              itemCount: length,
              itemBuilder: (context, index) {
                var advice = list[index];
                return CareerAdviceListTileH(advice);
              }),
        ),
      ],
    );
  }
}

class CareerAdviceListTileH extends StatelessWidget {
  final CareerAdviceModel adviceModel;

  CareerAdviceListTileH(this.adviceModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Container(
          width: 180,
          child: Stack(
            children: [
              CachedNetworkImage(
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                imageUrl: adviceModel.featuredImage ?? "",
                placeholder: (c, i) => Image.asset(
                  kCareerAdvicePlaceholder,
                  colorBlendMode: BlendMode.color,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Image.asset(
                kCareerAdvicePlaceholder,
                colorBlendMode: BlendMode.color,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black87,
                    ])),
              ),
              Column(
                children: [
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      adviceModel.title ?? "",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (BuildContext context) =>
                              CareerAdviceDetailsScreen(
                                careerAdviceModel: adviceModel,
                              )));
                    },
                    child: Center(),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
