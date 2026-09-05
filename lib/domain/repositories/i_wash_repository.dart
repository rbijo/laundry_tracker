import '../models/wash_item.dart';

/// Contract for Wash repository data operations.
abstract class IWashRepository {
  Future<List<WashItem>> getAllWashes();
  Future<List<WashItem>> getActiveWashes();
  Future<List<WashItem>> getCompletedWashes();
  Future<WashItem?> getWashById(String id);
  Future<void> saveWash(WashItem wash);
  Future<void> deleteWash(String id);
  Future<void> clearAllWashes();
}
