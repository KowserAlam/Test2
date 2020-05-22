import 'package:flutter/material.dart';

class NotificationTile extends StatefulWidget {
  @override
  _NotificationTileState createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  @override
  Widget build(BuildContext context) {
    var scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Container(
      height: 80,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(color: scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10),
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 65,
            width: 65,
            child: Image.asset('assets/images/user_default.jpg', fit: BoxFit.cover,),
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
