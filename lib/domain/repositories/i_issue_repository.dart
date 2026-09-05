import '../models/issue_item.dart';

/// Contract for Issue repository data operations.
abstract class IIssueRepository {
  Future<List<IssueItem>> getAllIssues();
  Future<List<IssueItem>> getIssuesForWash(String washId);
  Future<void> saveIssue(IssueItem issue);
  Future<void> deleteIssue(String id);
  Future<void> clearAllIssues();
}
