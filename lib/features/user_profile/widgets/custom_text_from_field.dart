import 'package:flutter/material.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';

class CustomTextFormField extends StatelessWidget {
final Function validator;
final TextEditingController controller;
final String labelText;
final String hintText;
final TextInputType keyboardType;
final int maxLines;
final EdgeInsetsGeometry contentPadding;
final FocusNode focusNode;
final bool autofocus;
final TextInputAction textInputAction;
final ValueChanged<String> onFieldSubmitted;

const CustomTextFormField({
   this.validator,
   this.textInputAction,
   this.controller,
   this.onFieldSubmitted,
   this.focusNode,
   this.autofocus = false,
   this.labelText,
   this.hintText,
   this.keyboardType,
   this.contentPadding = const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
   this.maxLines = 1,
});


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("  "+labelText??"",style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(height: 5,),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(color: Color(0xff000000).withOpacity(0.2), blurRadius: 20),
              BoxShadow(color: Color(0xfffafafa).withOpacity(0.2), blurRadius: 20),

            ],),
          child: TextFormField(
            onFieldSubmitted:onFieldSubmitted,
            autofocus: autofocus,
            focusNode: focusNode,
            maxLines: maxLines,
            keyboardType: keyboardType,
            validator: validator,
            controller: controller,
            textInputAction: textInputAction,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: contentPadding,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor)
              ),
            ),
          ),
        ),
      ],
    );
  }



}
