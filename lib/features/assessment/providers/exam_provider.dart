import 'dart:async';
import 'dart:convert';
import 'package:assessment_ishraak/features/assessment/repositories/question_fetch_repository.dart';
import 'package:assessment_ishraak/main_app/util/json_keys.dart';
import 'package:assessment_ishraak/main_app/api_helpers/urls.dart';
import 'package:http/http.dart' as http;
import 'package:assessment_ishraak/features/assessment/models/exam_model.dart';
import 'package:assessment_ishraak/features/assessment/models/questions_model.dart';
import 'package:assessment_ishraak/main_app/util/strings_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class ExamProvider with ChangeNotifier {
  int _currentQuestionIndex = 0;
  int _totalQuestionCount = 0;
  bool _isLastQuestionVisited = false;
  DateTime _startTime;
  bool _hasError = false;
  Timer _timer;

  bool get hasError => _hasError;
  List<QuestionModel> _questionList;

  List<QuestionModel> get questionList => _questionList ?? null;

  set questionList(List<QuestionModel> value) {
    _questionList = value;
    notifyListeners();
  }

  set hasError(bool value) {
    if (_hasError != value) {
      _hasError = value;
    }

    notifyListeners();
  }

  DateTime get startTime => _startTime;

  set startTime(DateTime value) {
    _startTime = value;
  }

  var _elapsedTimeStream = PublishSubject<Duration>();

  PublishSubject<Duration> get elapsedTimeStream => _elapsedTimeStream.stream;

  Function(Duration) get elapsedTimeSink => _elapsedTimeStream.sink.add;

  startExamClock(Duration duration) {
    _startTime = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      Duration eTime = DateTime.now().difference(_startTime);
      elapsedTimeSink(eTime);
      if (eTime >= duration) {
        timer.cancel();
      }
    });
  }

  bool get isLastQuestionVisited => _isLastQuestionVisited;

  set isLastQuestionVisited(bool value) {
    _isLastQuestionVisited = value;
  }

  int get totalQuestionCount => _totalQuestionCount;

  set totalQuestionCount(int value) {
    if (_totalQuestionCount != value) {
      _totalQuestionCount = value;
      notifyListeners();
    }
  }

  int get currentQuestionIndex => _currentQuestionIndex;

  set currentQuestionIndex(int value) {
    _currentQuestionIndex = value;
    notifyListeners();
  }

  Future<int> getQuestionData(String examId) async {
    hasError = false;

    var result = await QuestionFetchRepository().fetchQuestion(examId);

    return result.fold((left) {
      hasError = true;
      return null;
    }, (right) {
      hasError = false;
      questionList = right;
      if (right.length == 0) {
        hasError = true;
      }
      return right.length;
    });
  }

  /// user events

  ontTapOption({
    @required int optionIndex,
    @required int tabIndex,
    @required bool isRadio,
  }) {
    List<Answers> selectedAnswers =
        List.from(_questionList[tabIndex].selectedAnswers ?? []);

    /// Checking is question type is radio or checkbox
    if (!isRadio) {
      /// checking  already answered or not
      /// if answered then then it will unchecked
      /// if not then it will checked
      if (_questionList[tabIndex]
          .selectedAnswers
          .contains(_questionList[tabIndex].options[optionIndex])) {
        selectedAnswers.remove(_questionList[tabIndex].options[optionIndex]);
      } else {
        selectedAnswers.add(_questionList[tabIndex].options[optionIndex]);
      }
    } else {
      /// question type radio
      /// so only one option will be checked !
      selectedAnswers = [_questionList[tabIndex].options[optionIndex]];
    }
    _questionList[tabIndex].selectedAnswers = selectedAnswers;
    notifyListeners();
  }

  @override
  dispose() {
    _timer?.cancel();
    _elapsedTimeStream.close();
    super.dispose();
  }

  resetState() {
    _timer?.cancel();
    _isLastQuestionVisited = false;
    _hasError = false;
    _questionList = null;
    _totalQuestionCount = 0;
    elapsedTimeSink(null);
    _currentQuestionIndex = 0;
//    notifyListeners();
  }
}
