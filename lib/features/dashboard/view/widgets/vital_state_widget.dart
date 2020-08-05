import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:provider/provider.dart';

class VitalStateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<DashboardViewModel>(context);
    var vitalStatsData = vm.vitalStatsData;
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: Color(0xff121212),
        image: DecorationImage(
          image: AssetImage(
            kVitalStatsBg,
          ),
          fit: BoxFit.cover,
            colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.3),
                BlendMode.dstATop)
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              vitalStateItem(
                  label: StringResources.openJobsText,
                  count: vitalStatsData?.openJob,
                  iconData: FontAwesomeIcons.briefcase),
              vitalStateItem(
                  label: StringResources.professionalsText,
                  count: vitalStatsData?.professionalCount,
                  iconData: FontAwesomeIcons.usersCog),
            ],
          ),
          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              vitalStateItem(
                  label: StringResources.skillsText,
                  count: vitalStatsData?.resume,
                  iconData: FontAwesomeIcons.tools),
              vitalStateItem(
                  label: StringResources.companiesText,
                  count: vitalStatsData?.companyCount,
                  iconData: FontAwesomeIcons.solidBuilding),
            ],
          ),
        ],
      ),
    );
  }

  Widget vitalStateItem({
    @required String label,
    @required IconData iconData,
    @required String count,
  }) {
    return Expanded(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var primaryColor = Theme.of(context).primaryColor;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Icon(
                  iconData ?? FontAwesomeIcons.dotCircle,
                  color: primaryColor,
                  size: 30,
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  count ?? "0",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  label ?? "",
                  style: TextStyle(color: primaryColor),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
