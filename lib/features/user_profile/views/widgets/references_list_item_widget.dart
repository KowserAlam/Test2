import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/user_profile/models/reference_data.dart';
import 'package:p7app/main_app/app_theme/common_style.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';

class ReferencesListItemWidget extends StatefulWidget {
  final ReferenceData referenceData;
  final Function onTapEdit;
  final Function onTapDelete;
  final bool isInEditMode;
  final int index;

  const ReferencesListItemWidget({
    Key key,
    @required this.referenceData,
    this.isInEditMode,
    this.onTapEdit,
    this.onTapDelete,
    this.index
  }) : super(key: key);

  @override
  _ReferencesListItemWidgetState createState() =>
      _ReferencesListItemWidgetState();
}

class _ReferencesListItemWidgetState extends State<ReferencesListItemWidget> {
  bool isExpanded = false;
  int chLength = 150;

  @override
  Widget build(BuildContext context) {
    bool hasMoreText = widget.referenceData.description == null
        ? false
        : widget.referenceData.description.length > chLength;
    String text = (isExpanded || !hasMoreText)
        ? widget.referenceData?.description ?? ""
        : widget.referenceData?.description?.substring(0, chLength) ?? "";

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.only(top: 8, bottom: 8, right: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: CommonStyle.boxShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
//                    color: Theme.of(context).scaffoldBackgroundColor
                  ),
                  height: 55,
                  width: 55,
                  child: Icon(FontAwesomeIcons.user,size: 30,),
                ),
                Expanded(
                  child: Text(
                    text ?? "", key: Key('referenceDescription'+(widget.index+1).toString()),
                  ),
                ),
                if (widget.isInEditMode)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(FontAwesomeIcons.edit),
                        key: Key('myProfileReferencesTileEditButton'+(widget.index+1).toString()),
                        onPressed: widget.onTapEdit,
                        iconSize: 18,
                        color: Colors.black,
                      ),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.trash),
                        key: Key('myProfileReferencesTileDeleteButton'+(widget.index+1).toString()),
                        onPressed: widget.onTapDelete,
                        iconSize: 18,
                        color: Colors.black,
                      ),
                    ],
                  ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            if (hasMoreText)
              InkWell(
                onTap: () {
                  isExpanded = !isExpanded;
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    isExpanded
                        ? StringResources.seeLessText
                        : StringResources.seeMoreText,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
