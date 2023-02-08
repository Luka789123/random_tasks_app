import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:test_app/core/entity/activity.dart';
import 'package:test_app/core/faliure/faliure.dart';
import 'package:test_app/core/faliure/network_faliure.dart';
import 'package:test_app/core/faliure/server_faliure.dart';
import 'package:test_app/features/get_activity/data/repositroy/activity_repository.dart';

part 'activity_event.dart';
part 'activity_state.dart';

enum Failures { network, server }

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final ActivityRepository activityRepository;
  ActivityBloc({required this.activityRepository}) : super(ActivityInitial()) {
    on<ActivityEvent>((event, emit) async {
      if (event is GetActivitiesEvent) {
        emit(LoadingState());
        final result = await activityRepository.fetch();
        if (result is Activity) {
          emit(LoadedState(activity: result));
        } else if (result is Faliure) {
          print('faliure');
          switch (result.runtimeType) {
            case NetworkFaliure:
              emit(const ErrorState(
                  message: 'There is internet connection',
                  faliure: Failures.network));
              break;
            case ServerFaliure:
              emit(const ErrorState(
                  message: 'Something went wrong with servers',
                  faliure: Failures.server));
              break;
            default:
              emit(const ErrorState(
                  message: 'Something went wrong with servers',
                  faliure: Failures.server));
          }
        }
      }
    });
  }
}
