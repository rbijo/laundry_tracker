import '../../core/constants/app_constants.dart';
import '../../domain/models/wash_item.dart';
import '../../domain/models/wash_status.dart';
import '../../domain/repositories/i_wash_repository.dart';
import '../datasources/local_file_storage.dart';

/// Implementation of IWashRepository using local JSON file persistence.
class WashRepositoryImpl implements IWashRepository {
  final ILocalStorageDataSource _storage;

  WashRepositoryImpl({ILocalStorageDataSource? storage})
      : _storage = storage ?? LocalFileStorage();

  @override
  Future<List<WashItem>> getAllWashes() async {
    final list = await _storage.readJsonList(AppConstants.washesFileName);
    if (list == null) return [];
    return list
        .map((item) => WashItem.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<WashItem>> getActiveWashes() async {
    final all = await getAllWashes();
    return all.where((w) => w.status == WashStatus.inProgress).toList();
  }

  @override
  Future<List<WashItem>> getCompletedWashes() async {
    final all = await getAllWashes();
    return all.where((w) => w.status == WashStatus.completed).toList();
  }

  @override
  Future<WashItem?> getWashById(String id) async {
    final all = await getAllWashes();
    final index = all.indexWhere((w) => w.id == id);
    if (index == -1) return null;
    return all[index];
  }

  @override
  Future<void> saveWash(WashItem wash) async {
    final all = await getAllWashes();
    final index = all.indexWhere((w) => w.id == wash.id);
    if (index >= 0) {
      all[index] = wash;
    } else {
      all.add(wash);
    }
    await _storage.writeJsonList(
      AppConstants.washesFileName,
      all.map((w) => w.toJson()).toList(),
    );
  }

  @override
  Future<void> deleteWash(String id) async {
    final all = await getAllWashes();
    all.removeWhere((w) => w.id == id);
    await _storage.writeJsonList(
      AppConstants.washesFileName,
      all.map((w) => w.toJson()).toList(),
    );
  }

  @override
  Future<void> clearAllWashes() async {
    await _storage.deleteFile(AppConstants.washesFileName);
  }
}
