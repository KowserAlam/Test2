import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/resource/decorations.dart';


class ChatListTile extends StatefulWidget {
  @override
  _ChatListTileState createState() => _ChatListTileState();
}

class _ChatListTileState extends State<ChatListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: nMbox,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 65,
            width: 65,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppTheme.mC,
                gradient: LinearGradient(
                    colors: [AppTheme.shadowColor, AppTheme.lightShadowColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight
                ),
                boxShadow: [
                  BoxShadow(
                      color: AppTheme.mCD,
                      offset: Offset(10,10),
                      blurRadius: 10
                  ),
                  BoxShadow(
                      color: AppTheme.mCL,
                      offset: Offset(-10,-10),
                      blurRadius: 10
                  )
                ]
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('assets/images/user_default.jpg'),
            ),
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Company Name', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,),overflow: TextOverflow.ellipsis,),
                        Text('Some chat message', style: TextStyle(fontSize: 13),overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: 60,
            padding: EdgeInsets.only(bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('17/08/20', style: TextStyle(fontSize: 12),),
              ],
            ),
          )

        ],
      ),
    );
  }
}
