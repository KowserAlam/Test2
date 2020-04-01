import 'package:p7app/features/auth/provider/login_view_model.dart';
import 'package:p7app/features/auth/view/login_screen.dart';
import 'package:p7app/features/home_screen/providers/dashboard_screen_provider.dart';
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

class _HomeScreenState extends State<HomeScreen> {


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
        body: Center(
          child: Text("Home"),
        ),
      ),
    );
  }
}
