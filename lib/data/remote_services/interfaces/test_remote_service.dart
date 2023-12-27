import 'package:se310_o11_pmcl/data/responses/test_response.dart';

abstract class ITestRemoteService {
  Future<TestResponse?> getTestResponse();
}