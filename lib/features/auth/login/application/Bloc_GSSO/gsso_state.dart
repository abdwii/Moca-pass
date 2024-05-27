part of 'gsso_bloc.dart';

@immutable
abstract class GSSOState {}

abstract class GSSOActionState extends GSSOState{}

class GSSOInitialState extends GSSOState{}

class GSSOLoadingState extends GSSOState {}

class GSSOErrorState extends GSSOState {

  final String? error;
  GSSOErrorState({
    required this.error,
  });
}

class  GSSOSuccessState extends GSSOState{


  // 
  final GSSOResponse? gSSOResponse;
  GSSOSuccessState({
    required this.gSSOResponse,
  });
}