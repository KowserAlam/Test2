import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:p7app/features/job/models/job_list_model.dart';
import 'package:p7app/features/job/models/job_model.dart';
import 'package:p7app/features/job/models/job_list_filters.dart';
import 'package:p7app/features/job/repositories/job_repository.dart';
import 'package:p7app/features/job/view_model/job_list_view_model.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:p7app/main_app/p7_app.dart';

class MockApiClient extends Mock implements ApiClient {}

class MockJobListRepository extends Mock implements JobRepository {}

main() {

  JobListViewModel viewModel = JobListViewModel();
  var client = MockApiClient();
  var mockRepository = MockJobListRepository();
  viewModel.jobListRepository = mockRepository;
  setUp(() {
    viewModel.jobList = [
      JobListModel(jobId: "abc", isFavourite: false, isApplied: false),
      JobListModel(jobId: "abc", isFavourite: false, isApplied: false),
    ];
  });


//  test("Testing getJobListMethod", () {
//    var list = [
//      JobModel(jobId: "xyz", status: false, isApplied: false),
//      JobModel(jobId: "qwe", status: false, isApplied: false),
//      JobModel(jobId: "qwrt", status: false, isApplied: false),
//    ];
//
//    when(mockRepository.fetchJobList(JobListFilters()))
//        .thenAnswer((_) async => Right(list));
//
//    expect( viewModel.jobList.length , 3);
//
//  });

//
//  test("Aply for job test", () async {
//    var data = {
//      "code": 200,
//      "result": {
//        "user": {
//          "job": "00e3e736-9cdb-451b-a065-af7c2e9b5ef8",
//          "status": "Saved"
//        }
//      }
//    };
//
//
//    when(client.postRequest('https://jsonplaceholder.typicode.com/posts/1', {}))
//        .thenAnswer((_) async => http.Response(json.encode(data), 200));
//
//    bool isSuccessful =
//        await viewModel.applyForJob("abc", 0, apiClient: client);
//
//    expect(isSuccessful, true);
//  });
}
