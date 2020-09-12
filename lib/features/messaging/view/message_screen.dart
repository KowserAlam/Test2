import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/messaging/view/conversation_screen.dart';
import 'package:p7app/features/messaging/view/widgets/no_message_widget.dart';
import 'package:p7app/features/messaging/view_mpdel/message_sender_list_screen_view_model.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/main_app/app_theme/common_style.dart';
import 'package:p7app/main_app/auth_service/auth_view_model.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/page_state_builder.dart';
import 'package:p7app/main_app/views/widgets/sign_in_message_widget.dart';
import 'package:provider/provider.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> with AfterLayoutMixin {
  ScrollController _scrollController = ScrollController();
  var _messageInoutTextEditingController = TextEditingController();

  @override
  void afterFirstLayout(BuildContext context) {
    var isLoggerIn = Provider.of<AuthViewModel>(context,listen: false).isLoggerIn;
    if (isLoggerIn) {
      Provider.of<UserProfileViewModel>(context, listen: false).getUserData();
      var notiVM =
          Provider.of<MessageSenderListScreenViewModel>(context, listen: false);
      notiVM.getSenderList();
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          notiVM.getMoreData();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var isLoggerIn = Provider.of<AuthViewModel>(context).isLoggerIn;
    if (!isLoggerIn) {
      return SignInMessageWidget();
    }

    var vm = Provider.of<MessageSenderListScreenViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(StringResources.messagesText),
      ),
//      drawer: AppDrawer(),
      body: PageStateBuilder(
        onRefresh: () => vm.refresh(),
        appError: vm.appError,
        showLoader: vm.shouldShowPageLoader,
        showError: vm.shouldShowAppError,
        child: Consumer<MessageSenderListScreenViewModel>(
            builder: (context, messagesViewModel, _) {
          if (messagesViewModel.shouldShowNoMessage) {
            return NoMessagesWidget();
          }

          return RefreshIndicator(
            onRefresh: () async => messagesViewModel.getSenderList(),
            child: SafeArea(
              child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  itemCount: messagesViewModel.senderList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var senderModel = messagesViewModel.senderList[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          boxShadow: CommonStyle.boxShadow),
                      child: Material(
                        type: MaterialType.transparency,
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          onTap: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) =>
                                    ConversationScreen(senderModel)));
                          },
                          leading: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: CachedNetworkImage(
                              height: 60,
                              width: 60,
                              imageUrl: senderModel.otherPartyImage,
                              placeholder: (__, _) =>
                                  Image.asset(kCompanyImagePlaceholder),
                            ),
                          ),
                          title: Text(senderModel.otherPartyName ?? ""),
                        ),
                      ),
                    );
                  }),
            ),
          );
        }),
      ),
    );
  }
}
