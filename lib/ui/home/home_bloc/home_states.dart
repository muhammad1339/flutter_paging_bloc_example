import 'package:equatable/equatable.dart';
import '../../../data/data.dart';

class GetAnswerState extends Equatable {
  const GetAnswerState();

  @override
  List<Object> get props => [];
}

class GetAnswerStateInitial extends GetAnswerState {}

class GetAnswerStateLoading extends GetAnswerState {}

class GetAnswerStateSuccess extends GetAnswerState {
  // const GetAnswerStateSuccess(this.getAnswersResponse);

  // final GetAnswersResponse getAnswersResponse;

  // @override
  // List<Object> get props => [getAnswersResponse];
}

class GetAnswerStateError extends GetAnswerState {
  const GetAnswerStateError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
