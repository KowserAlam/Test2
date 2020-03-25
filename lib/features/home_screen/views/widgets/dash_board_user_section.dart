import 'package:p7app/features/home_screen/providers/dashboard_screen_provider.dart';
import 'package:p7app/main_app/util/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoardUserSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isLarge =
        MediaQuery.of(context).size.width > kMidDeviceScreenSize;
    if (Provider.of<DashboardScreenProvider>(context).dashBoardData != null) {
      return Material(
        color: Theme.of(context).backgroundColor,
        child: isLarge
            ? Row(
                children: <Widget>[
                  _buildImage(),
                  Spacer(),
                  _buildId(),
                  _buildName(),
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    _buildImage(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildName(),
                        _buildId(),

                      ],
                    ),
                  ],
                ),
              ),
      );
    } else {
      return SizedBox();
    }
  }

  Widget _buildId() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<DashboardScreenProvider>(
          builder: (context, dashboardScreenProvider, child) {
        return Text(
          "ID: ${dashboardScreenProvider.dashBoardData.user.id ?? ""}",
          style: Theme.of(context).textTheme.title,
        );
      }),
    );
  }

  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<DashboardScreenProvider>(
          builder: (context, dashboardScreenProvider, child) {
        return Text(
          "Name: ${dashboardScreenProvider.dashBoardData.user.name ?? ""}",
          style: Theme.of(context).textTheme.title,
        );
      }),
    );
  }

  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        width: 80,

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          boxShadow: [

            BoxShadow(color: Colors.grey.withOpacity(0.5),blurRadius: 5),
            BoxShadow(color: Colors.grey.withOpacity(0.5),blurRadius: 5),

          ]
        ),
        child: ClipRRect(
          child: Consumer<DashboardScreenProvider>(
              builder: (context, dashboardScreenProvider, child) {
            return FadeInImage(
              placeholder: AssetImage(kDefaultUserImageAsset),
              image: NetworkImage(
                dashboardScreenProvider.dashBoardData.user.profilePicUrl ?? "",
              ),
              fit: BoxFit.cover,
            );
          }),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
