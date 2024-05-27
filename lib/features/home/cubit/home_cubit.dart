import 'package:alafein/core/api/constants/endpoints.dart';
import 'package:alafein/core/api/constants/methods.dart';
import 'package:alafein/features/home/model/home_response/home_response.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/api/api_caller.dart';
import '../../../core/local_data/session_management.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getData() async {
    emit(HomeLoading());
    final call = await APICaller.instance.call(
      endpoint: Endpoints.eventHome,
      method: APIMethods.get,
      options: Options(headers: {
        "Authorization": "Bearer ${SessionManagement.getUserToken()}"
      }),
    );

    call.fold(
      (l) => EasyLoading.showError(l),
      (response) {
        if (response.succeeded == true) {
          emit(HomeLoaded(HomeResponse.fromMap(response.data)));
          EasyLoading.dismiss();
        } else {
          if (SessionManagement.getUserRole() != "") {
            EasyLoading.showError(response.message ?? "Error !");
          } else {
            EasyLoading.showError("Logged in as Gust");
          }
          emit(HomeError());
        }
      },
    );
  }
}
