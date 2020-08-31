import 'package:flutter/material.dart';
import 'package:p7app/main_app/app_theme/common_style.dart';

class CustomDropdownButtonFormField<T> extends StatelessWidget {
  final String labelText;
  final Widget hint;
  final T value;
  final ValueChanged<T> onChanged;
  final List<DropdownMenuItem<T>> items;
  final FormFieldValidator<T> validator;
  final FocusNode focusNode;
  final bool isExpanded;
  final Key customDropdownKey;

  CustomDropdownButtonFormField({
    this.validator,
    this.hint,
    this.labelText,
    this.isExpanded = false,
    this.focusNode,
    @required this.value,
    @required this.onChanged,
    @required this.items,
    this.customDropdownKey
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
            boxShadow: CommonStyle.boxShadow,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButtonFormField<T>(
              key: customDropdownKey,
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
