import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:package_info/package_info.dart';
class AppInfoRepository{

  Future<String> getAppVersion()async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
//  print(StringsEn.versionText+": " +version);
  return  version;
}

}