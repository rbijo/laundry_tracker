import 'package:flutter/foundation.dart';
import '../domain/models/issue_item.dart';
import '../domain/repositories/i_issue_repository.dart';

/// State controller managing discrepancy issue records.
class IssueController extends ChangeNotifier {
  final IIssueRepository _repository;
  List<IssueItem> _issues = [];
  bool _isLoading = false;

  IssueController({required this._repository});

  List<IssueItem> get allIssues => List.unmodifiable(_issues);
  bool get isLoading => _isLoading;
  int get totalIssues => _issues.length;

  Future<void> loadIssues() async {
    _isLoading = true;
    notifyListeners();
    _issues = await _repository.getAllIssues();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> recordIssue(IssueItem issue) async {
    await _repository.saveIssue(issue);
    _issues.add(issue);
    notifyListeners();
  }

  Future<void> removeIssue(String id) async {
    _issues.removeWhere((i) => i.id == id);
    await _repository.deleteIssue(id);
    notifyListeners();
  }

  Future<void> clearAll() async {
    _issues.clear();
    await _repository.clearAllIssues();
    notifyListeners();
  }
}
