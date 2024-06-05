import '../../../core/api/constants/api_caller_config.dart';
import '../../../core/api/constants/endpoints.dart';
import '../../../core/api/constants/methods.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/api/api_caller.dart';
import '../../../core/local_data/session_management.dart';
import '../model/home_response/home_response.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getData() async {
    emit(HomeLoading());
    // final call = await APICaller(APICallerConfiguration.baseUrl).call(
    //   endpoint: Endpoints.eventHome,
    //   method: APIMethods.get,
    //   options: Options(headers: {
    //     "Authorization": "Bearer ${SessionManagement.getUserToken()}"
    //   }),
    // );
    //
    // call.fold(
    //   (l) => EasyLoading.showError(l),
    //   (response) {
    //
    //   },
    // );
  }
}
