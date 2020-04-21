import 'package:flutter/material.dart';
import 'package:p7app/main_app/util/validator.dart';

class CustomTextFormField extends StatefulWidget {
  final Function validator;
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final int maxLines;
  final EdgeInsetsGeometry contentPadding;
  final FocusNode focusNode;
  final bool autofocus;
  final bool autovalidate;
  final TextInputAction textInputAction;
  final ValueChanged<String> onFieldSubmitted;

  const CustomTextFormField({
    this.validator,
    this.textInputAction,
    this.autovalidate = false,
    this.controller,
    this.onFieldSubmitted,
    this.focusNode,
    this.autofocus = false,
    this.labelText,
    this.hintText,
    this.keyboardType,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    this.maxLines = 1,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {

//  String errorText;
//
//  String handleValidation(String s) {
//    if (widget.validator != null) {
//      errorText = widget.validator(widget.controller?.text);
//      setState(() {});
//
//      return "";
//    } else {
//      errorText = null;
//      return "";
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "  " + widget.labelText ?? "",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                  color: Color(0xff000000).withOpacity(0.2), blurRadius: 20),
              BoxShadow(
                  color: Color(0xfffafafa).withOpacity(0.2), blurRadius: 20),
            ],
          ),
          child: TextFormField(
            onFieldSubmitted: widget.onFieldSubmitted,
            autofocus: widget.autofocus,
            focusNode: widget.focusNode,
            maxLines: widget.maxLines,
            autovalidate: widget.autovalidate,
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            controller: widget.controller,
            textInputAction: widget.textInputAction,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: widget.contentPadding,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColor)),
            ),
          ),
        ),
//        errorText != null ? Text('') : SizedBox(),
      ],
    );
  }
}
