
import 'package:assessment_ishraak/features/recent_exam/models/recent_exam_model.dart';
import 'package:assessment_ishraak/features/recent_exam/repositories/recent_exam_list_repository.dart';
import 'package:assessment_ishraak/main_app/models/exam_page_response_data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class RecentExamListScreenProvider with ChangeNotifier {

  List<RecentExamModel> _recentExamModelList = [];
  bool _isBusyLoading = false;
  bool _hasError = false;
  bool _hasMoreData = false;
  bool _isFetchingMoreData = false;
  /// track lazy loader page count
  int _pageCount = 1;
  bool _inSearchMode = false;


  bool get inSearchMode => _inSearchMode;

  set inSearchMode(bool value) {
    if(value != _inSearchMode){
      _inSearchMode = value;
      notifyListeners();
    }

  }

  bool get hasMoreData => _hasMoreData;

  set hasMoreData(bool value) {
    _hasMoreData = value;
    notifyListeners();
  }

  bool get isFetchingMoreData => _isFetchingMoreData;

  set isFetchingMoreData(bool value) {
    _isFetchingMoreData = value;
    notifyListeners();
  }

  bool get hasError => _hasError;

  set hasError(bool value) {
    _hasError = value;
    notifyListeners();
  }

  List<RecentExamModel> get recentExamModelList =>
      _recentExamModelList ?? null;

  set recentExamModelList(List<RecentExamModel> value) {
    _recentExamModelList = value;
    notifyListeners();
  }

  bool get isBusyLoading => _isBusyLoading;

  set isBusyLoading(bool value) {
//    print(value);
    _isBusyLoading = value;
    notifyListeners();
  }

  /// Search
  final _searchQuery = BehaviorSubject<String>();

  Function(String) get sinkSearchQuery => _searchQuery.sink.add;

  Stream<String> get searchQueryStream => _searchQuery.stream;

  listenStream() {
    _searchQuery
        .debounceTime(Duration(milliseconds: 600))
        .listen((query) async {
      resetPageCounter();
      _hasMoreData = false;
      getExamListData(queryText: query);
//      print("Qery: $query");
    });
  }

  /// Fetch data on Initial
  getExamListData({String queryText}) async {
    isBusyLoading = true;
    var result = await RecentExamListRepository()
        .fetchRecentExamList(1, queryText: queryText);
    if (hasError) {
      hasError = false;
    }

    result.fold((error) {
      hasError = true;
      isBusyLoading = false;
    }, (ExamPageResponseDataModel data) {
      recentExamModelList = data.examList;
      hasMoreData = data.hasMoreData;
      isBusyLoading = false;
      inSearchMode = true;
    });

  }

  /// fetch data on end of the scroll
  getMoreData({String queryText}) async {
    isFetchingMoreData = true;
    incrementPageCount();

    var result = await RecentExamListRepository()
        .fetchRecentExamList(_pageCount, queryText: queryText);
    if (hasError) {
      hasError = false;
      isFetchingMoreData = false;
    }
    result.fold((error) {
      hasError = true;
      isFetchingMoreData = false;
      hasMoreData = false;
    }, (ExamPageResponseDataModel<RecentExamModel> data) {
      recentExamModelList.addAll(data.examList);
      _hasMoreData = data.hasMoreData;
      isFetchingMoreData = false;

      notifyListeners();
    });
  }

  void incrementPageCount() {
    _pageCount++;
  }

  void resetPageCounter() {
    _pageCount = 1;
  }


  @override
  void dispose() {
    _searchQuery.close();
    super.dispose();
  }

  void resetState() {
    _recentExamModelList = [];
    _isBusyLoading = false;
    _hasError = false;
    _hasMoreData = false;
    _isFetchingMoreData = false;
    _pageCount = 1;
    inSearchMode = false;
  }
}
