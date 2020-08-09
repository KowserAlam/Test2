import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/messaging/view/conversation_screen.dart';
import 'package:p7app/features/messaging/view/widgets/no_message_widget.dart';
import 'package:p7app/features/messaging/view_mpdel/message_sender_list_screen_view_model.dart';
import 'package:p7app/features/notification/view_models/notificaion_view_model.dart';
import 'package:p7app/features/user_profile/styles/common_style_text_field.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/failure_widget.dart';
import 'package:p7app/main_app/views/widgets/loader.dart';
import 'package:p7app/main_app/views/widgets/page_state_builder.dart';
import 'package:provider/provider.dart';

class SenderListScreen extends StatefulWidget {
  @override
  _SenderListScreenState createState() => _SenderListScreenState();
}

class _SenderListScreenState extends State<SenderListScreen>
    with AfterLayoutMixin {
  ScrollController _scrollController = ScrollController();
  var _messageInoutTextEditingController = TextEditingController();

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<UserProfileViewModel>(context, listen: false).getUserData();
    var notiVM = Provider.of<MessageSenderListScreenViewModel>(context, listen: false);
    notiVM.getSenderList();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        notiVM.getMoreData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                          boxShadow: CommonStyleTextField.boxShadow),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) =>
                                  ConversationScreen(senderModel)));
                        },
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CachedNetworkImage(
                            imageUrl: senderModel.otherPartyImage,
                          ),
                        ),
                        title: Text(senderModel.otherPartyName ?? ""),
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
