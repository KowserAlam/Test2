
import 'package:p7app/features/auth/provider/login_view_model.dart';
import 'package:p7app/features/auth/provider/password_change_view_model.dart';
import 'package:p7app/features/auth/provider/password_reset_provider.dart';
import 'package:p7app/features/auth/provider/signup_viewmodel.dart';
import 'package:p7app/features/company/view_model/company_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/job/view_model/applied_job_list_view_model.dart';
import 'package:p7app/features/job/view_model/favourite_job_list_view_model.dart';
import 'package:p7app/features/job/view_model/job_list_filter_widget_view_model.dart';
import 'package:p7app/features/job/view_model/job_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:p7app/main_app/root.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:bot_toast/bot_toast.dart';



class P7App extends StatelessWidget {
  final isEnabledDevicePreview;

  P7App({this.isEnabledDevicePreview = false});

  @override
  Widget build(BuildContext context) {
    


    var providers = [
      ChangeNotifierProvider(create: (context) => LoginViewModel()),
      ChangeNotifierProvider(create: (context) => SignUpViewModel()),
      ChangeNotifierProvider(create: (context) => JobListViewModel()),
      ChangeNotifierProvider(create: (context) => AppliedJobListViewModel()),
      ChangeNotifierProvider(create: (context) => FavouriteJobListViewModel()),
      ChangeNotifierProvider(create: (context) => CompanyListViewModel()),
      ChangeNotifierProvider(create: (context) => PasswordResetViewModel()),
      ChangeNotifierProvider(create: (context) => UserProfileViewModel()),
      ChangeNotifierProvider(create: (context) => SignUpViewModel()),
      ChangeNotifierProvider(create: (context) => JobListFilterWidgetViewModel()),
      ChangeNotifierProvider(create: (context) => PasswordChangeViewModel()),
    ];

    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        navigatorObservers: [BotToastNavigatorObserver()],
        builder: BotToastInit(),
        debugShowCheckedModeBanner: false,
        title: StringUtils.appName,
        theme: AppTheme.lightTheme,
//      darkTheme: AppTheme.darkTheme,
        home: Root(),
      ),
    );
  }
}
