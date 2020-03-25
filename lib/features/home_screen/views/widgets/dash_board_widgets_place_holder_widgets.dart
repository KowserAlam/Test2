import 'package:flutter/material.dart';

class DashBoardWidgetsPlaceHolderWidgets extends StatelessWidget {
  final Widget child;

  DashBoardWidgetsPlaceHolderWidgets({@required this.child})
      : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 75,
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: Center(child: child),
    );
  }
}
