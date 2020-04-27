import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/user_profile/models/portfolio_info.dart';
import 'package:p7app/features/user_profile/styles/common_style_text_field.dart';
import 'package:p7app/main_app/resource/const.dart';

class PortfolioListItemWidget extends StatelessWidget {
  final PortfolioInfo portfolioInfo;
  final Function onTapEdit;
  final bool isInEditMode;

  const PortfolioListItemWidget({
    Key key,
    @required this.portfolioInfo,this.onTapEdit,this.isInEditMode
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          imageUrl: portfolioInfo.image??"",
          placeholder: (context, _) => Image.asset(
            kImagePlaceHolderAsset,
            height: 55,
            width: 55,
          ),
          fit: BoxFit.cover,
        ),
        title: Text(portfolioInfo.name ?? ""),
        subtitle: Text(portfolioInfo.description),
        trailing: !isInEditMode?SizedBox():IconButton(
          icon: Icon(FontAwesomeIcons.edit),
          onPressed: onTapEdit,
        ),
      ),
    );
  }
}
