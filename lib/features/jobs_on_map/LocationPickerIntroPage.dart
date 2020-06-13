import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/jobs_on_map/jobs_on_map_screen.dart';
import 'package:p7app/main_app/widgets/common_button.dart';

class LocationPickerIntroPage extends StatefulWidget {
  @override
  _LocationPickerIntroPageState createState() => _LocationPickerIntroPageState();
}

class _LocationPickerIntroPageState extends State<LocationPickerIntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('Welcome to jobs on map!', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            SizedBox(height:15,),
            Text('Want to find jobs closer to you? Here you will be able to search jobs within your desired distance from your location. In order to use you need to input your location. You can change it anytime from your \'My Profile\' screen.', style: TextStyle(fontSize: 15),textAlign: TextAlign.center,),
            SizedBox(height: 30,),
            CommonButton(
              label: 'Continue',
              onTap: (){
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            JobsOnMap()));
              },
            )
          ],
        ),
      ),
    );
  }
}
