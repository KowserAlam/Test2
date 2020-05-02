import 'package:p7app/features/auth/view/password_reset_screens.dart';
import 'package:p7app/features/auth/view/sign_up_screen.dart';
import 'package:p7app/features/auth/provider/login_view_model.dart';
import 'package:p7app/main_app/flavour/flavor_banner.dart';
import 'package:p7app/main_app/root.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/app_theme/comon_styles.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/widgets/app_version_widget_small.dart';
import 'package:p7app/main_app/widgets/common_button.dart';
import 'package:p7app/main_app/widgets/loader.dart';
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
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _successfulSignUorLoginText(),
            SizedBox(height: 15),
            _loginEmail(context),
            SizedBox(height: 15),
            _loginPassword(context),
            SizedBox(height: 5),
            _forgotPasswordWidget(context),
            SizedBox(height: 5),
            Consumer<LoginViewModel>(
                builder: (BuildContext context, loginProvider, Widget child) {
                  if (loginProvider.isBusyLogin) {
                    return Loader();
                  }
                  return _signInButton(context);
                }),
            SizedBox(height: 10),
            _connectUsing(),
            SizedBox(height: 10,),
            _registerText(),

          ],
        ),
      ),
    );
  }
  Widget signInHeader = Container(
    height: 50,
//      margin: EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
        color: Colors.grey[200], borderRadius: BorderRadius.circular(5)),
    child: Row(
      children: <Widget>[
        Container(
          height: 50,
          width: 50,
          child: Icon(
            Icons.edit,
            color: Colors.black54,
          ),
        ),
        Container(
            height: 50,
            padding: EdgeInsets.only(top: 15),
            child: Text(
              StringUtils.signInText,
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            )),
      ],
    ),
  );
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
          return SizedBox();
        });
  }

  Widget _logoSection(double width) {
    return Hero(
      tag: kDefaultLogo,
      child: Image.asset(
        kDefaultLogo,
        width: width,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _loginEmail(context) {
    var loginProvider = Provider.of<LoginViewModel>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200],
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(1,1)
          )
        ]
      ),
      child: Center(
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          focusNode: _emailFocus,
          textInputAction: TextInputAction.next,
          controller: _emailTextController,
          decoration: InputDecoration(
//    contentPadding: EdgeInsets.zero,
              hintText: StringUtils.emailText,
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.lightBlueAccent,
                  width: 1.6,
                ),
                borderRadius: BorderRadius.circular(40),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1.6,
                ),
                borderRadius: BorderRadius.circular(40),
              ),
              //border: InputBorder.none,
              prefixIcon: Icon(
                Icons.person_outline,
              )),
          onSaved: (val) => loginProvider.email = val.trim(),
          validator: (val)=>Validator().validateEmail(val.trim()),
          onFieldSubmitted: (s) {
            _emailFocus.unfocus();
            FocusScope.of(_scaffoldKey.currentState.context)
                .requestFocus(_passwordFocus);
          },
        ),
      ),
    );
  }

  Widget _loginPassword(context) {
    return Consumer<LoginViewModel>(
      builder: (BuildContext context, loginProvider, Widget child) {
        bool isObscure = loginProvider.isObscurePassword;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200],
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(1,1)
                )
              ]
          ),
          child: Center(
            child: TextFormField(
              focusNode: _passwordFocus,
              textInputAction: TextInputAction.done,
              obscureText: loginProvider.isObscurePassword,
              controller: _passwordTextController,
              onFieldSubmitted: (s) {
                _handleLogin(_scaffoldKey.currentState.context);
              },
              decoration: InputDecoration(
                  errorMaxLines: 2,
                  hintText: StringUtils.passwordText,
                  hintStyle: TextStyle(
                    fontSize: 16.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.lightBlueAccent,
                      width: 1.6,
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.6,
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.lock,
                  ),
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
            ),
          ),
        );
      },
    );
  }

  Widget _signInButton(context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: 50,
      width: 200,
      child: CommonButton(
        onTap: () {
          _handleLogin(context);
        },
        label: StringUtils.logInButtonText,
      ),
    );
  }

  Widget _registerText() {

    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: StringUtils.doNotHaveAccountText,
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
              '  ${StringUtils.signupText}',
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
            CupertinoPageRoute(builder: (BuildContext context) => Root()),
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
                    _logoSection(160),
                    signInHeader,
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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 15, 16, 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(height: 0,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _logoSection(height*0.085),
              SizedBox(height: 10),
              _welcomeBackText(),
              SizedBox(height: 10),
              _buildForm(context),
              SizedBox(height: 50,),
              AppVersionWidgetLowerCase()
            ],
          ),
        ],
      ),
    );
  }

  Widget _connectUsing(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('Or connect using', style: TextStyle(color: Colors.grey[400], fontSize: 15),),
        SizedBox(height: 5,),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 40,
              width: 120,
              padding: EdgeInsets.symmetric(vertical: 13),
              decoration: BoxDecoration(
                color: Color.fromARGB(0xFF, 59, 89, 152),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), bottomLeft: Radius.circular(40))
              ),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ClipRRect(borderRadius:BorderRadius.only(topLeft: Radius.circular(40), bottomLeft: Radius.circular(40)),child: Image.asset('assets/images/fbIcon.png',fit: BoxFit.cover,)),
                    SizedBox(width: 5,),
                    Text('Facebook', style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
            ),
            SizedBox(width: 10,),
            Container(
              height: 40,
              width: 120,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Color.fromARGB(0xFF, 243, 80, 29),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(40), bottomRight: Radius.circular(40))
              ),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ClipRRect(borderRadius:BorderRadius.only(topLeft: Radius.circular(40), bottomLeft: Radius.circular(40)),child: Image.asset('assets/images/gmail_red_icon.png',fit: BoxFit.cover,)),
                    SizedBox(width: 5,),
                    Text('Google +', style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _welcomeBackText(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('Welcome back!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
        SizedBox(height: 10,),
        Text('Login to your existing account', style: TextStyle(fontSize: 15, color: Colors.grey[400]),)
      ],
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
