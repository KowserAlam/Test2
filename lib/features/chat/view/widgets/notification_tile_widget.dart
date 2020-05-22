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
            margin: EdgeInsets.only(right: 3),
            child: Image.asset('assets/images/user_default.jpg', fit: BoxFit.cover,),
          ),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          height: 15,
                          child: Text('Source',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12), overflow: TextOverflow.ellipsis,),
                        ),
                      ),
                      Container(
                        height: 15,
                        width: 60,
                        child: Center(child: Text('05/02/20', style: TextStyle(fontSize: 10),)),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 5,top: 2),
                    child: Text('Flutter is an open-source UI software development kit created by Google. It is used to develop applications for Android, iOS, Windows, Mac, Linux, Google Fuchsia and the web',overflow: TextOverflow.ellipsis,maxLines: 3,),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
