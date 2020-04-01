import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String labelText ;


  TitleWidget({@required this.labelText});

  @override
  Widget build(BuildContext context) {

  return Container(
      height: 50,
//      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: <Widget>[
          Container(
            height: 50,
            width: 50,
            child: Icon(
              Icons.edit,
              color: Colors.black54,
            ),
          ),
          Container(
              height: 50,
              padding: EdgeInsets.only(top: 15),
              child: Text(
                labelText,
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              )),
        ],
      ),
    );

  }
}
