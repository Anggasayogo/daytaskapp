import 'package:bloc/bloc.dart';
import 'package:daytaskapp/data/models/priority_model.dart';
import 'package:daytaskapp/data/repo/tasklist/priority_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:daytaskapp/utils/exceptions/exceptions.dart';

part 'priority_event.dart';
part 'priority_state.dart';

class PriorityBloc extends Bloc<PriorityEvent, PriorityState> {
  final PriorityRepo priorityRepo;

  // Constructor menerima PriorityRepo
  PriorityBloc({required this.priorityRepo}) : super(PriorityInitialState()) {
    on<PriorityFetchEvent>(_onFetchPriorities);
  }

  // Handler untuk PriorityFetchEvent
  Future<void> _onFetchPriorities(
      PriorityFetchEvent event, Emitter<PriorityState> emit) async {
      emit(PriorityLoadingState());

    try {
      // Panggil API untuk mendapatkan data Prioritas
      final priorityResponse = await priorityRepo.fetchPriorities();
      print("✅ ${priorityResponse.status}");

      if (priorityResponse.status) {
        print("Data Prioritas: ${priorityResponse.data}");
        emit(PrioritySuccessState(priorityResponse.data));
      } else {
        emit(PriorityErrorState(
            "Failed to fetch priorities: ${priorityResponse.message}")); // Jika fetch gagal
      }
    } on RepoException catch (e) {
      emit(PriorityErrorState("Repository error: ${e.message}")); // Jika ada error dari repository
    } catch (e) {
      emit(PriorityErrorState("An unexpected error occurred: $e")); // Menangani error lainnya
    }
  }
}
