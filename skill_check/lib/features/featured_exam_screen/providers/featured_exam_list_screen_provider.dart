import 'package:skill_check/main_app/models/exam_page_response_data_model.dart';
import 'package:skill_check/features/featured_exam_screen/repositories/featured_exam_list_repository.dart';
import 'package:skill_check/features/home_screen/models/dashboard_models.dart';
import 'package:skill_check/features/featured_exam_screen/models/featured_exam_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class FeaturedExamListScreenProvider with ChangeNotifier {
  List<FeaturedExamModel> _featuredExamModelList = [];
  bool _isBusyLoading = false;
  bool _hasError = false;
  bool _hasMoreData = false;
  bool _isFetchingMoreData = false;

  /// track lazy loader page count
  int _pageCount = 1;
  bool _inSearchMode = false;

  bool get inSearchMode => _inSearchMode;

  set inSearchMode(bool value) {
    if (value != _inSearchMode) {
      _inSearchMode = value;
      notifyListeners();
    }
  }

  bool get hasMoreData => _hasMoreData;

  set hasMoreData(bool value) {
    if (value != _hasMoreData) {
      _hasMoreData = value;
      notifyListeners();
    }
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

  List<FeaturedExamModel> get featuredExamModelList =>
      _featuredExamModelList ?? null;

  set featuredExamModelList(List<FeaturedExamModel> value) {
    _featuredExamModelList = value;
    notifyListeners();
  }

  bool get isBusyLoading => _isBusyLoading;

  set isBusyLoading(bool value) {
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
    var result = await FeaturedExamListRepository()
        .fetchFeaturedExamList(1, queryText: queryText);
    if (hasError) {
      hasError = false;
    }

    result.fold((error) {
      hasError = true;
      isBusyLoading = false;
    }, (ExamPageResponseDataModel data) {
      featuredExamModelList = data.examList;
      hasMoreData = data.hasMoreData;
      isBusyLoading = false;
      inSearchMode = true;
    });
  }

  /// fetch data on end of the scroll
  getMoreData({String queryText}) async {
    isFetchingMoreData = true;
    incrementPageCount();

    var result = await FeaturedExamListRepository()
        .fetchFeaturedExamList(_pageCount, queryText: queryText);
    if (hasError) {
      hasError = false;
      isFetchingMoreData = false;
    }
    result.fold((error) {
      hasError = true;
      isFetchingMoreData = false;
      hasMoreData = false;
    }, (ExamPageResponseDataModel<FeaturedExamModel> data) {
      featuredExamModelList.addAll(data.examList);
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

  updateSateOnEnroll(int index) {
    _featuredExamModelList[index].isEnrolled = true;
    notifyListeners();
  }

  @override
  void dispose() {
    _searchQuery.close();
    super.dispose();
  }

  void resetState() {
    _featuredExamModelList = [];
    _isBusyLoading = false;
    _hasError = false;
    _hasMoreData = false;
    _isFetchingMoreData = false;
    _pageCount = 1;
    inSearchMode = false;
  }
}