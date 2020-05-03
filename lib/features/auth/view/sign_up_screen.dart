import 'package:p7app/features/auth/provider/login_view_model.dart';
import 'package:p7app/features/auth/provider/signup_viewmodel.dart';
import 'package:p7app/features/auth/view/widgets/custom_text_field_rounded.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/main_app/widgets/common_button.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _checkboxValue = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _emailEditingController = TextEditingController();
  TextEditingController _mobileEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();
  TextEditingController _confirmPasswordEditingController =
  TextEditingController();

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _nameFocusNode = FocusNode();
  FocusNode _mobileFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();
  var _fromKey = GlobalKey<FormState>();


  @override
  void dispose() {
    _nameEditingController.dispose();
    _emailEditingController.dispose();
    _mobileEditingController.dispose();
    _passwordEditingController.dispose();
    _confirmPasswordEditingController.dispose();
    super.dispose();
  }
  _handleRegister(){
    bool isValid = _fromKey.currentState.validate();
    if(isValid){
      _fromKey.currentState.save();
      Provider.of<SignUpViewModel>(context,listen: false).signUpWithEmailPassword(
        name: _nameEditingController.text,
        password: _passwordEditingController.text,
        email: _emailEditingController.text,
        mobile: _mobileEditingController.text,
      ).then((v) {
        if(v){
          Navigator.pop(context);
//          BotToast.showSimpleNotification(title: "Check your email verify account");
          Provider.of<LoginViewModel>(context,listen: false).isFromSuccessfulSignUp = true;

        }
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final topPadding = AppBar().preferredSize.height;
    final primaryColor = Theme.of(context).primaryColor;



    Widget logo = Container(
      height: 60,
      width: 150,
      child: Image.asset(kDefaultLogo),
    );
    Widget backToSignIn = RichText(
      text: TextSpan(children: [
        TextSpan(
          text: StringUtils.alreadyHaveAndAccountText,
          style: TextStyle(color: Colors.grey, fontSize: 15),
        ),
        WidgetSpan(
          child: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Text(
              '  ${StringUtils.signInText}',
              style: TextStyle(
                  color: primaryColor, fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),),
      ]),
    );

    Widget registerButton = Container(
      height: 50,
      width: 200,
      child: CommonButton(
        onTap: () {
          _handleRegister();
        },
        label: StringUtils.signUpText,
      ),
    );
    Widget signUpHeader = Container(
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
                StringUtils.registerAccountText,
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              )),
        ],
      ),
    );

     Widget signUpFrom = Consumer<SignUpViewModel>(
      builder: (context, signUpViewModel, _) {
        return Form(
          key: _fromKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 25),
              Container(
                padding: EdgeInsets.only(left: 15),
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
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    focusNode: _nameFocusNode,
                    onFieldSubmitted: (v){
                      _emailFocusNode.requestFocus();
                    },
                    validator: Validator().nullFieldValidate,
                    controller: _nameEditingController,
                    decoration: InputDecoration.collapsed(
                      hintText: StringUtils.nameText,
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              //Email
              SizedBox(height: 25),
              Consumer<SignUpViewModel>(
                builder: (context, signUpModel, _) {
                  return CustomTextFieldRounded(
                    errorText: signUpModel.errorTextEmail,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _emailFocusNode,
                    textInputAction: TextInputAction.next,
                    controller: _emailEditingController,
                    hintText: StringUtils.emailText,
                    prefixIcon: Icon(
                      Icons.person_outline,
                    ),
                    onChanged: signUpModel.validateEmailLocal,
                    onSubmitted: (s) {
                      _emailFocusNode.unfocus();
                      FocusScope.of(_scaffoldKey.currentState.context)
                          .requestFocus(_mobileFocusNode);
                    },
                  );
                },
              ),

            //Mobile TextField
            SizedBox(height: 25),
            Consumer<SignUpViewModel>(
              builder: (context, signUpModel, _) {
                return CustomTextFieldRounded(
                  errorText: signUpModel.errorTextEmail,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: _emailFocusNode,
                  textInputAction: TextInputAction.next,
                  controller: _emailEditingController,
                  hintText: StringUtils.emailText,
                  prefixIcon: Icon(
                    Icons.person_outline,
                  ),
                  onChanged: signUpModel.validateEmailLocal,
                  onSubmitted: (s) {
                    _emailFocusNode.unfocus();
                    FocusScope.of(_scaffoldKey.currentState.context)
                        .requestFocus(_mobileFocusNode);
                  },
                );
              },
            ),
              SizedBox(height: 25),
              //Password TextField
              Container(
                padding: EdgeInsets.only(left: 15),
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
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    focusNode: _passwordFocusNode,
                    onFieldSubmitted: (v){
                      _confirmPasswordFocusNode.requestFocus();

                    },
                    validator: Validator().validatePassword,
                    controller: _passwordEditingController,
                    obscureText: signUpViewModel.isObscurePassword,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: StringUtils.passwordText,
                      errorMaxLines: 2,
                      hintStyle: TextStyle(color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: !signUpViewModel.isObscurePassword
                            ? Icon(
                          Icons.visibility,
                        )
                            : Icon(
                          Icons.visibility_off,
                          color: Theme.of(context).textTheme.body1.color,
                        ),
                        onPressed: () {
                          signUpViewModel.isObscurePassword =
                          !signUpViewModel.isObscurePassword;
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              //Confirm Password TextField
              Container(
                padding: EdgeInsets.only(left: 15),
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
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    validator: (cp)=>Validator().validateConfirmPassword(_passwordEditingController.text, cp),
                    controller: _confirmPasswordEditingController,
                    focusNode: _confirmPasswordFocusNode,
                    onFieldSubmitted: (v){
                      _confirmPasswordFocusNode.unfocus();
                      _handleRegister();
                    },
                    obscureText: signUpViewModel.isObscurePassword,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: StringUtils.confirmPasswordText,
                      hintStyle: TextStyle(color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: !signUpViewModel.isObscurePassword
                            ? Icon(
                          Icons.visibility,
                        )
                            : Icon(
                          Icons.visibility_off,

                        ),
                        onPressed: () {
                          signUpViewModel.isObscurePassword =
                          !signUpViewModel.isObscurePassword;
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        );
      },
    );

    Widget acceptTermAndCondition = Row(
      children: <Widget>[
        Checkbox(
          value: _checkboxValue,
          checkColor: primaryColor,
          activeColor: Colors.white,
          onChanged: (bool something) {
            _checkboxValue = something;
            setState(() {});
          },
        ),
        Text(
          'I accept the terms & conditions',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );

    Widget _registerNewAccountText(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Sign up', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
          SizedBox(height: 10,),
//          Text('Login to your existing account', style: TextStyle(fontSize: 15, color: Colors.grey[400]),)
        ],
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: topPadding),
              logo,
              SizedBox(height: 20),
              _registerNewAccountText(),
              signUpFrom,
//              acceptTermAndCondition,
              SizedBox(height: 30),
              registerButton,
              SizedBox(height: 30),
              backToSignIn,
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
