import 'package:assessment_ishraak/features/auth/view/widgets/password_reset_enter_email_widget.dart';
import 'package:assessment_ishraak/features/auth/view/widgets/password_reset_enter_new_password.dart';
import 'package:assessment_ishraak/features/auth/view/widgets/password_reset_verify_code_widget.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class PasswordResetScreens extends StatefulWidget {
  @override
  _PasswordResetScreensState createState() => _PasswordResetScreensState();
}

class _PasswordResetScreensState extends State<PasswordResetScreens> {


  PageController _pageController = PageController();
  var _valueNotifier = ValueNotifier<int>(0);
  int index = 0;
  int length = 3;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              onPageChanged: (i) {
                _valueNotifier.value = i;
                index = i;
              },
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: <Widget>[
                PasswordResetEmailWidget(
                  onSuccessCallBack: (){
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut);
                  },
                ),
                PasswordResetVerifyCodeWidget(onSuccessCallBack: (){
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut);
                },),
                PasswordRestEnterNewPassword(),


              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CirclePageIndicator(
              dotColor: Theme.of(context).primaryColor.withOpacity(0.25),
              selectedDotColor: Theme.of(context).primaryColor,
              selectedSize: 10,
              itemCount: length,
              currentPageNotifier: _valueNotifier,
            ),
          )
        ],
      ),
    );
  }
}
