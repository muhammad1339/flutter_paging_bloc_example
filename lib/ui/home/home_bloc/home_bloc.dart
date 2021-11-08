import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../data/data.dart';
import 'package:untitled_flutter/ui/home/home_bloc/home_events.dart';
import 'package:untitled_flutter/ui/home/home_bloc/home_states.dart';

class GetAnswersBloc extends Bloc<GetAnswersEvent, GetAnswerState> {
  GetAnswersBloc(this.remoteRepo) : super(GetAnswerStateInitial());

  final RemoteRepo remoteRepo;
  static const _pageSize = 15;

  // todo #1
  final PagingController<int, Item> pagingController =
      PagingController(firstPageKey: 1);

  Future<void> _fetchPage(int pageKey, SearchAnswerEvent event) async {
    try {
      var response = await remoteRepo.getStackAnswers(
          page: '$pageKey', pageSize: '$_pageSize', query: event.query);
      final newItems = GetAnswersResponse.fromJson(response.data!).items;
      print("1+++++++++++++++++++++++++++++++++++++++++++++++++++1");
      print(newItems.length);
      print(pageKey);
      print("1+++++++++++++++++++++++++++++++++++++++++++++++++++1");
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      print(error.toString());
      pagingController.error = error;
    }
  }

  @override
  Stream<GetAnswerState> mapEventToState(GetAnswersEvent event) async* {
    try {
      yield GetAnswerStateInitial();

      if (event is SearchAnswerEvent) {
        yield GetAnswerStateLoading();
        pagingController.addPageRequestListener((pageKey) {
          _fetchPage(pageKey, event);
        });
        // var response = await remoteRepo.getStackAnswers(
        //     page: '1', pageSize: '15', query: event.query);
        // print('>>><<<' + response.statusCode.toString());
        // if (response.statusCode == 200 && response.data != null) {
        //   GetAnswersResponse getAnswersResponse =
              // GetAnswersResponse.fromJson(response.data!);
          // yield GetAnswerStateSuccess(getAnswersResponse);
          yield GetAnswerStateSuccess();
        // } else {
        //   yield GetAnswerStateError('err');
        // }
      }
    } catch (e) {
      if (e is DioError) {
        yield GetAnswerStateError(
            '${e.response!.statusCode} -> ${e.response!.statusMessage} -> ${e.response!.data}');
      } else {
        yield GetAnswerStateError("unknown error");
      }
    }
  }
}
