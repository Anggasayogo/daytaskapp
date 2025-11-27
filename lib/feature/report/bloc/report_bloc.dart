import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:daytaskapp/data/repo/tasklist/task_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final TaskRepo taskRepo;

  ReportBloc({required this.taskRepo}) : super(ReportInitial()) {
    on<DownloadReportEvent>(_onDownloadReport);
  }

  Future<void> _onDownloadReport(
    DownloadReportEvent event,
    Emitter<ReportState> emit,
  ) async {
    emit(ReportLoading());

    try {
      // Simulasi download report
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/report_${event.id}.pdf';

      await taskRepo.downloadReport(
        id: event.id,
        start: event.start,
        end: event.end,
      );

      emit(ReportSuccess(filePath));
    } catch (e) {
      emit(ReportFailure('Failed to download report: ${e.toString()}'));
    }
  }
}
