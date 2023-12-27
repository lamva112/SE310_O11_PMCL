import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart' as dio;

import '../../core/core.dart';
import '../data.dart';

class VocabularyRemoteService implements IVocabularyRemoteService {
  late final INetworkUtility _networkUtility;

  VocabularyRemoteService()
      : _networkUtility = GetIt.I.get<INetworkUtility>(
            instanceName: NetworkConstant.authorizationDomain);

  @override
  Future<UnitHasVocabularyResponse?> getUnitHasVocabularyResponse(
      String unitId) async {
    List<UnitHasVocabulary> unitHasVocal = [];
    try {
      final response = await _networkUtility.request(
          'http://localhost:5111/api/UnitHasVocabulary/$unitId', Method.GET);

      print("responne ${response}");

      if (response.statusCode == 200) {
        print("no nhu nay ne ${response.data}");
        //data = json.decode(response.data) as Map<String, dynamic>;
        unitHasVocal = (json.decode(response.data) as List)
            .map((data) => UnitHasVocabulary.fromJson(data))
            .toList();

        print(unitHasVocal.length);
      } else {
        print(response.statusCode);
        print("thử lại đi nha");
      }
    } catch (error) {
      // An error occurred, handle the exception
      print('Error: $error');
    }

    UnitHasVocabularyResponse response = UnitHasVocabularyResponse();

    return response.copyWith(unitHasVocabulary: unitHasVocal);
  }

  @override
  Future<List<Vocabulary>?> getSingleVocabulary(List<String> idList) async {
    List<Vocabulary> list = [];

    for (String id in idList) {
      try {
        final response = await _networkUtility.request(
            'http://localhost:5111/api/Vocabulary/$id', Method.GET);

        if (response.statusCode == 200) {
          Map<String, dynamic> data =
              json.decode(response.data) as Map<String, dynamic>;
          list.add(Vocabulary.fromJson(data));
        } else {
          print(response.statusCode);
        }
      } catch (e) {
        print('Error: $e');
      }
    }

    return list;
  }

  @override
  Future<bool?> addFavoriteUnit(String unitId, String userId) async {
    final response = await _networkUtility.request(
      'http://localhost:5111/api/FavoriteUnit',
      Method.POST,
      data: {
        "userId": userId,
        "unitId": unitId,
      },
      options: dio.Options(
        headers: {
          'Accept': '*/*',
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

  @override
  Future<List<FavoriteVocabulary>?> getFavoriteVocabulary(String userId) async {
    List<FavoriteVocabulary> fvoca = [];
    try {
      final response = await _networkUtility.request(
          'http://localhost:5111/api/FavoriteVocabulary/$userId', Method.GET);

      print("responne ${response}");

      if (response.statusCode == 200) {
        print("no nhu nay ne ${response.data}");
        //data = json.decode(response.data) as Map<String, dynamic>;
        fvoca = (json.decode(response.data) as List)
            .map((data) => FavoriteVocabulary.fromJson(data))
            .toList();
      } else {
        print(response.statusCode);
        print("thử lại đi nha");
      }
    } catch (error) {
      // An error occurred, handle the exception
      print('Error nay: $error');
    }
    return fvoca;
  }

  @override
  Future<bool> deleteFavoriteVocab(String id) async {
    try {
      // Make DELETE request
      final response = await _networkUtility.request(
          'http://localhost:5111/api/FavoriteVocabulary/$id', Method.DELETE);

      // Check the response
      if (response.statusCode == 200) {
        print('DELETE request successful');
        return true;
      } else {
        print('DELETE request failed with status: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('Error making DELETE request: $error');
      return false;
    }
  }
}
