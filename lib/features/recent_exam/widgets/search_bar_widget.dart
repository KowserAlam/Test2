import 'package:p7app/main_app/util/strings_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  /// onChanged callback will called whenever any change made to the search bar
  final Function onChanged;

  /// onClear  button placed right side of the screen !
  /// It will always clear the text doesn't matter the the function is implemented or not
  final Function onClear;

  /// onBackPressed enable a back button on left side
  /// if null the it there will a search icon and it's not tap able.
  final Function onBackPressed;

  /// Auto focus  make keyboard ready to type by default it true
  final bool autofocus;

  SearchBarWidget({
    this.onChanged,
    this.autofocus,
    this.onClear,
    this.onBackPressed,
  });

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController _searchEditingController = TextEditingController();

  Widget backButtonWidget() =>       widget.onBackPressed == null
      ? SizedBox()
      : Container(
    width: 50,
    child: InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(CupertinoIcons.back),
      ),
      onTap: widget.onBackPressed,
    ),
  );
  Widget queryInputField() =>       Flexible(
    child: TextFormField(
      autofocus: widget.autofocus ?? true,
      maxLines: 1,
      onChanged: widget.onChanged,
      controller: _searchEditingController,
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        prefixIcon: widget.onBackPressed == null
            ? Icon(
          Icons.search,
          color: Colors.grey,
        )
            : null,
        border: InputBorder.none,
        hintText: StringUtils.searchText,
      ),
    ),
  );
  Widget rightSideClearButton() => InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.cancel,
            color: Colors.grey,
          ),
        ),
        onTap: () {
          _searchEditingController.clear();
          widget.onClear();
        },
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          backButtonWidget(),
          queryInputField(),
          rightSideClearButton(),
        ],
      ),
    );
  }
}
