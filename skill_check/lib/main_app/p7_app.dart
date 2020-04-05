import 'package:skill_check/features/assessment/providers/submit_provider.dart';
import 'package:skill_check/features/auth/provider/login_view_model.dart';
import 'package:skill_check/features/auth/provider/password_reset_provider.dart';
import 'package:skill_check/features/auth/provider/signup_viewmodel.dart';
import 'package:skill_check/features/config/config_provider.dart';
import 'package:skill_check/features/home_screen/providers/result_provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_check/features/enrolled_exam_list_screen/providers/enrolled_exam_list_screen_provider.dart';
import 'package:skill_check/features/featured_exam_screen/providers/featured_exam_list_screen_provider.dart';
import 'package:skill_check/features/home_screen/providers/featured_exam_search_provider.dart';
import 'package:skill_check/main_app/root.dart';
import 'package:skill_check/features/recent_exam/providers/recent_exam_list_provider.dart';
import 'package:skill_check/features/user_profile/providers/edit_profile_provider.dart';
import 'package:skill_check/features/user_profile/providers/experiance_provider.dart';
import 'package:skill_check/features/user_profile/providers/education_provider.dart';
import 'package:skill_check/features/user_profile/providers/technical_skill_provider.dart';
import 'package:skill_check/features/user_profile/providers/user_provider.dart';
import 'package:skill_check/main_app/util/app_theme.dart';
import 'package:skill_check/main_app/util/strings_utils.dart';
import 'package:skill_check/features/assessment/providers/exam_provider.dart';
import 'package:skill_check/features/home_screen/providers/dashboard_screen_provider.dart';
import 'package:bot_toast/bot_toast.dart';



class P7App extends StatelessWidget {
  final isEnabledDevicePreview;

  P7App({this.isEnabledDevicePreview = false});

  @override
  Widget build(BuildContext context) {


    var providers = [
      ChangeNotifierProvider(create: (context) => LoginViewModel()),
      ChangeNotifierProvider(create: (context) => SignUpViewModel()),
      ChangeNotifierProvider(create: (context) => ResultProvider()),
      ChangeNotifierProvider(create: (context) => FeaturedExamSearchProvider()),
      ChangeNotifierProvider(create: (context) => PasswordResetProvider()),
      ChangeNotifierProvider(
          create: (context) => EnrolledExamListScreenProvider()),
      ChangeNotifierProvider(
          create: (context) => FeaturedExamListScreenProvider()),
      ChangeNotifierProvider(
          create: (context) => RecentExamListScreenProvider()),
      ChangeNotifierProvider(create: (context) => SubmitProvider()),
      ChangeNotifierProvider(create: (context) => ExamProvider()),
      ChangeNotifierProvider(create: (context) => DashboardScreenProvider()),
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => SignUpViewModel()),
      ChangeNotifierProvider(create: (context) => ExperienceProvider()),
      ChangeNotifierProvider(create: (context) => EducationProvider()),
      ChangeNotifierProvider(create: (context) => TechnicalSkillProvider()),
      ChangeNotifierProvider(create: (context) => EditProfileProvider())
    ];

    return MultiProvider(
      providers: providers,
      child: BotToastInit(
        child: MaterialApp(
          navigatorObservers: [BotToastNavigatorObserver()],

          /// From Here
          ///
          /// <--- For device preview should be disable before generate apk
          locale:
              isEnabledDevicePreview ? DevicePreview.of(context).locale : null,

          /// <--- For device preview should be disable before generate apk
          builder: isEnabledDevicePreview ? DevicePreview.appBuilder : null,

          /// To Here

          debugShowCheckedModeBanner: false,
          title: StringUtils.appName,
          theme: Provider.of<ConfigProvider>(context).isDarkModeOn
              ? AppTheme.darkTheme
              : AppTheme.lightTheme,
//      darkTheme: AppTheme.darkTheme,
          home: Root(),
        ),
      ),
    );
  }
}