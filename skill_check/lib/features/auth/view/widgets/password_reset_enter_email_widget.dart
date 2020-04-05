import 'package:skill_check/features/auth/provider/password_reset_provider.dart';
import 'package:skill_check/features/auth/view/login_screen.dart';
import 'package:skill_check/features/auth/view/widgets/title_widget.dart';

import 'package:skill_check/main_app/util/const.dart';
import 'package:skill_check/main_app/util/strings_utils.dart';
import 'package:skill_check/main_app/widgets/gredient_buton.dart';
import 'package:skill_check/main_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Enter email page

class PasswordResetEmailWidget extends StatefulWidget {
  final Function onSuccessCallBack;

  PasswordResetEmailWidget({this.onSuccessCallBack});

  @override
  _PasswordResetEmailWidgetState createState() =>
      _PasswordResetEmailWidgetState();
}

class _PasswordResetEmailWidgetState extends State<PasswordResetEmailWidget> {
  final _emailTextController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();

  Widget _logoSection() {
    return Center(
      child: Hero(
        tag: kDefaultLogo,
        child: Image.asset(
          kDefaultLogo,
          width: 150,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _titleText() {
    return  TitleWidget(labelText: StringUtils.passwordResetText,);
  }

  Widget _inputTypeSelectionItemWidget(
          {@required bool value,
          bool groupValue = true,
          @required Function(bool value) onChanged,
          @required String label}) =>
      Row(
        children: <Widget>[
          Radio(
            onChanged: onChanged,
            groupValue: groupValue,
            value: value,
          ),
          Text(
            label,
            style: TextStyle(fontSize: 17),
          ),
        ],
      );

  Widget _passwordResetMethodWidget(context) => Consumer<PasswordResetProvider>(
          builder: (context, passwordResetProvider, _) {
        return Row(
          children: <Widget>[
            _inputTypeSelectionItemWidget(
                label: StringUtils.emailText,
                onChanged: (value) {
                  /// Email
                  passwordResetProvider.passwordResetMethodIsEmail = true;
                  _emailFocus.unfocus();
                  _emailTextController.clear();
                },
                value: passwordResetProvider.passwordResetMethodIsEmail),
            SizedBox(
              width: 10,
            ),
            _inputTypeSelectionItemWidget(
                groupValue: false,
                label: StringUtils.smsText,
                onChanged: (value) {
                  /// Phone
                  passwordResetProvider.passwordResetMethodIsEmail = false;
                  _emailTextController.clear();
                  _emailFocus.unfocus();
                },
                value: passwordResetProvider.passwordResetMethodIsEmail),
          ],
        );
      });

  Widget _email(context) {
    return Center(
      child: Consumer<PasswordResetProvider>(
          builder: (context, passwordResetProvider, _) {

        var hintText = passwordResetProvider.passwordResetMethodIsEmail
            ? StringUtils.emailText
            : StringUtils.phoneText;
        var iconPrefix = passwordResetProvider.passwordResetMethodIsEmail
            ? Icons.mail
            : Icons.phone_android;
        var keyboardType = passwordResetProvider.passwordResetMethodIsEmail
            ? TextInputType.emailAddress
            : TextInputType.phone;

        return StreamBuilder<String>(
            stream: passwordResetProvider.inputStream,
            builder: (context, snapshot) {
              return TextField(
                keyboardType: keyboardType,
                onChanged: passwordResetProvider.inputSink,
                focusNode: _emailFocus,
                textInputAction: TextInputAction.done,
                onSubmitted: (email) {
                  _handleEmailSubmit(email, context);
                },
                controller: _emailTextController,
                decoration: InputDecoration(
                    errorText:
                        snapshot.error == null ? null : "  ${snapshot.error}",
                    contentPadding: EdgeInsets.zero,
                    errorStyle: TextStyle(fontSize: 15),
                    hintText: hintText,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.6,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    prefixIcon: Icon(
                      iconPrefix,
                    )),
              );
            });
      }),
    );
  }

  Widget _proceedButton() {
    var passwordResetProvider = Provider.of<PasswordResetProvider>(context);
    return Center(
      child: passwordResetProvider.isBusyEmail
          ? Loader()
          : GradientButton(
              onTap: () {
                _handleEmailSubmit(_emailTextController.text, context);
              },
              label: StringUtils.proceedText,
            ),
    );
  }

  _handleEmailSubmit(String email, context) async {
    if (true) {
      widget.onSuccessCallBack();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width =
        MediaQuery.of(context).size.width > 720 ? 500 : double.infinity;
    return Center(
      child: Container(
        width: width,
        child: ListView(
          padding: EdgeInsets.all(8.0),
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            _logoSection(),
            SizedBox(height: 10),
            _titleText(),
            SizedBox(height: 24),
            _passwordResetMethodWidget(context),
            _email(context),
            SizedBox(height: 20),
            _proceedButton(),
          ],
        ),
      ),
    );
  }
}
