


import 'dart:async';

import 'package:alafein/features/auth/login/application/repo/gsso_repo.dart';
import 'package:alafein/features/auth/login/model/gsso_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'gsso_event.dart';
part 'gsso_state.dart';

class GSSOBloc extends Bloc<GSSOEvent, GSSOState> {
   GSSOBloc()
     : super( GSSOInitialState()) {
    on<GSSOInitialEvent>(gSSOInitialFetchEvent);

  }


  FutureOr<void> gSSOInitialFetchEvent(
    GSSOInitialEvent event, Emitter<GSSOState> emit) async{
    emit(GSSOLoadingState());
    GSSOResponse? response = await GSSORepo.fetchGoogleResponse(
      event.accessToken,
      event.notificationToken
      );
    emit(GSSOSuccessState(gSSOResponse:response));
    if(response?.succeeded==false){
      emit(GSSOErrorState(error: response?.errors.toString()));
    }
  }
}