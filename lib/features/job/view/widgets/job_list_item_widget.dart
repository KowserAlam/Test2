import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/job/models/job.dart';
import 'package:p7app/main_app/util/app_theme.dart';
class JobListItemWidget extends StatefulWidget {
  final JobModel jobModel;
  final Function onTap;


  JobListItemWidget(this.jobModel,{this.onTap});

  @override
  _JobListItemWidgetState createState() => _JobListItemWidgetState();
}

class _JobListItemWidgetState extends State<JobListItemWidget> {
  bool heart;

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).backgroundColor;
    var scaffoldBackgroundColor = Theme.of(context).backgroundColor;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return  Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          //That pointless fruit logo
          Container(
            height: 100,
            width: 100,
            margin: EdgeInsets.only(bottom: 25),
            color: backgroundColor,
            child: Center(child: FaIcon(FontAwesomeIcons.atom, size: 50,color: Colors.purpleAccent,),),
          ),

          //Job Title
          Text(widget.jobModel.title, style: TextStyle(fontSize: 25),),
          Container(
            margin: EdgeInsets.only(top: 25),
            child: Row(
              children: <Widget>[

                //Company Name & Icon
                Container(
                  margin: EdgeInsets.only(right: 40),
                  child: Row(
                    children: <Widget>[
                      FaIcon(FontAwesomeIcons.briefcase, color: Colors.grey,size: 18,),
                      Container(margin: EdgeInsets.only(left: 5),child: Text(widget.jobModel.companyName, style: TextStyle(color: Colors.grey),))
                    ],
                  ),
                ),
                //Location Name & Icon
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.location_on, color: Colors.grey,),
                      Text(widget.jobModel.jobLocation, style: TextStyle(color: Colors.grey),)
                    ],
                  ),
                ),
              ],
            ),
          ),

          //Job time
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Icon(Icons.access_time, color: Colors.red,),
                Text('Full Time', style: TextStyle(color: Colors.grey),)
              ],
            ),
          ),

          //Apply Button
          Container(
            margin: EdgeInsets.only(top: 30, bottom: 20),
            child: Row(
              children: <Widget>[
                Container(
                  height: 50,
                  width: 100,
                  margin: EdgeInsets.only(right: 30),
                  decoration: BoxDecoration(
                    gradient: AppTheme.defaultLinearGradient,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      'Apply', style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){

                    if(heart == false){
                      heart = true;
                    }else{heart = false;}
                    setState(() {

                    });
                  },
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[100],),
                    child: Center(child: FaIcon(FontAwesomeIcons.heart,
                        color: heart == true? Colors.redAccent: Colors.grey)),
                  ),
                ),
              ],
            ),
          ),
          Text('Deadline: 2020-03-18', style: TextStyle(color: Colors.grey),),
        ],
      ),
    );
  }
}
