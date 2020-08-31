import 'package:flutter/material.dart';
import 'package:p7app/features/job/view/all_job_list_screen.dart';
import 'package:p7app/features/job/view/applied_job_list_screen.dart';
import 'package:p7app/features/job/view/favourite_job_list_screen.dart';
import 'package:p7app/features/job/view_model/job_screen_view_model.dart';
import 'package:provider/provider.dart';

class JobsScreen extends StatefulWidget {
  JobsScreen({Key key}) : super(key: key);

  @override
  _JobsScreenState createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {

  List<Widget> children = [
    AllJobListScreen(),
    AppliedJobListScreen(),
    FavouriteJobListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<JobScreenViewModel>(context);
    return Scaffold(
      body: children[vm.currentIndex??0],
    );
  }
}