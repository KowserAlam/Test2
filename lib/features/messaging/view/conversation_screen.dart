import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/messaging/view/widgets/message_bubble.dart';
import 'package:p7app/features/messaging/view_mpdel/conversation_view_model.dart';
import 'package:p7app/features/notification/view_models/notificaion_view_model.dart';
import 'package:p7app/features/user_profile/styles/common_style_text_field.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/failure_widget.dart';
import 'package:provider/provider.dart';

class ConversationScreen extends StatefulWidget {
  final vm = ConversationViewModel();
  final String id;

  ConversationScreen(this.id);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen>
    with AfterLayoutMixin {
  ScrollController _scrollController = ScrollController();
  var _messageInoutTextEditingController = TextEditingController();

  @override
  void afterFirstLayout(BuildContext context) {
    widget.vm.getConversation(widget.id);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        widget.vm.getMoreData(widget.id);
      }
    });
  }

  _handleMessageSend() {}

  errorWidget() {
    var jobListViewModel =
        Provider.of<NotificationViewModel>(context, listen: false);
    switch (jobListViewModel.appError) {
      case AppError.serverError:
        return FailureFullScreenWidget(
          errorMessage: StringResources.unableToLoadData,
          onTap: () {
            return Provider.of<NotificationViewModel>(context, listen: false)
                .refresh();
          },
        );

      case AppError.networkError:
        return FailureFullScreenWidget(
          errorMessage: StringResources.unableToReachServerMessage,
          onTap: () {
            return Provider.of<NotificationViewModel>(context, listen: false)
                .refresh();
          },
        );

      default:
        return FailureFullScreenWidget(
          errorMessage: StringResources.somethingIsWrong,
          onTap: () {
            return Provider.of<NotificationViewModel>(context, listen: false)
                .refresh();
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => widget.vm,
      child: Consumer<ConversationViewModel>(builder: (context, vm, c) {
        var messages = vm.messages.reversed.toList();
        return Scaffold(
          appBar: AppBar(
            title: Text(StringResources.messagesText),
          ),
//      drawer: AppDrawer(),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(vertical: 4),
                      itemCount: messages.length,
                      reverse: true,
                      itemBuilder: (BuildContext context, int index) {
                        var message = messages[index];
                        return MessageBubble(message);
                      }),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: CommonStyleTextField.boxShadow,
                              color: Theme.of(context)
                                  .backgroundColor
                                  .withBlue(255),
                              borderRadius: BorderRadius.circular(7)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TextField(
                              controller: _messageInoutTextEditingController,
                              decoration: InputDecoration(
                                  hintText:
                                      StringResources.writeYourMessageText,
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      iconSize: 20,
                      color: Theme.of(context).accentColor,
                      onPressed: _handleMessageSend,
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
