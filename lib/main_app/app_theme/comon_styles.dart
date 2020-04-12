import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:flutter/material.dart';

const TextStyle kTitleTextBlackStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);
const TextStyle kTitleTextBlackStyleSmall = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
);
const TextStyle kButtonTextWhiteStyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0);
final kLabelTextPrimaryColor = TextStyle(
    fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.colorPrimary);

const TextStyle kIshraakTextStyle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: Color(0xff099CDC),
    fontFamily: "Roboto");
 TextStyle kTitleStyle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: AppTheme.colorPrimary,
    fontFamily: "Roboto");
const TextStyle kCandidateInfoTextBoldStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 17);
const TextStyle kCandidateInfoTextStyle = TextStyle(fontSize: 17);
const TextStyle kTimerTextStyleBold =
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
const TextStyle kTimerTextStyleRegular = TextStyle(fontSize: 18);

var kEmailInputDecoration = InputDecoration(
//    contentPadding: EdgeInsets.zero,
    hintText: StringUtils.emailText,
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
    ));
var kFullNameInputDecoration = InputDecoration(
    contentPadding: EdgeInsets.zero,
    hintText: StringUtils.labelTextFullName,
    hintStyle: TextStyle(
      fontSize: 16.0,
    ),
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
      Icons.person,
    ));

InputDecoration kPasswordInputDecoration({suffixIcon, hintText}) => InputDecoration(
  errorMaxLines: 3,
    hintText: hintText??StringUtils.passwordText,
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
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
    ),
    prefixIcon: Icon(
      Icons.lock,
    ),
    suffixIcon: suffixIcon);
