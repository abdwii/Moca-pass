


import 'dart:convert';
import 'dart:developer';

import 'package:alafein/core/local_data/session_management.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


import 'package:alafein/features/auth/login/model/gsso_model.dart';

class GSSORepo{

  // POST
  // getting google auth response

  static Future<GSSOResponse?> fetchGoogleResponse(    
    String accessToken ,
    String notificationToken,
    )async {

    var client = http.Client();

    final msg = jsonEncode(
      {
        "accessToken": accessToken,
        "device": {
          "notificationToken": notificationToken
        }
      }
    );

    try{
      var response = await client.post(
        Uri.parse('https://alafein.azurewebsites.net/api/v1/User/GoogleAuth'),
         headers: {
          'Content-Type': 'application/json-patch+json; charset=UTF-8',
          },
          body: msg
      );
      Map<String, dynamic> result = jsonDecode(response.body);
      debugPrint(result.toString());
      GSSOResponse gssoResponse = GSSOResponse.fromJson(result);
      SessionManagement.createSession(token: gssoResponse.data.jwtToken, role: gssoResponse.data.role);
      return gssoResponse;
    }
    catch (e){
      log(e.toString());
      return null;
    }
  }
}