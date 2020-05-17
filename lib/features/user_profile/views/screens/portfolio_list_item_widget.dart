import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/user_profile/models/portfolio_info.dart';
import 'package:p7app/features/user_profile/styles/common_style_text_field.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';

class PortfolioListItemWidget extends StatefulWidget {
  final PortfolioInfo portfolioInfo;
  final Function onTapEdit;
  final bool isInEditMode;
  final Function onTapDelete;

  const PortfolioListItemWidget({
    Key key,
    @required this.portfolioInfo,this.onTapEdit,this.isInEditMode,this.onTapDelete
  }) : super(key: key);

  @override
  _PortfolioListItemWidgetState createState() => _PortfolioListItemWidgetState();
}

class _PortfolioListItemWidgetState extends State<PortfolioListItemWidget> {

  bool isExpanded = false;
  int chLength = 150;



  @override
  Widget build(BuildContext context) {

    bool hasMoreText = widget.portfolioInfo.description == null
        ? false
        : widget.portfolioInfo.description.length > chLength;
    String descriptionText = (isExpanded || !hasMoreText)
        ? widget.portfolioInfo?.description ?? ""
        : widget.portfolioInfo?.description?.substring(0, chLength) ?? "";

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: CommonStyleTextField.boxShadow,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CachedNetworkImage(
          height: 55,
          width: 55,

          imageUrl: widget.portfolioInfo.image??"",
          placeholder: (context, _) => Image.asset(
            kImagePlaceHolderAsset,
            height: 55,
            width: 55,
          ),

        ),
        title: Text(widget.portfolioInfo.name ?? "",maxLines: 1,),
        subtitle: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(descriptionText??"")),
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
                        ? StringUtils.seeLessText
                        : StringUtils.seeMoreText,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              )
          ],
        ),
        trailing:  !widget.isInEditMode
            ? null
            : Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(FontAwesomeIcons.edit),
              onPressed: widget.onTapEdit,
              iconSize: 18,
              color: Colors.black,
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.trash),
              onPressed: widget.onTapDelete,
              iconSize: 18,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
