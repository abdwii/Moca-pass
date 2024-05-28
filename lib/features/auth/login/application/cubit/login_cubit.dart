import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../core/api/api_caller.dart';
import '../../../../../core/api/constants/endpoints.dart';
import '../../../../../core/api/constants/methods.dart';
import '../../../../../core/local_data/session_management.dart';
import '../../model/login_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  late String email;
  late String password;

  LoginCubit() : super(LoginStateInitial());
  final APICaller _apiCaller = APICaller.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> signIn() async {
    EasyLoading.show();
    final call = await _apiCaller.call(
      endpoint: Endpoints.login,
      method: APIMethods.post,
      data: {
        'email': email,
        'password': password,
        'device':{
          'notificationToken':SessionManagement.getNotificationToken()
        }
      },
    );
    call.fold(
      (failure) {
          EasyLoading.showError(failure.toString());

        emit(LoginStateError(message: "Error !"));

      },
      (response) {
        if (response.succeeded == true) {
          LoginModel loginModel = LoginModel.fromMap(response.data);
          SessionManagement.createSession(token: loginModel.jwtToken ?? "", role: loginModel.role ?? "");
          EasyLoading.dismiss();
          emit(LoginStateLoaded());
        } else {
            EasyLoading.showError(response.message ?? "Error !");
          emit(LoginStateError(message: response.message ?? "Error !"));
        }
      },
    );
    // }
  }
}
