import 'package:flutter/foundation.dart';
import '../domain/models/wash_item.dart';
import '../domain/models/wash_status.dart';
import '../domain/repositories/i_wash_repository.dart';

/// State controller managing active and completed washes and limit checking.
class WashController extends ChangeNotifier {
  final IWashRepository _repository;
  List<WashItem> _washes = [];
  bool _isLoading = false;

  WashController({required this._repository});

  List<WashItem> get allWashes => List.unmodifiable(_washes);
  bool get isLoading => _isLoading;

  /// Active in-progress washes.
  List<WashItem> get activeWashes =>
      _washes.where((w) => w.status == WashStatus.inProgress).toList();

  /// Completed washes.
  List<WashItem> get completedWashes =>
      _washes.where((w) => w.status == WashStatus.completed).toList();

  /// Number of active washes currently in progress.
  int get activeWashCount => activeWashes.length;

  /// Total count of completed washes.
  int get totalCompletedWashes => completedWashes.length;

  /// Count of completed washes that were successfully tracked (Received All).
  int get successfullyTrackedWashes =>
      completedWashes.where((w) => w.isSuccessfullyTracked).length;

  /// Determines whether a new wash can be created against the concurrent wash limit.
  bool canCreateWash(int concurrentWashLimit) {
    return activeWashCount < concurrentWashLimit;
  }

  Future<void> loadWashes() async {
    _isLoading = true;
    notifyListeners();
    _washes = await _repository.getAllWashes();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addWash(WashItem wash) async {
    await _repository.saveWash(wash);
    _washes.add(wash);
    notifyListeners();
  }

  Future<void> updateWash(WashItem wash) async {
    final index = _washes.indexWhere((w) => w.id == wash.id);
    if (index >= 0) {
      _washes[index] = wash;
      await _repository.saveWash(wash);
      notifyListeners();
    }
  }

  Future<void> removeWash(String id) async {
    _washes.removeWhere((w) => w.id == id);
    await _repository.deleteWash(id);
    notifyListeners();
  }

  Future<void> clearAll() async {
    _washes.clear();
    await _repository.clearAllWashes();
    notifyListeners();
  }
}
