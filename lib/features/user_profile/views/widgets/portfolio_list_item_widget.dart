import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/user_profile/models/portfolio_info.dart';
import 'package:p7app/features/user_profile/styles/common_style_text_field.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';

class PortfolioListItemWidget extends StatefulWidget {
  final PortfolioInfo portfolioInfo;
  final Function onTapEdit;
  final bool isInEditMode;
  final Function onTapDelete;

  const PortfolioListItemWidget(
      {Key key,
      @required this.portfolioInfo,
      this.onTapEdit,
      this.isInEditMode,
      this.onTapDelete})
      : super(key: key);

  @override
  _PortfolioListItemWidgetState createState() =>
      _PortfolioListItemWidgetState();
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                height: 55,
                width: 55,
                imageUrl: widget.portfolioInfo.image ?? "",
                placeholder: (context, _) => Image.asset(
                  kImagePlaceHolderAsset,
                  height: 55,
                  width: 55,
                ),
//          fit: BoxFit.cover,
              ),
              SizedBox(
                width: 10
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.portfolioInfo.name ?? "",
                      maxLines: 1,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(descriptionText ?? "",style: TextStyle(color: Colors.grey),),

                  ],
                ),
              ),
              if (widget.isInEditMode)
                Row(
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


            ],
          ),
          if (hasMoreText)
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: InkWell(
                onTap: () {
                  isExpanded = !isExpanded;
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isExpanded
                            ? StringResources.seeLessText
                            : StringResources.seeMoreText,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
