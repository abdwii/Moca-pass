import 'package:MocaPass/features/auth/login/model/login_pojo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../core/api/api_caller.dart';
import '../../../../../core/api/constants/api_caller_config.dart';
import '../../../../../core/api/constants/endpoints.dart';
import '../../../../../core/api/constants/methods.dart';
import '../../../../../core/local_data/session_management.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
   String email;
   String password;

   LoginCubit(this.email, this.password) : super(LoginStateInitial());

  final APICaller _apiCaller = APICaller(APICallerConfiguration.baseDebugUrl);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> signIn() async {
    EasyLoading.show();
    final call = await _apiCaller.call(
      endpoint: Endpoints.login,
      method: APIMethods.post,
      data: {
        'email': email,
        'password': password,
      },
    );
    call.fold(
      (failure) {
        EasyLoading.showError(failure.toString());
        emit(LoginStateError(message: "Error !"));
      },
      (response) {
        if (response.succeeded == true) {
          LoginPojo loginModel = LoginPojo.fromJson(response.data);

          SessionManagement.createSession(
              token: loginModel.jwToken ?? "");
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

  bool isValidPassword(String password) {
    return password.isNotEmpty && password.length >= 8 ? true : false;
  }

  bool isValidEmail(String? email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if(email==null) {
      return this.email.isNotEmpty && emailRegex.hasMatch(this.email)
          ? true
          : false;
    } else {
      return email.isNotEmpty && emailRegex.hasMatch(email) ? true : false;
    }
  }

  bool isValidForm(String email,String password) {
    return isValidEmail(email) && isValidPassword(password);
  }
}
