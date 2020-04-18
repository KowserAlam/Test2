import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/user_profile/models/portfolio_info.dart';
import 'package:p7app/features/user_profile/styles/profile_common_style.dart';
import 'package:p7app/main_app/resource/const.dart';

class PortfolioListItemWidget extends StatelessWidget {
  final PortfolioInfo portfolioInfo;

  const PortfolioListItemWidget({
    Key key,
    @required this.portfolioInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: ProfileCommonStyle.boxShadow,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CachedNetworkImage(
          height: 55,
          width: 55,
          imageUrl: portfolioInfo.image??kDefaultUserImageNetwork,
        ),
        title: Text(portfolioInfo.name ?? ""),
        subtitle: Text(portfolioInfo.description),
      ),
    );
  }
}
