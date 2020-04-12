import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String label;
  final Function onTap;
  /// width could be null
  /// default width 135 for large device and 115 for mobile device
  final double width;
  const CommonButton({@required this.label, @required this.onTap,this.width});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Material(
      borderRadius: BorderRadius.circular(40.0),
      color: Colors.transparent,
      elevation: onTap == null ? 0:5.0,
      child: Container(
        height: height*0.07,
        width: width??(115),
        decoration: BoxDecoration(
          color: onTap == null ? Colors.grey:null,
          borderRadius: BorderRadius.circular(40.0),
          gradient: onTap == null ? null :AppTheme.defaultLinearGradient
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: onTap,
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}