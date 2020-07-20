import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
export 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:p7app/features/user_profile/styles/common_style_text_field.dart';

class CustomAutoCompleteTextField<T> extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String initialValue;
  final EdgeInsetsGeometry contentPadding;
  final Widget prefix;
  final ValueChanged<T> onChanged;
  final bool isRequired;
  final TextEditingController controller;
  final int maxLength;
  final SuggestionSelectionCallback<T> onSuggestionSelected;
  final ItemBuilder<T> itemBuilder;
  final SuggestionsCallback<T> suggestionsCallback;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final WidgetBuilder noItemsFoundBuilder;

  const CustomAutoCompleteTextField({
    this.noItemsFoundBuilder,
    this.controller,
    this.isRequired = false,
    this.maxLength,
    this.validator,
    this.prefix,
    this.onSaved,
    this.onChanged,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 10,
    ),
    @required this.onSuggestionSelected,
    @required this.itemBuilder,
    @required this.suggestionsCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Text("  ${labelText ?? ""}",
                style: TextStyle(fontWeight: FontWeight.bold)),
            if (isRequired)
              Text(
                " *",
                style: TextStyle(color: Colors.red),
              )
          ],
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
          child: TypeAheadFormField<T>(
            initialValue: initialValue,
            textFieldConfiguration: TextFieldConfiguration(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                )),
            itemBuilder: itemBuilder,
            onSuggestionSelected: onSuggestionSelected,
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            suggestionsCallback: suggestionsCallback,
            validator: validator,
            noItemsFoundBuilder: noItemsFoundBuilder ??
                (context) {
                  return SizedBox();
                },
          ),
        ),
      ],
    );
  }
}
