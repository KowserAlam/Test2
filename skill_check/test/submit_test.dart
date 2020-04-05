

import 'package:skill_check/features/assessment/models/questions_model.dart';
import 'package:skill_check/features/assessment/models/submit_asn_model.dart';
import 'package:skill_check/features/assessment/providers/submit_provider.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}


main() {


  test("getSubmitAnsModel Test, Should return 2",(){
    SubmitProvider submitProvider = SubmitProvider();
    var questionList = [
      QuestionModel(question: "Test Question 1",options: [Answers(name: "Optioin 1",id: "123")],id: "123",selectedAnswers: [Answers(name: "Optioin 1",id: "123")]),
      QuestionModel(question: "Test Question 1",options: [Answers(name: "Optioin 1",id: "123")],id: "123",selectedAnswers: [Answers(name: "Optioin 1",id: "123")]),
    ];

    SubmitAnsModel actualValue =  submitProvider.getSubmitAnsModel(regId: "123",userId: "123", questionList:questionList);
    expect(actualValue.questionAnsList.length, 2);

  });

  test("getSubmitAnsModel Test, Should return 0",(){
    SubmitProvider submitProvider = SubmitProvider();
    List<QuestionModel> questionList = [];

    SubmitAnsModel actualValue =  submitProvider.getSubmitAnsModel(regId: "123",userId: "123", questionList:questionList);
    expect(actualValue.questionAnsList.length, 0);

  });

  test("getSortedAnsListInInteger Test, giving [3,1]  Should return [1,3]",(){
    SubmitProvider submitProvider = SubmitProvider();

    List<int> actualValue =  submitProvider.getSortedAnsListInInteger(QuestionModel(selectedAnswers: [Answers(id: "3",name: "data"),Answers(id: "1",name: "data")]));
    expect(actualValue, [1,3]);

  });

  test("getSortedAnsListInInteger Test, giving []  Should return []",(){
    SubmitProvider submitProvider = SubmitProvider();
    List<int> actualValue =  submitProvider.getSortedAnsListInInteger(QuestionModel(selectedAnswers: []));
    expect(actualValue, []);

  });




}
