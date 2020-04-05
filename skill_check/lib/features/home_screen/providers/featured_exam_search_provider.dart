import 'package:skill_check/features/featured_exam_screen/models/featured_exam_model.dart';
import 'package:skill_check/features/home_screen/repositories/fetured_exam_search_repository.dart';
import 'package:skill_check/main_app/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class FeaturedExamSearchProvider with ChangeNotifier {
  List<FeaturedExamModel> _featuredExamList;
  bool _isSearching = false;
  bool _hasError = false;

  final _searchQuery = BehaviorSubject<String>();

  Function(String) get changeQuery => _searchQuery.sink.add;

  Stream<String> get searchQuery => _searchQuery.stream;

  listenStream() {
    _searchQuery
        .debounceTime(Duration(milliseconds: 500))
        .listen((query) async {
      if (query != "" && query != null) {
        getSearchData(query);
        print("Qery: $query");
      }
    });
  }

  List<FeaturedExamModel> get featuredExamList => _featuredExamList;

  set featuredExamList(List<FeaturedExamModel> value) {
    _featuredExamList = value;
    notifyListeners();
  }

  bool get isSearching => _isSearching;

  set isSearching(bool value) {
    if (_isSearching != value) {
      _isSearching = value;
      notifyListeners();
    }
  }

  bool get hasError => _hasError;

  set hasError(bool value) {
    if (_hasError != value) {
      _hasError = value;
      notifyListeners();
    }
  }

  getSearchData(String queryText) async {
    print("Qery: $queryText");
    hasError = false;
    isSearching = true;
    Either<Failure, List<FeaturedExamModel>> result =
        await FeaturedExamSearchRepository().queryForFeaturedExam(queryText);

    result.fold((_) {
      hasError = true;
      isSearching = false;
      print("error");
      featuredExamList = <FeaturedExamModel>[];
    }, (list) {
      isSearching = false;
      isSearching = false;
      featuredExamList = list;
    });
  }

  resetState() {
    featuredExamList = null;
    changeQuery("");
    isSearching = false;
    hasError = false;
  }

  @override
  void dispose() {
    _searchQuery.close();
    super.dispose();
  }
}
