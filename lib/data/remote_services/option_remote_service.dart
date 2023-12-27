import 'dart:convert';

import 'package:get_it/get_it.dart';
import '../../core/core.dart';
import '../data.dart';

class OptionRemoteService extends IOptionRemoteService {
  late final INetworkUtility _networkUtility;
  OptionRemoteService()
      : _networkUtility = GetIt.I.get<INetworkUtility>(
            instanceName: NetworkConstant.authorizationDomain);
  @override
  Future<List<Options>?> getSingleOption(List<String> idList) async {
    List<Options>? list = [];

    for (String id in idList) {
      try {
        final response = await _networkUtility.request(
            'http://localhost:5111/api/Option/$id', Method.GET);

        if (response.statusCode == 200) {
          Map<String, dynamic> data =
              json.decode(response.data) as Map<String, dynamic>;
          list.add(Options.fromJson(data));
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
