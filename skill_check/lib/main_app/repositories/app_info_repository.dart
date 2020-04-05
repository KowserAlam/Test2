import 'package:skill_check/main_app/util/strings_utils.dart';
import 'package:package_info/package_info.dart';
class AppInfoRepository{

  Future<String> getAppVersion()async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
//  print(StringsEn.versionText+": " +version);
  return  version;
}

}