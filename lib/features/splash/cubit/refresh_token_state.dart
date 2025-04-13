part of 'refresh_token_cubit.dart';

@immutable
sealed class RefreshTokenState {}

final class RefreshTokenInitial extends RefreshTokenState {}

final class RefreshTokenLoading extends RefreshTokenState {}

final class RefreshTokenLoaded extends RefreshTokenState {}

final class RefreshTokenError extends RefreshTokenState {}
