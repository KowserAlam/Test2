
import 'package:flutter_test/flutter_test.dart';
import 'package:p7app/features/job/models/job.dart';
import 'package:p7app/features/job/view_model/job_list_view_model.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';

class MockApiClient extends ApiClient{}

main(){

  JobListViewModel viewModel = JobListViewModel();
  setUp((){
    viewModel.jobList = [
      JobModel(jobId: "123",),
    ];

  });

  test("Aply for job test", (){

  });
}