import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:get_it/get_it.dart';

import '../../core/core.dart';
import '../data.dart';

class AuthRemoteService extends IAuthRemoteService {
  late final INetworkUtility _networkUtility;
  AuthRemoteService()
      : _networkUtility = GetIt.I.get<INetworkUtility>(
            instanceName: NetworkConstant.authorizationDomain);

  @override
  Future<User?> signInWithEmail(String email, String password) async {
    Map<String, dynamic> user = {};

    try {
      final response = await _networkUtility.request(
          'http://localhost:5111/api/User/${email}/${password}', Method.GET);

      print("responne ${response}");

      if (response.statusCode == 200) {
        print("no nhu nay ne ${response.data}");
        user = json.decode(response.data) as Map<String, dynamic>;
        //user = response.data;
      } else {
        print(response.statusCode);
        print("thử lại đi nha");
      }
    } catch (error) {
      // An error occurred, handle the exception
      print('Error nay: $error');
    }
    return User.fromJson(user);
  }

  @override
  Future<bool?> signUpWithEmail(User user) async {
    final response = await _networkUtility.request(
      'http://localhost:5111/api/User',
      Method.POST,
      data: {
        'email': user.email,
        'passWord': user.passWord,
        'userName': user.userName,
        'dateOfBirth': user.dateOfBirth,
      },
      options: dio.Options(
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
        },
        contentType: dio.Headers.jsonContentType,
        responseType: dio.ResponseType.json,
      ),
    );

    Map<String, dynamic> data = {};

    if (response.statusCode == 200) {
      print(response.data);
      data = response.data;
      return true;
    } else {
      print(response.statusCode);
      print("thử lại đi nha");
    }

    return false;
  }
}
