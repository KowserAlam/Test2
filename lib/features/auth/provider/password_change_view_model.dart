import 'package:flutter/cupertino.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';

class PasswordChangeViewModel with ChangeNotifier {
  changePassword(
      {@required String oldPassword, @required String newPassword}) {

    ApiClient().postRequest(Urls.passwordChangeUrl, {

    });
  }
}
