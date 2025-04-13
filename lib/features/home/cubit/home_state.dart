part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  HomeLoaded(this.homeResponse);

  final HomeResponse homeResponse;
}

final class HomeError extends HomeState {}
