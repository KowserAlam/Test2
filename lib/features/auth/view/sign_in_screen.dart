import 'package:p7app/features/auth/view/password_reset_screens.dart';
import 'package:p7app/features/auth/view/sign_up_screen.dart';
import 'package:p7app/features/auth/view/widgets/custom_text_field_rounded.dart';
import 'package:p7app/features/auth/view_models/sign_in_view_model.dart';
import 'package:p7app/main_app/flavour/flavor_banner.dart';
import 'package:p7app/main_app/root.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/app_version_widget_small.dart';
import 'package:p7app/main_app/views/widgets/common_button.dart';
import 'package:p7app/main_app/views/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/main_app/views/widgets/rounded_loading_button.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  final _emailTextController = TextEditingController();

  final _passwordTextController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
  }

  Widget _successfulSignUorLoginText() {
    return Consumer<SignInViewModel>(
        builder: (BuildContext context, loginProvider, Widget child) {
      if (loginProvider.isFromSuccessfulSignUp) {
        return Container(
          height: 60,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.green.withOpacity(0.1)),
          child: Text(
            StringResources.signSuccessfulText,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .apply(color: Colors.green),
          ),
        );
      }
      return SizedBox();
    });
  }

  _handleLogin(BuildContext context) async {
    var loginProvider = Provider.of<SignInViewModel>(context, listen: false);
    if (loginProvider.isFromSuccessfulSignUp) {
      loginProvider.isFromSuccessfulSignUp = false;
    }

    /// validating form

    bool isValid = loginProvider.validate();
    if (isValid) {
      /// sending login request
      var res = await loginProvider.loginWithEmailAndPassword();

      if (res) {
        loginProvider.resetState();
        _btnController.success();
        Future.delayed(Duration(milliseconds: 800)).then((_) {
          Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(
                  builder: (BuildContext context) => Root(
                        showDummyLoadingTime: true,
                      )),
              (_) => false);
//          _btnController.reset();
        });
      } else {
        _btnController.reset();
      }
    } else {
      _btnController.reset();
      _showSnackBar(StringResources.checkRequiredField, Colors.red[800]);
    }
  }

  _showSnackBar(String text, Color color) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      duration: Duration(milliseconds: 600),
      content: Text(
        text,
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      backgroundColor: color,
    ));
  }

  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).size.height / 30;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    double logoWidth = width > kMidDeviceScreenSize ? 160 : height * 0.085;

    var errorMessage =
        Consumer<SignInViewModel>(builder: (context, signViewModel, _) {
      if (signViewModel.errorMessage == null) {
        return SizedBox();
      }
      return Container(
        color: Colors.red.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            signViewModel.errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    });
    var welcomeBackText = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          StringResources.welcomeBack,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          StringResources.loginToYourExistingAccount,
          style: TextStyle(fontSize: 15, color: Colors.grey[400]),
        )
      ],
    );
    var logo = Hero(
      tag: kDefaultLogoSq,
      child: Image.asset(
        kDefaultLogoSq,
        width: logoWidth,
        fit: BoxFit.contain,
      ),
    );

    var registerText = RichText(
      text: TextSpan(children: [
        TextSpan(
          text: StringResources.doNotHaveAccountText,
          style: TextStyle(color: Colors.grey, fontSize: 15),
        ),
        WidgetSpan(
          child: InkWell(
            onTap: () {
              /// disabling login successful message
              var loginProvider =
                  Provider.of<SignInViewModel>(context, listen: false);
              if (loginProvider.isFromSuccessfulSignUp) {
                loginProvider.isFromSuccessfulSignUp = false;
              }

              loginProvider.clearMessage();

              /// navigate to signup screen
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()));
            },
            child: Text(
              '  ${StringResources.signupText}',
              key: Key('signUpText'),
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
        ),
      ]),
    );
    var email = Consumer<SignInViewModel>(
      builder: (context, signViewModel, _) {
        return CustomTextFieldRounded(
          textFieldKey: Key('signInEmail'),
          errorText: signViewModel.errorTextEmail,
          keyboardType: TextInputType.emailAddress,
          focusNode: _emailFocus,
          textInputAction: TextInputAction.next,
          controller: _emailTextController,
          hintText: StringResources.emailText,
          prefixIcon: Icon(
            Icons.person_outline,
          ),
          onChanged: signViewModel.validateEmailLocal,
          onSubmitted: (s) {
            _emailFocus.unfocus();
            FocusScope.of(_scaffoldKey.currentState.context)
                .requestFocus(_passwordFocus);
          },
        );
      },
    );
    var password = Consumer<SignInViewModel>(
      builder: (context, signViewModel, _) {
        bool isObscure = signViewModel.isObscurePassword;
        return CustomTextFieldRounded(
          textFieldKey: Key("signInPassword"),
          onChanged: signViewModel.validatePasswordLocal,
          errorText: signViewModel.errorTextPassword,
          focusNode: _passwordFocus,
          textInputAction: TextInputAction.done,
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: !isObscure
                ? Icon(
                    Icons.visibility,
                  )
                : Icon(
                    Icons.visibility_off,
                    color: Theme.of(context).textTheme.body1.color,
                  ),
            onPressed: () {
              signViewModel.isObscurePassword = !isObscure;
            },
          ),
          obscureText: signViewModel.isObscurePassword,
          controller: _passwordTextController,
          hintText: StringResources.passwordText,
          onSubmitted: (s) {
            _handleLogin(_scaffoldKey.currentState.context);
          },
        );
      },
    );
    var forgotPasswordWidget = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PasswordResetScreens()));
          },
          child: Container(
            padding: EdgeInsets.all(8),
            child: Text(
              StringResources.forgotPassword,
            ),
          ),
        ),
      ],
    );
    var signInButton2 = Consumer<SignInViewModel>(
        builder: (BuildContext context, loginProvider, Widget child) {
      if (loginProvider.isBusyLogin) {
        return Loader();
      }
      return Container(
        height: 50,
        width: 200,
        child: CommonButton(
          key: Key('signInButton'),
          onTap: () {
            _handleLogin(context);
          },
          label: StringResources.signInText,
        ),
      );
    });
    var signInButton = Center(
      child: RoundedLoadingButton(
        key: Key('signInButton'),
        valueColor: Colors.black,
        height: 55,
        width: 200,
        child: Text(
          StringResources.logInButtonText,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        controller: _btnController,
        onPressed: () {
          _handleLogin(context);
        },
      ),
    );
    var socialLogin = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Or connect using',
          style: TextStyle(color: Colors.grey[400], fontSize: 15),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 40,
              width: 120,
              padding: EdgeInsets.symmetric(vertical: 13),
              decoration: BoxDecoration(
                  color: Color.fromARGB(0xFF, 59, 89, 152),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomLeft: Radius.circular(40))),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            bottomLeft: Radius.circular(40)),
                        child: Image.asset(
                          'assets/images/fbIcon.png',
                          fit: BoxFit.cover,
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Facebook',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 40,
              width: 120,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Color.fromARGB(0xFF, 243, 80, 29),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            bottomLeft: Radius.circular(40)),
                        child: Image.asset(
                          'assets/images/gmail_red_icon.png',
                          fit: BoxFit.cover,
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Google +',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
    var loginForm = Container(
      child: Column(
        children: <Widget>[
          _successfulSignUorLoginText(),
          errorMessage,
          SizedBox(height: 15),
          email,
          SizedBox(height: 10),
          password,
          SizedBox(height: 5),
          forgotPasswordWidget,
          SizedBox(height: 5),
          signInButton,
//          SizedBox(height: 20),
//          socialLogin,
          SizedBox(height: 20),
          registerText,
        ],
      ),
    );

    return FlavorBanner(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        key: _scaffoldKey,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 15, 16, 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(height: 0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        logo,
                        SizedBox(height: 10),
                        welcomeBackText,
                        SizedBox(height: 10),
                        loginForm,
                        SizedBox(height: 30),
                        AppVersionWidgetLowerCase()
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
