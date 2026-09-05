import '../../core/constants/app_constants.dart';
import '../../domain/models/issue_item.dart';
import '../../domain/repositories/i_issue_repository.dart';
import '../datasources/local_file_storage.dart';

/// Implementation of IIssueRepository using local JSON file persistence.
class IssueRepositoryImpl implements IIssueRepository {
  final ILocalStorageDataSource _storage;

  IssueRepositoryImpl({ILocalStorageDataSource? storage})
      : _storage = storage ?? LocalFileStorage();

  @override
  Future<List<IssueItem>> getAllIssues() async {
    final list = await _storage.readJsonList(AppConstants.issuesFileName);
    if (list == null) return [];
    return list
        .map((item) => IssueItem.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<IssueItem>> getIssuesForWash(String washId) async {
    final all = await getAllIssues();
    return all.where((issue) => issue.washId == washId).toList();
  }

  @override
  Future<void> saveIssue(IssueItem issue) async {
    final all = await getAllIssues();
    final index = all.indexWhere((i) => i.id == issue.id);
    if (index >= 0) {
      all[index] = issue;
    } else {
      all.add(issue);
    }
    await _storage.writeJsonList(
      AppConstants.issuesFileName,
      all.map((i) => i.toJson()).toList(),
    );
  }

  @override
  Future<void> deleteIssue(String id) async {
    final all = await getAllIssues();
    all.removeWhere((i) => i.id == id);
    await _storage.writeJsonList(
      AppConstants.issuesFileName,
      all.map((i) => i.toJson()).toList(),
    );
  }

  @override
  Future<void> clearAllIssues() async {
    await _storage.deleteFile(AppConstants.issuesFileName);
  }
}
