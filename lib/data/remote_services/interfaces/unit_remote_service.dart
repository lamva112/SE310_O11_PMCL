import '../../data.dart';

abstract class IUnitRemoteService {
  Future<UnitResponse?> getUnitResponse();
}
