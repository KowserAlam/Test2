import 'package:flutter/material.dart';
import 'package:p7app/features/user_profile/styles/common_style_text_field.dart';

class CustomDropdownButtonFormField<T> extends StatelessWidget {
  final String labelText;
  final Widget hint;
  final T value;
  final ValueChanged<T> onChanged;
  final List<DropdownMenuItem<T>> items;
  final FormFieldValidator<T> validator;
  final FocusNode focusNode;
  final bool isExpanded;

  CustomDropdownButtonFormField({
    this.validator,
    this.hint,
    this.labelText,
    this.isExpanded = false,
    this.focusNode,
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
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(7),
            boxShadow: CommonStyleTextField.boxShadow,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButtonFormField<T>(
              isExpanded: isExpanded,
              focusNode: focusNode,
              validator: validator,
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
