import 'package:flutter/material.dart';
import 'package:p7app/features/user_profile/styles/common_style_text_field.dart';

class CustomDropdownButtonFormField<T> extends StatelessWidget {
  final String labelText;
  final Widget hint;
  final  T value;
  final  Function onChanged;
  final List<DropdownMenuItem<T>> items;

  CustomDropdownButtonFormField({
    this.hint,
    this.labelText,
    @required this.value,
    @required this.onChanged,
    @required this.items,
  });



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Text(
          "  ${labelText ?? ""}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),

        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(7),
            boxShadow: CommonStyleTextField.boxShadow,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButtonFormField<T>(
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              hint: hint,
              value: value,
              onChanged: onChanged,
              items: items,
            ),
          ),
        ),
      ],
    );
  }

}
