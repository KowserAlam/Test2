import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/auth/view/widgets/custom_text_field_rounded.dart';
import 'package:p7app/features/auth/view_models/login_view_model.dart';
import 'package:p7app/features/auth/view_models/signup_viewmodel.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/widgets/common_button.dart';
import 'package:p7app/main_app/widgets/loader.dart';
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


  _handleRegister(BuildContext context){
    var signUpProvider = Provider.of<SignUpViewModel>(context, listen: false);
    if (signUpProvider.isFromSuccessfulSignUp) {
      signUpProvider.isFromSuccessfulSignUp = false;
    }

    /// validating form

    bool isValid = signUpProvider.validate();
    if(isValid){print('Validated');}else{print('Not validated');}

    if(isValid){
      _fromKey.currentState.save();
      Provider.of<SignUpViewModel>(context,listen: false).signUpWithEmailPassword(
        name: _nameEditingController.text,
        password: _passwordEditingController.text,
        email: _emailEditingController.text,
        mobile: _mobileEditingController.text,
      ).then((v) {
        if(v){
          signUpProvider.resetState();
          Navigator.pop(context);
//          BotToast.showSimpleNotification(title: "Check your email verify account");
          Provider.of<LoginViewModel>(context,listen: false).isFromSuccessfulSignUp = true;

        }
      });

    }
  }

  @override
  Widget build(BuildContext context) {

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

    Widget registerButton = Consumer<SignUpViewModel>(
        builder: (BuildContext context, signUpProvider, Widget child) {
          if (signUpProvider.isBusy) {
            return Loader();
          }
          return Container(
            height: 50,
            width: 200,
            child: CommonButton(
              onTap: () {
                _handleRegister(context);
              },
              label: StringUtils.signUpText,
            ),
          );
        });

    var spaceBetweenFields = SizedBox(height: 20,);

     Widget signUpFrom = Consumer<SignUpViewModel>(
      builder: (context, signUpViewModel, _) {
        return Form(
          key: _fromKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              //Name
              SizedBox(height: 25),
              Consumer<SignUpViewModel>(
                builder: (context, signUpModel, _) {
                  return CustomTextFieldRounded(
                    errorText: signUpModel.errorTextName,
                    keyboardType: TextInputType.text,
                    focusNode: _nameFocusNode,
                    textInputAction: TextInputAction.next,
                    controller: _nameEditingController,
                    hintText: StringUtils.nameText,
                    prefixIcon: Icon(
                      Icons.person_outline,
                    ),
                    onChanged: signUpModel.validateNameLocal,
                    onSubmitted: (s) {
                      _nameFocusNode.unfocus();
                      FocusScope.of(_scaffoldKey.currentState.context)
                          .requestFocus(_emailFocusNode);
                    },
                  );
                },
              ),


              //Email
              spaceBetweenFields,
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
                      Icons.email,
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
              spaceBetweenFields,
              Consumer<SignUpViewModel>(
                builder: (context, signUpModel, _) {
                  return CustomTextFieldRounded(
                    errorText: signUpModel.errorTextMobile,
                    keyboardType: TextInputType.number,
                    focusNode: _mobileFocusNode,
                    textInputAction: TextInputAction.next,
                    controller: _mobileEditingController,
                    hintText: StringUtils.mobileText,
                    prefixIcon: Icon(
                      Icons.phone_iphone,
                    ),
                    onChanged: signUpModel.validateMobileLocal,
                    onSubmitted: (s) {
                      _mobileFocusNode.unfocus();
                      FocusScope.of(_scaffoldKey.currentState.context)
                          .requestFocus(_passwordFocusNode);
                    },
                  );
                },
              ),

              //Password TextField
              spaceBetweenFields,
              Consumer<SignUpViewModel>(
                builder: (context, signupViewModel, _) {
                  bool isObscure = signupViewModel.isObscurePassword;
                  return CustomTextFieldRounded(
                    onChanged: signupViewModel.validatePasswordLocal,
                    errorText: signupViewModel.errorTextPassword,
                    focusNode: _passwordFocusNode,
                    textInputAction: TextInputAction.next,
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
                        signupViewModel.isObscurePassword = !isObscure;
                      },
                    ),
                    obscureText: signupViewModel.isObscurePassword,
                    controller: _passwordEditingController,
                    hintText: StringUtils.passwordText,
                    onSubmitted: (s) {
                      _confirmPasswordFocusNode.unfocus();
                      FocusScope.of(_scaffoldKey.currentState.context)
                          .requestFocus(_confirmPasswordFocusNode);
                    },
                  );
                },
              ),

              //Confirm Password TextField
              spaceBetweenFields,
              Consumer<SignUpViewModel>(
                builder: (context, signupViewModel, _) {
                  bool isObscure = signupViewModel.isObscureConfirmPassword;
                  return CustomTextFieldRounded(
                    onChanged: signupViewModel.validateConfirmPasswordLocal,
                    errorText: signupViewModel.errorTextConfirmPassword,
                    focusNode: _confirmPasswordFocusNode,
                    textInputAction: TextInputAction.done,
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
                        signupViewModel.isObscureConfirmPassword = !isObscure;
                      },
                    ),
                    obscureText: signupViewModel.isObscureConfirmPassword,
                    controller: _confirmPasswordEditingController,
                    hintText: StringUtils.passwordText,
                    onSubmitted: (s) {
                      _handleRegister(_scaffoldKey.currentState.context);
                    },
                  );
                },
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
      body: SafeArea(
        child: SingleChildScrollView(
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
      ),
    );
  }
}
