part of 'scan_cubit.dart';

@immutable
sealed class ScanState {}

final class ScanInitial extends ScanState {}
final class ScanLoading extends ScanState {}
final class ScanLoaded extends ScanState {
  final bool isSuccess;

  ScanLoaded(this.isSuccess);
}
final class ScanError extends ScanState {
  final String? message;

  ScanError(this.message);
}
