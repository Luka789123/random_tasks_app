part of 'activity_bloc.dart';

abstract class ActivityState extends Equatable {
  const ActivityState();

  @override
  List<Object> get props => [];
}

class ActivityInitial extends ActivityState {}

class LoadingState extends ActivityState {}

class LoadedState extends ActivityState {
  final Activity activity;
  const LoadedState({required this.activity});
}

class ErrorState extends ActivityState {
  final String? message;
  final Failures? faliure;
  const ErrorState({this.faliure, this.message});
}
