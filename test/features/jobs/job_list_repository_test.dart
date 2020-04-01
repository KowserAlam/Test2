import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:p7app/features/job/repositories/job_list_repository.dart';

import '../../test_data/dataReader.dart';
main(){
  group("RecentExamrepository enrollExamListFromJsonTest method test", () {
    var responseJsonSuccess;
    //arrange
    setUp(() async {
      responseJsonSuccess =
      await TestDataReader().readData("job_list_success.json");
    });

    test("enrollExamListFromJsonTest ith valid json should return valid list",
            () {
          // arrange
          var data = json.decode(responseJsonSuccess);

//      print(data[JsonKeys.data][JsonKeys.enrolledExamList]);

          //act
          var list = JobListRepository().fromJson(data);

          //assert

          expect(list.length, 2);
        });

  });
}