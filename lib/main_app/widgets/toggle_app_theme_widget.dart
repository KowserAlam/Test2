import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/config/config_provider.dart';
import 'package:provider/provider.dart';

class ToggleAppThemeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return       Consumer<ConfigProvider>(
        builder: (context, configProvider, child) {
          return IconButton(
            icon: configProvider.isDarkModeOn
                ? Icon(
              FontAwesomeIcons.lightbulb,
              size: 20,
            )
                : Icon(
              FontAwesomeIcons.solidLightbulb,
              size: 20,
            ),
            onPressed: configProvider.toggleThemeChangeEvent,
          );
        });
  }
}
