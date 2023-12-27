import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:se310_o11_pmcl/data/remote_services/interfaces/unit_remote_service.dart';
import 'package:se310_o11_pmcl/data/responses/unit_response.dart';

import '../../core/core.dart';
import '../models/unit_model.dart';

class UnitRemoteService implements IUnitRemoteService {
  late final INetworkUtility _networkUtility;

  UnitRemoteService()
      : _networkUtility = GetIt.I.get<INetworkUtility>(
            instanceName: NetworkConstant.authorizationDomain);

  var data = {
    "units": [
      // {
      //   "id": "6453772d7029627e8fd9dcac1",
      //   "name": "Daily",
      //   "image":
      //       "https://99designs-blog.imgix.net/blog/wp-content/uploads/2018/05/Daily-Routine-1.jpg?auto=format&q=60&w=1860&h=1395&fit=crop&crop=faces"
      // },
      {
        "id": "6453772d7029627e8fd9dcac2",
        "name": "environment",
        "image":
            "https://www.euroschoolindia.com/blogs/wp-content/uploads/2023/06/environment-day.jpg"
      },
      {
        "id": "6453772d7029627e8fd9dcac3",
        "name": "Technology",
        "image":
            "https://transcosmos.co.uk/wp-content/uploads/2015/10/technology-customer-support1.jpg"
      },
      {
        "id": "6453772d7029627e8fd9dcac4",
        "name": "Heath",
        "image":
            "https://img.freepik.com/free-photo/medical-banner-with-stethoscope_23-2149611199.jpg"
      },
      {
        "id": "6453772d7029627e8fd9dcac5",
        "name": "Education",
        "image":
            "https://www.timeshighereducation.com/student/sites/default/files/istock-499343530.jpg"
      },
      // {
      //   {
      //     "id": "6453772d7029627e8fd9dcac6",
      //     "name": "Travel",
      //     "image":
      //         "https://lp-cms-production.imgix.net/2019-06/ab4a79b04c7c96508ea77aec7073e7d3-ho-chi-minh-city.jpg"
      //   }
      // }
    ]
  };

  @override
  Future<UnitResponse?> getUnitResponse() async {
    List<Unit> units = [];
    try {
      final response = await _networkUtility.request(
          'http://localhost:51111/api/Unit', Method.GET);

      print("responne ${response}");

      if (response.statusCode == 200) {
        print("no nhu nay ne ${response.data}");
        //data = json.decode(response.data) as Map<String, dynamic>;
        units = (json.decode(response.data) as List)
            .map((data) => Unit.fromJson(data))
            .toList();

        print(units.length);
      } else {
        print(response.statusCode);
        print("thử lại đi nha");
      }
    } catch (error) {
      // An error occurred, handle the exception
      print('Error: $error');
    }

    UnitResponse response = UnitResponse();

    return response.copyWith(unit: units);
  }
}
