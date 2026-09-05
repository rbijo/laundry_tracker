import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_tracker/data/datasources/local_file_storage.dart';

void main() {
  group('LocalFileStorage Tests', () {
    late Directory tempDir;
    late LocalFileStorage storage;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('laundry_tracker_test_');
      storage = LocalFileStorage(overrideDirectory: tempDir);
    });

    tearDown(() async {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('Reads null for non-existent file', () async {
      final resObj = await storage.readJsonObject('none.json');
      final resList = await storage.readJsonList('none.json');
      expect(resObj, isNull);
      expect(resList, isNull);
    });

    test('Writes and reads JSON object atomically', () async {
      final map = {'theme': 'dark', 'limit': 5};
      await storage.writeJsonObject('settings_test.json', map);

      final read = await storage.readJsonObject('settings_test.json');
      expect(read, map);
    });

    test('Writes and reads JSON list atomically', () async {
      final list = [
        {'id': '1', 'name': 'wash-1'},
        {'id': '2', 'name': 'wash-2'},
      ];
      await storage.writeJsonList('washes_test.json', list);

      final read = await storage.readJsonList('washes_test.json');
      expect(read, list);
    });

    test('Deletes file successfully', () async {
      await storage.writeJsonObject('to_delete.json', {'key': 'value'});
      expect(await storage.readJsonObject('to_delete.json'), isNotNull);

      await storage.deleteFile('to_delete.json');
      expect(await storage.readJsonObject('to_delete.json'), isNull);
    });
  });
}
