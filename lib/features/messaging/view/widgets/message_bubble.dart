import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:p7app/features/messaging/model/conversation_screen_data_model.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:provider/provider.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  MessageBubble(this.message);

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    var userProfileVm = Provider.of<UserProfileViewModel>(context);
    var userId = userProfileVm.userData.personalInfo.user;
    bool isMe = userId == message.sender;
    var appUser = userProfileVm.userData.personalInfo;
    print("userID: $userId senderID: ${message.sender}");

    Color bubbleColor = isMe ? Colors.white : primaryColor;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        child: Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isMe)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 12,
                  backgroundImage: CachedNetworkImageProvider(
                      message?.senderCompany?.profilePicture ?? ""),
                ),
              ),
            Container(
                constraints: BoxConstraints(minWidth: 50, maxWidth: 280),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: bubbleColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    message?.message ?? "",
                    softWrap: true,
                  ),
                )),
            if (isMe)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 12,
                  backgroundImage:
                      CachedNetworkImageProvider(appUser?.profileImage ?? ""),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
