import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/util/strings_utils.dart';
import 'package:p7app/main_app/widgets/gredient_buton.dart';
import 'package:p7app/main_app/widgets/loader.dart';
import 'package:p7app/features/exam_center/Centerlogin_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'candidate_list_screen.dart';

class CenterLoginScreen extends StatefulWidget {

  @override
  _CenterLoginScreenState createState() => _CenterLoginScreenState();
}

class _CenterLoginScreenState extends State<CenterLoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final bool isLargeScreen = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailTextController = TextEditingController();

  final _passwordTextController = TextEditingController();

//  initState(){
//    ApiHelper apiHelper = ApiHelper();
//    apiHelper.checkInternetConnectivity().then((status){
//      if(!status){
//        _showFlashBar(_scaffoldKey.currentContext);
//      }
//    });
//    super.initState();
//  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if(constraints.maxWidth < 720){
              return _mobileLayout(context);
            }else{
              return _tabLayout(context);
            }
          },),
      ),
    );
  }


  Widget _tabLayout(context){
    double topPadding = MediaQuery.of(context).size.height/30;
    var loginProvider = Provider.of<CenterLoginProvider>(context);
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Container(
                height: MediaQuery.of(context).size.height,
                child: Opacity(
                    opacity: .5,
                    child: Image.asset("images/bg_image_login.png",fit: BoxFit.contain))),),
          Expanded(
            flex: 4,
            child: Center(
              child: Container(
                width: 400,
                padding:  EdgeInsets.fromLTRB(16, topPadding, 16,0),
                child: Column(
                  children: <Widget>[
                    SizedBox (height: 10),
                    _logoSection(),
                    loginProvider.isLoading ? Column(children: <Widget>[
                      Loader(),
                      SizedBox (height: 10),
                      Text("Please Wait ..... "),
                      SizedBox (height: 10),
                    ],)
                        :_buildForm(context),
                    SizedBox (height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }

  Widget _mobileLayout(context){
    var topPadding = MediaQuery.of(context).size.height/4.2;
    var loginProvider = Provider.of<CenterLoginProvider>(context);
    return Padding(
      padding:  EdgeInsets.fromLTRB(8, topPadding, 8, 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox (height: 10),
          _logoSection(),
          SizedBox (height: 10),
          loginProvider.isLoading ? Loader()
              : _buildForm(context),
        ],
      ),
    );
  }

  Widget _buildForm(context){
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox (height: 10),
          _loginEmail(context),
          SizedBox (height: 20),
          _loginPassword(context),
          SizedBox (height: 20),
          _loginButton(context),
          SizedBox (height: 10),

        ],
      ),
    );
  }

  Widget _logoSection() {
    return Center(
      child: Image.asset("images/skill-check-logo.png",width: 300,height: 150,fit: BoxFit.cover,),
    );
  }

  Widget _loginEmail(context) {
    var loginProvider = Provider.of<CenterLoginProvider>(context);
    return Center(
      child: TextFormField(
key: Key("login-email"),
        controller: _emailTextController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            hintText: StringUtils.emailText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            prefixIcon: Icon(
              Icons.person,
              color: Colors.grey,
            )),
        onSaved: (val) => loginProvider.username = val,
        validator: LoginValidator.validateEmail,
      ),
    );
  }

  Widget _loginPassword(context) {
    var loginHelperProvider = Provider.of<CenterLoginProvider>(context);

    return TextFormField(
      obscureText: loginHelperProvider.obscurePassword,
      controller: _passwordTextController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: StringUtils.passwordText,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.grey,
          ),
          suffixIcon: IconButton(
            icon: !loginHelperProvider.obscurePassword
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off),
            onPressed: () => loginHelperProvider.obscurePassword =
            !loginHelperProvider.obscurePassword,
          )),
      onSaved: (val) => loginHelperProvider.password = val,
      validator: LoginValidator.validatePassword,
    );
  }

  Widget _loginButton(context) {

    return GradientButton(onTap: (){ _handleLogin(context);}, label:  StringUtils.loginButtonText,);
  }

  _handleLogin(BuildContext context) async{
    Urls apiHelper = Urls();

    bool isValid = _formKey.currentState.validate();

//    bool hasInternet = await apiHelper.checkInternetConnectivity();
//    if(!hasInternet){
//      _showSnackBar(Strings.checkInternetConnectionMessage,Colors.red[800]);
//
//    }

    if(isValid){
      _formKey.currentState.save();
      var loginProvider = Provider.of<CenterLoginProvider>(context);
      loginProvider.handleLogin().then((value){
        if(value){
          _showSnackBar(StringUtils.loginSuccessMessage,Colors.green[800]);
          _navigateToNextScreen(context);
        }else{
          _showSnackBar(StringUtils.loginUnsuccessfulMessage,Colors.red[800]);
        }
      });

    }
  }

  _showSnackBar(String text, Color color){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 600),
            content: Text(text,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
          backgroundColor: color,
        )
    );
  }

  _navigateToNextScreen(BuildContext context){
    Future.delayed(Duration(milliseconds: 500),(){
      Navigator.of(context).push( CupertinoPageRoute(builder: (BuildContext context) => CandidateListScreen()));
    });

  }

//  _showFlashBar(BuildContext context){
//    Flushbar(
//      flushbarPosition: FlushbarPosition.TOP,
//      title: "Network Error",
//      message: "Please check your connectivity !",
//      backgroundColor: Colors.red,
//    ).show(context);
//  }
}





class LoginValidator{
  static String validateEmail(String username)=>(username.length <4  || username.length > 20 )? StringUtils.invalidEmail : null;
  static String validatePassword(password) => (password.length <4  || password.length > 20 )? StringUtils.invalidPassword : null;
}

