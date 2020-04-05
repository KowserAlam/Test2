import 'package:skill_check/main_app/util/app_theme.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String label;
  final Function onTap;
  /// width could be null
  /// default width 135 for large device and 115 for mobile device
  final double width;
  const GradientButton({@required this.label, @required this.onTap,this.width});

  @override
  Widget build(BuildContext context) {
    bool isLarge = MediaQuery.of(context).size.width > 720 ;
    return Material(

      borderRadius: BorderRadius.circular(5.0),
      color: Colors.transparent,
      elevation: onTap == null ? 0:5.0,
      child: Container(
        height: 48.0,
        width: width??(isLarge? 135 : 115),
        decoration: BoxDecoration(
          color: onTap == null ? Colors.grey:null,
          borderRadius: BorderRadius.circular(5.0),
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
                  fontSize: isLarge? 18.0:16.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}