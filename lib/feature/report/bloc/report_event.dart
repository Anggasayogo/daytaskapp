part of 'report_bloc.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object?> get props => [];
}

class DownloadReportEvent extends ReportEvent {
  final String id;
  final String? start;
  final String? end;

  const DownloadReportEvent({
    required this.id,
    this.start,
    this.end,
  });

  @override
  List<Object?> get props => [id, start, end];
}
