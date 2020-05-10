import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:p7app/features/job/models/sort_item.dart';
class JobListSortItemRepository{
  List<SortItem> getList(){

    return [
      SortItem(key: "",value:"None"),
      SortItem(key: "top-rated",value: "Top Rated"),
      SortItem(key: "most-applied",value: "Most applied"),
    ];
  }
}
