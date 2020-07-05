import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
export 'package:dropdown_search/dropdown_search.dart';

class CustomDropdownSearchFormField<T> extends StatelessWidget {
  final FormFieldValidator<T> validator;
  final T selectedItem;
  final String labelText;
  final String hintText;
  final EdgeInsetsGeometry contentPadding;
  final Widget prefix;
  final ValueChanged<T> onChanged;

  ///customize the fields the be shown
  final DropdownSearchItemAsString<T> itemAsString;
  final int maxLength;
  final Mode mode;

  ///the max height for dialog/bottomSheet/Menu
  final double maxHeight;

  ///the max width for the dialog
  final double dialogMaxWidth;

  ///select the selected item in the menu/dialog/bottomSheet of items
  final bool showSelectedItem;
  final bool autoFocusSearchBox;

  ///custom layout for empty results
  final WidgetBuilder emptyBuilder;

  ///custom layout for loading items
  final WidgetBuilder loadingBuilder;

  ///offline items list
  final List<T> items;
  final DropdownSearchPopupItemEnabled<T> popupItemDisabled;

  ///function that compares two object with the same type to detected if it's the selected item or not
  final DropdownSearchCompareFn<T> compareFn;
  ///function that returns item from API
  final DropdownSearchOnFind<T> onFind;
  const CustomDropdownSearchFormField({
    this.showSelectedItem = false,
    this.autoFocusSearchBox = false,
    this.selectedItem,
    this.onFind,
    this.items,
    this.maxLength,
    this.itemAsString,
    this.validator,
    this.prefix,
    this.onChanged,
    this.compareFn,
    this.labelText,
    this.hintText,
    this.dialogMaxWidth,
    this.maxHeight,
    this.emptyBuilder,
    this.popupItemDisabled,
    this.mode = Mode.MENU,
    this.loadingBuilder,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (labelText != null)
          Text("  ${labelText ?? ""}",
              style: TextStyle(fontWeight: FontWeight.bold)),
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
          child: DropdownSearch<T>(
            hint: hintText,
            itemAsString: itemAsString,
            onChanged: onChanged,
            validator: validator,
            showSearchBox: true,
            mode: Mode.MENU,
            showSelectedItem: false,
            compareFn: compareFn,
            items: items,
            onFind: onFind,
            autoFocusSearchBox: autoFocusSearchBox,
            popupItemDisabled: popupItemDisabled,
            selectedItem: selectedItem,
            dropdownSearchDecoration: InputDecoration(
              prefix: prefix,
              border: InputBorder.none,
              hintText: hintText,
              contentPadding: contentPadding,
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
