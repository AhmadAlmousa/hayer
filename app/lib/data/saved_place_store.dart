import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../domain/saved_place.dart';

abstract interface class SavedPlaceStore {
  Future<List<SavedPlace>> read();

  Future<void> write(List<SavedPlace> places);

  Future<void> close();
}

final class SecureSavedPlaceStore implements SavedPlaceStore {
  SecureSavedPlaceStore({
    this.storage = const FlutterSecureStorage(),
  });

  static const storageKey = 'hayer.saved-places.v1';
  static const schemaVersion = 1;
  final FlutterSecureStorage storage;

  @override
  Future<List<SavedPlace>> read() async {
    final encoded = await storage.read(key: storageKey);
    if (encoded == null || encoded.isEmpty) return const [];
    try {
      final document = (jsonDecode(encoded) as Map).cast<String, Object?>();
      if (document['version'] != schemaVersion) {
        throw const FormatException('Unsupported saved-place schema.');
      }
      final values = document['places']! as List<Object?>;
      return [
        for (final value in values)
          SavedPlace.fromJson((value! as Map).cast<String, Object?>()),
      ];
    } on FormatException {
      await storage.delete(key: storageKey);
      return const [];
    } on TypeError {
      await storage.delete(key: storageKey);
      return const [];
    } on StateError {
      await storage.delete(key: storageKey);
      return const [];
    }
  }

  @override
  Future<void> write(List<SavedPlace> places) => places.isEmpty
      ? storage.delete(key: storageKey)
      : storage.write(
          key: storageKey,
          value: jsonEncode({
            'version': schemaVersion,
            'places': [for (final place in places) place.toJson()],
          }),
        );

  @override
  Future<void> close() async {}
}
