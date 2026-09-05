import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// Contract for reading and writing raw JSON data to local disk.
abstract class ILocalStorageDataSource {
  Future<Map<String, dynamic>?> readJsonObject(String fileName);
  Future<List<dynamic>?> readJsonList(String fileName);
  Future<void> writeJsonObject(String fileName, Map<String, dynamic> jsonMap);
  Future<void> writeJsonList(String fileName, List<dynamic> jsonList);
  Future<void> deleteFile(String fileName);
}

/// Simple, robust local file storage using atomic JSON file writes.
class LocalFileStorage implements ILocalStorageDataSource {
  final Directory? _overrideDirectory;

  LocalFileStorage({this._overrideDirectory});

  Future<Directory> _getBaseDirectory() async {
    final override = _overrideDirectory;
    if (override != null) {
      if (!await override.exists()) {
        await override.create(recursive: true);
      }
      return override;
    }
    return await getApplicationDocumentsDirectory();
  }

  Future<File> _getFile(String fileName) async {
    final dir = await _getBaseDirectory();
    return File('${dir.path}/$fileName');
  }

  @override
  Future<Map<String, dynamic>?> readJsonObject(String fileName) async {
    try {
      final file = await _getFile(fileName);
      if (!await file.exists()) return null;
      final content = await file.readAsString();
      if (content.trim().isEmpty) return null;
      return jsonDecode(content) as Map<String, dynamic>?;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<dynamic>?> readJsonList(String fileName) async {
    try {
      final file = await _getFile(fileName);
      if (!await file.exists()) return null;
      final content = await file.readAsString();
      if (content.trim().isEmpty) return null;
      return jsonDecode(content) as List<dynamic>?;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> writeJsonObject(String fileName, Map<String, dynamic> jsonMap) async {
    final file = await _getFile(fileName);
    final tempFile = File('${file.path}.tmp');
    final jsonString = const JsonEncoder.withIndent('  ').convert(jsonMap);

    await tempFile.writeAsString(jsonString, flush: true);
    if (await file.exists()) {
      await file.delete();
    }
    await tempFile.rename(file.path);
  }

  @override
  Future<void> writeJsonList(String fileName, List<dynamic> jsonList) async {
    final file = await _getFile(fileName);
    final tempFile = File('${file.path}.tmp');
    final jsonString = const JsonEncoder.withIndent('  ').convert(jsonList);

    await tempFile.writeAsString(jsonString, flush: true);
    if (await file.exists()) {
      await file.delete();
    }
    await tempFile.rename(file.path);
  }

  @override
  Future<void> deleteFile(String fileName) async {
    try {
      final file = await _getFile(fileName);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (_) {}
  }
}
