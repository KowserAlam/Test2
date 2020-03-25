import 'package:assessment_ishraak/features/auth/view/password_reset_screens.dart';
import 'package:assessment_ishraak/features/auth/view/sign_up_screen.dart';
import 'package:assessment_ishraak/features/home_screen/views/dashboard_screen.dart';
import 'package:assessment_ishraak/features/home_screen/views/home.dart';
import 'package:assessment_ishraak/features/auth/provider/login_view_model.dart';
import 'package:assessment_ishraak/main_app/flavour/flavor_banner.dart';
import 'package:assessment_ishraak/main_app/util/const.dart';
import 'package:assessment_ishraak/main_app/util/cosnt_style.dart';
import 'package:assessment_ishraak/main_app/util/strings_utils.dart';
import 'package:assessment_ishraak/main_app/util/validator.dart';
import 'package:assessment_ishraak/main_app/widgets/app_version_widget_small.dart';
import 'package:assessment_ishraak/main_app/widgets/gredient_buton.dart';
import 'package:assessment_ishraak/main_app/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailTextController = TextEditingController();

  final _passwordTextController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

//  checkInternet() {
//    ApiHelper apiHelper = ApiHelper();
//    apiHelper.checkInternetConnectivity().then((status) {
//      if (!status) {
//        _showFlashBar(_scaffoldKey.currentContext);
//      }
//    });
//  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildForm(context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _successfulSignUorLoginText(),
          SizedBox(height: 20),
          _loginEmail(context),
          SizedBox(height: 20),
          _loginPassword(context),
          SizedBox(height: 10),
          _forgotPasswordWidget(context),
          SizedBox(height: 10),
          Consumer<LoginViewModel>(
              builder: (BuildContext context, loginProvider, Widget child) {
                if (loginProvider.isBusyLogin) {
                  return Loader();
                }
                return _signInButton(context);
              }),
          SizedBox(height: 30),
          _registerText(),

        ],
      ),
    );
  }

  Widget _successfulSignUorLoginText() {
    return Consumer<LoginViewModel>(
        builder: (BuildContext context, loginProvider, Widget child) {
          if (loginProvider.isFromSuccessfulSignUp) {
            return Container(
              height: 60,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.green.withOpacity(0.1)),
              child: Text(
                StringUtils.signSuccessfulText,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title.apply(color: Colors.green),
              ),
            );
          }
          return SizedBox(
            child: Text(
              StringUtils.loginButtonText,
              style: Theme.of(context).textTheme.display1,
            ),
          );
        });
  }

  Widget _logoSection() {
    return Hero(
      tag: kDefaultLogo,
      child: Image.asset(
        kDefaultLogo,
        width: 180,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _loginEmail(context) {
    var loginProvider = Provider.of<LoginViewModel>(context);
    return Center(
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        focusNode: _emailFocus,
        textInputAction: TextInputAction.next,
        controller: _emailTextController,
        onFieldSubmitted: (s) {
          _emailFocus.unfocus();
          FocusScope.of(_scaffoldKey.currentState.context)
              .requestFocus(_passwordFocus);
        },
        decoration: kEmailInputDecoration,
        onSaved: (val) => loginProvider.email = val.trim(),
        validator: Validator().validateEmail,
      ),
    );
  }

  Widget _loginPassword(context) {
    return Consumer<LoginViewModel>(
      builder: (BuildContext context, loginProvider, Widget child) {
        bool isObscure = loginProvider.isObscurePassword;
        return TextFormField(
          focusNode: _passwordFocus,
          textInputAction: TextInputAction.done,
          obscureText: loginProvider.isObscurePassword,
          controller: _passwordTextController,
          onFieldSubmitted: (s) {
            _handleLogin(_scaffoldKey.currentState.context);
          },
          decoration: kPasswordInputDecoration(
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
                  loginProvider.isObscurePassword = !isObscure;
                },
              )),
          onSaved: (val) => loginProvider.password = val,
          validator: Validator().nullFieldValidate,
        );
      },
    );
  }

  Widget _signInButton(context) {
    return GradientButton(
      width: double.infinity,
      onTap: () {
        _handleLogin(context);
      },
      label: StringUtils.loginButtonText,
    );
  }

  Widget _registerText() {

    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: StringUtils.alreadyHaveAndAccountText,
          style: TextStyle(color: Colors.grey, fontSize: 15),
        ),
        WidgetSpan(
          child: InkWell(
            onTap: (){
              /// disabling login successful message
              var loginProvider = Provider.of<LoginViewModel>(context,listen: false);
              if (loginProvider.isFromSuccessfulSignUp) {
                loginProvider.isFromSuccessfulSignUp = false;
              }

              /// navigate to signup screen
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignUpScreen()));
            },
            child: Text(
              '  ${StringUtils.registerText}',
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),),
      ]),
    );
  }

  _handleLogin(BuildContext context) async {
    var loginProvider = Provider.of<LoginViewModel>(context, listen: false);

    if (loginProvider.isFromSuccessfulSignUp) {
      loginProvider.isFromSuccessfulSignUp = false;
    }

    /// validating form
    bool isValid = _formKey.currentState.validate();

    if (isValid) {
      _formKey.currentState.save();

      /// sending login request
      var res = await loginProvider.loginWithEmailAndPassword();

      if (res) {
        Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(builder: (BuildContext context) => DashBoardScreen()),
                (_) => false);
      }

    } else {
      _showSnackBar(StringUtils.checkRequiredField, Colors.red[800]);
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
//
//  _showFlashBar(BuildContext context) {
//    Flushbar(
//      onTap: (s) {
//        s.dismiss();
//      },
//      flushbarPosition: FlushbarPosition.TOP,
//      title: "Network Error",
//      message: "Please check your connectivity !",
//      backgroundColor: Colors.red,
//    ).show(context);
//  }

  Widget _forgotPasswordWidget(context) => InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => PasswordResetScreens()));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              StringUtils.forgotPassword,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ));

  Widget _tabLayout(context) {
    double topPadding = MediaQuery.of(context).size.height / 30;
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Center(
              child: Container(
                width: 400,
                padding: EdgeInsets.fromLTRB(16, topPadding, 16, 0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    _logoSection(),
                    _buildForm(context),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(16),
              child: Image.asset(kLoginBG, fit: BoxFit.contain),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mobileLayout(context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10),
          _logoSection(),
          SizedBox(height: 10),
          _buildForm(context),
          SizedBox(height: 10),
          AppVersionWidgetSmall()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        key: _scaffoldKey,
        body: Center(
          child: SingleChildScrollView(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (constraints.maxWidth < 720) {
                  return _mobileLayout(_scaffoldKey.currentState.context);
                } else {
                  return _tabLayout(_scaffoldKey.currentState.context);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
