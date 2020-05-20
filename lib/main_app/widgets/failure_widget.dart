import 'package:flutter/material.dart';

class FailureWidget extends StatelessWidget {
  final String errorMessage;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child:
          InkWell(onTap: onTap, child: Center(child: Text(errorMessage ?? ""))),
    );
  }

  const FailureWidget({
    @required this.errorMessage,
    this.onTap,
  });
}
