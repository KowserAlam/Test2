import 'package:after_layout/after_layout.dart';
import 'package:p7app/features/auth/provider/login_view_model.dart';
import 'package:p7app/features/auth/view/login_screen.dart';
import 'package:p7app/features/home_screen/providers/dashboard_screen_provider.dart';
import 'package:p7app/features/home_screen/view_model/home_view_model.dart';
import 'package:p7app/features/job/models/job.dart';
import 'package:p7app/main.dart';
import 'package:p7app/main_app/flavour/flavor_banner.dart';
import 'package:p7app/main_app/util/strings_utils.dart';
import 'package:p7app/main_app/view/drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AfterLayoutMixin{
  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<HomeViewModel>(context,listen: false).getJobList();
  }

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        endDrawer: Drawer(
          child: ListView(
            children: <Widget>[
              /// ************ sign out
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: DrawerListWidget(
                  color: Colors.redAccent,
                  label: StringUtils.signOutText,
                  icon: FontAwesomeIcons.signOutAlt,
                  isSelected: false,
                  onTap: () {
                    Provider.of<LoginViewModel>(context,listen: false).signOut();
                    Provider.of<DashboardScreenProvider>(context).resetState();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                            (_) => false);
                  },
                ),
              ),
            ],
          ),
        ),
        body: Consumer<HomeViewModel>(builder: (BuildContext context, homeViewModel, Widget child) {
          var jobList = homeViewModel.jobList;
          print(jobList.length);
          return ListView.builder(
            itemCount: jobList.length,
              itemBuilder: (context,index){
            JobModel job = jobList[index];
            return Text(job.title);
          });
        },),
      ),
    );
  }


}
