import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/messaging/view/widgets/no_message_widget.dart';
import 'package:p7app/features/messaging/view_mpdel/message_screen_view_model.dart';
import 'package:p7app/features/notification/view_models/notificaion_view_model.dart';
import 'package:p7app/features/user_profile/styles/common_style_text_field.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/widgets/app_drawer.dart';
import 'package:p7app/main_app/widgets/failure_widget.dart';
import 'package:p7app/main_app/widgets/loader.dart';
import 'package:provider/provider.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> with AfterLayoutMixin {
  ScrollController _scrollController = ScrollController();

  @override
  void afterFirstLayout(BuildContext context) {
    var notiVM = Provider.of<MessageScreenViewModel>(context, listen: false);
    notiVM.getNotifications();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        notiVM.getMoreData();
      }
    });
  }

  errorWidget() {
    var jobListViewModel =
        Provider.of<NotificationViewModel>(context, listen: false);
    switch (jobListViewModel.appError) {
      case AppError.serverError:
        return FailureFullScreenWidget(
          errorMessage: StringUtils.unableToLoadData,
          onTap: () {
            return Provider.of<NotificationViewModel>(context, listen: false)
                .refresh();
          },
        );

      case AppError.networkError:
        return FailureFullScreenWidget(
          errorMessage: StringUtils.unableToReachServerMessage,
          onTap: () {
            return Provider.of<NotificationViewModel>(context, listen: false)
                .refresh();
          },
        );

      default:
        return FailureFullScreenWidget(
          errorMessage: StringUtils.somethingIsWrong,
          onTap: () {
            return Provider.of<NotificationViewModel>(context, listen: false)
                .refresh();
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.notificationsText),
      ),
//      drawer: AppDrawer(),
      body: Consumer<MessageScreenViewModel>(
          builder: (context, messagesViewModel, _) {
        if (messagesViewModel.shouldShowPageLoader) {
          return Center(
            child: Loader(),
          );
        }
        if (messagesViewModel.shouldShowAppError) {
          return errorWidget();
        }
        if (messagesViewModel.shouldShowNoMessage) {
          return NoMessagesWidget();
        }

        return RefreshIndicator(
          onRefresh: () async => messagesViewModel.getNotifications(),
          child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              padding: EdgeInsets.symmetric(vertical: 4),
              itemCount: messagesViewModel.messages.length,
              itemBuilder: (BuildContext context, int index) {
                var message = messagesViewModel.messages[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    boxShadow: CommonStyleTextField.boxShadow
                  ),
                  child: ListTile(
                    title: Text(message.createdBy ?? ""),
                    subtitle: Text(message.message ?? ""),
                  ),
                );
              }),
        );
      }),
    );
  }
}
