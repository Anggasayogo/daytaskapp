part of 'report_bloc.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object?> get props => [];
}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ReportSuccess extends ReportState {
  final String filePath;

  const ReportSuccess(this.filePath);

  @override
  List<Object?> get props => [filePath];
}

class ReportFailure extends ReportState {
  final String errorMessage;

  const ReportFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
