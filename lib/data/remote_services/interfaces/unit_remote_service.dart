
import '../../data.dart';

abstract class IUnitRemoteService {
  Future<UnitResponse?> getUnitResponse();
  Future<List<FavoriteUnit>?> getFavoriteUnit(String userId);
  Future<List<Unit>?> getSingleUnit(List<String> idList);
  Future<bool> deleteFavoriteUnit(String id);
}
