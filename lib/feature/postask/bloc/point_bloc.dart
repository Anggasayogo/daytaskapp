import 'package:bloc/bloc.dart';
import 'package:daytaskapp/data/models/point_model.dart';
import 'package:daytaskapp/data/repo/tasklist/point_repo.dart';
import 'package:equatable/equatable.dart';

part 'point_event.dart';
part 'point_state.dart';

class PointBloc extends Bloc<PointEvent, PointState> {
  final PointRepo pointRepo;

  PointBloc({required this.pointRepo}) : super(PointInitialState()) {
    on<FetchPointsEvent>(_onFetchPoints);
  }

  Future<void> _onFetchPoints(
      FetchPointsEvent event, Emitter<PointState> emit) async {
    emit(PointLoadingState());

    try {
      final response = await pointRepo.fetchPointList();
      
      emit(PointLoadedState(response));
    } catch (e) {
      emit(PointErrorState('Failed to load points: $e'));
    }
  }
}
