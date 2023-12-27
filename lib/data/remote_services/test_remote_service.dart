import 'dart:convert';

import 'package:get_it/get_it.dart';

import '../../core/core.dart';
import '../data.dart';

class TestRemoteService implements ITestRemoteService {
  late final INetworkUtility _networkUtility;

  TestRemoteService()
      : _networkUtility = GetIt.I.get<INetworkUtility>(
            instanceName: NetworkConstant.authorizationDomain);

  @override
  Future<TestResponse?> getTestResponse() async {
    List<Test> tests = [];
    try {
      final response = await _networkUtility.request(
          'http://localhost:51111/api/Test', Method.GET);

      print("responne ${response}");

      if (response.statusCode == 200) {
        print("no nhu nay ne ${response.data}");
        //data = json.decode(response.data) as Map<String, dynamic>;
        tests = (json.decode(response.data) as List)
            .map((data) => Test.fromJson(data))
            .toList();
      } else {
        print(response.statusCode);
        print("thử lại đi nha");
      }
    } catch (error) {
      // An error occurred, handle the exception
      print('Error nay: $error');
    }
    TestResponse updatedResponse = TestResponse();

    return updatedResponse.copyWith(testList: tests);
  }
}
