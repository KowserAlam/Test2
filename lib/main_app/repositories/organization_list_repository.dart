import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:p7app/features/user_profile/models/organization.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/util/logger_helper.dart';

class OrganizationListRepository {
  Future<List<Organization>> getCertifyingOrganizations(String query) async {
    try {
      var res =
          await ApiClient().getRequest("${Urls.certifyingOrganizationListUrl}?name=$query");

      if (res.statusCode == 200) {
        var decodedJson = json.decode(res.body);
        logger.i(decodedJson);

        List<Organization> list = fromJson(decodedJson);
        return list;
      } else {
        return [];
      }
    } catch (e) {
      logger.e(e);

      return [];
    }
  }

  Future<List<Organization>> getMembershipOrganizations(String query) async {
    try {
      var res =
          await ApiClient().getRequest("${Urls.membershipOrganizationListUrl}?name=$query");
      logger.i(query);
      if (res.statusCode == 200) {

        var decodedJson = json.decode(res.body);
        logger.i(decodedJson);

        List<Organization> list = fromJson(decodedJson);
        return list;
      } else {
        return [];
      }
    } catch (e) {
      logger.e(e);

      return [];
    }
  }

  List<Organization> fromJson(json) {
    List<Organization> list = [];
    json.forEach((element) {
      list.add(Organization.fromJson(element));
    });
    return list;
  }
}
