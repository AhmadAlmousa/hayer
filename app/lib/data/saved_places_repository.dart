import 'dart:async';

import 'package:hayer_client/hayer_client.dart';

import '../domain/saved_place.dart';
import 'saved_place_store.dart';

final class SavedPlacesRepository {
  SavedPlacesRepository({
    required this.store,
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now;

  static const maximumPlaces = 100;
  static const maximumNoteLength = 500;

  final SavedPlaceStore store;
  final DateTime Function() _now;
  final _mutex = _AsyncMutex();

  Future<List<SavedPlace>> load() => _mutex.protect(() async {
    final places = await store.read();
    return _sorted(places);
  });

  Future<List<SavedPlace>> save(
    PlaceSnapshot place, {
    SavedPlaceCollection collection = SavedPlaceCollection.wantToTry,
  }) => _mutex.protect(() async {
    final places = await store.read();
    final index = places.indexWhere(
      (saved) => saved.place.placeId == place.placeId,
    );
    final timestamp = _now().toUtc();
    if (index < 0) {
      places.add(
        SavedPlace(
          place: place,
          collection: collection,
          savedAt: timestamp,
          updatedAt: timestamp,
        ),
      );
    } else {
      places[index] = places[index].copyWith(
        place: place,
        collection: collection,
        updatedAt: timestamp,
      );
    }
    final sorted = _sorted(places);
    if (sorted.length > maximumPlaces) {
      throw StateError('Saved-place limit reached.');
    }
    await store.write(sorted);
    return sorted;
  });

  Future<List<SavedPlace>> update({
    required String placeId,
    required SavedPlaceCollection collection,
    String? note,
  }) => _mutex.protect(() async {
    final places = await store.read();
    final index = places.indexWhere(
      (saved) => saved.place.placeId == placeId,
    );
    if (index < 0) throw StateError('Saved place not found.');
    final normalizedNote = _normalizeNote(note);
    places[index] = places[index].copyWith(
      collection: collection,
      note: normalizedNote,
      updatedAt: _now().toUtc(),
    );
    final sorted = _sorted(places);
    await store.write(sorted);
    return sorted;
  });

  Future<List<SavedPlace>> remove(String placeId) => _mutex.protect(() async {
    final places = await store.read()
      ..removeWhere((saved) => saved.place.placeId == placeId);
    final sorted = _sorted(places);
    await store.write(sorted);
    return sorted;
  });

  String? _normalizeNote(String? note) {
    final normalized = note?.trim();
    if (normalized == null || normalized.isEmpty) return null;
    if (normalized.length > maximumNoteLength) {
      throw ArgumentError.value(note, 'note', 'Note is too long.');
    }
    return normalized;
  }

  List<SavedPlace> _sorted(Iterable<SavedPlace> places) {
    final sorted = places.toList()
      ..sort((left, right) => right.updatedAt.compareTo(left.updatedAt));
    return List.unmodifiable(sorted);
  }
}

final class _AsyncMutex {
  Future<void> _tail = Future.value();

  Future<T> protect<T>(Future<T> Function() action) {
    final completer = Completer<T>();
    _tail = _tail.then((_) async {
      try {
        completer.complete(await action());
      } catch (error, stackTrace) {
        completer.completeError(error, stackTrace);
      }
    });
    return completer.future;
  }
}
