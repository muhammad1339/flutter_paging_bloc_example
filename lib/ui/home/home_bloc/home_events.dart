import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/src/core/paging_controller.dart';
import 'package:untitled_flutter/data/model/get_answers_response.dart';

class GetAnswersEvent extends Equatable {
  const GetAnswersEvent();

  @override
  List<Object> get props => [];
}

class SearchAnswerEvent extends GetAnswersEvent {
  const SearchAnswerEvent(this.query, PagingController<int, Item> pagingController);

  final String query;

  @override
  List<Object> get props => [query];
}
