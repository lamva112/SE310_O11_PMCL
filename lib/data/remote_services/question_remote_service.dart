import 'dart:convert';

import 'package:get_it/get_it.dart';

import '../../core/core.dart';
import '../data.dart';

class QuestionRemoteService implements IQuestionRemoteService {
  late final INetworkUtility _networkUtility;
  QuestionRemoteService()
      : _networkUtility = GetIt.I.get<INetworkUtility>(
            instanceName: NetworkConstant.authorizationDomain);

  @override
  Future<List<Question>?> getSingleQuestion(List<String> idList) async {
    List<Question>? list = [];

    for (String id in idList) {
      try {
        final response = await _networkUtility.request(
            'http://localhost:51111/api/Question/$id', Method.GET);

        if (response.statusCode == 200) {
          Map<String, dynamic> data =
              json.decode(response.data) as Map<String, dynamic>;
          list.add(Question.fromJson(data));
        } else {
          print("question status code ${response.statusCode}");
        }
      } catch (e) {
        print('Error: $e');
      }
    }

    return list;
  }
}
