import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/data/saved_place_store.dart';
import 'package:hayer_app/data/saved_places_repository.dart';
import 'package:hayer_app/domain/saved_place.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  group('SavedPlacesRepository', () {
    test(
      'deduplicates by place identity and preserves the first save time',
      () async {
        var now = DateTime.utc(2026, 9, 8, 10);
        final store = _MemorySavedPlaceStore();
        final repository = SavedPlacesRepository(store: store, now: () => now);

        await repository.save(_place('place-1', name: 'Original'));
        now = now.add(const Duration(hours: 1));
        final places = await repository.save(
          _place('place-1', name: 'Refreshed'),
          collection: SavedPlaceCollection.favorites,
        );

        expect(places, hasLength(1));
        expect(places.single.place.name, 'Refreshed');
        expect(places.single.collection, SavedPlaceCollection.favorites);
        expect(places.single.savedAt, DateTime.utc(2026, 9, 8, 10));
        expect(places.single.updatedAt, DateTime.utc(2026, 9, 8, 11));
      },
    );

    test('keeps notes local, trims them, and removes empty notes', () async {
      final store = _MemorySavedPlaceStore();
      final repository = SavedPlacesRepository(
        store: store,
        now: () => DateTime.utc(2026, 9, 8),
      );
      await repository.save(_place('place-1'));

      var places = await repository.update(
        placeId: 'place-1',
        collection: SavedPlaceCollection.favorites,
        note: '  Order the saffron cake  ',
      );
      expect(places.single.note, 'Order the saffron cake');
      expect(places.single.collection, SavedPlaceCollection.favorites);

      places = await repository.update(
        placeId: 'place-1',
        collection: SavedPlaceCollection.wantToTry,
        note: '   ',
      );
      expect(places.single.note, isNull);
    });

    test('serializes concurrent saves without losing either place', () async {
      final store = _MemorySavedPlaceStore(
        delay: const Duration(milliseconds: 1),
      );
      final repository = SavedPlacesRepository(store: store);

      final results = await Future.wait([
        repository.save(_place('place-1')),
        repository.save(_place('place-2')),
      ]);

      expect(results.last.map((saved) => saved.place.placeId), {
        'place-1',
        'place-2',
      });
    });

    test('rejects notes over the private local limit', () async {
      final repository = SavedPlacesRepository(store: _MemorySavedPlaceStore());
      await repository.save(_place('place-1'));

      await expectLater(
        repository.update(
          placeId: 'place-1',
          collection: SavedPlaceCollection.wantToTry,
          note: List.filled(501, 'x').join(),
        ),
        throwsArgumentError,
      );
    });
  });

  group('SecureSavedPlaceStore', () {
    test(
      'round trips the local snapshot, collection, and private note',
      () async {
        final storage = _MemorySecureStorage();
        final store = SecureSavedPlaceStore(storage: storage);
        final saved = SavedPlace(
          place: _place('place-1'),
          collection: SavedPlaceCollection.favorites,
          note: 'Window seat',
          savedAt: DateTime.utc(2026, 9, 8),
          updatedAt: DateTime.utc(2026, 9, 8, 1),
        );

        await store.write([saved]);
        final restored = await store.read();

        expect(restored.single.place.placeId, 'place-1');
        expect(restored.single.collection, SavedPlaceCollection.favorites);
        expect(restored.single.note, 'Window seat');
        expect(storage.values.keys, [SecureSavedPlaceStore.storageKey]);
      },
    );

    test('clears malformed local data instead of crashing the app', () async {
      final storage = _MemorySecureStorage()
        ..values[SecureSavedPlaceStore.storageKey] = '{broken';
      final store = SecureSavedPlaceStore(storage: storage);

      expect(await store.read(), isEmpty);
      expect(storage.values, isEmpty);
    });
  });
}

PlaceSnapshot _place(String id, {String? name}) => PlaceSnapshot(
  placeId: id,
  name: name ?? 'Place $id',
  primaryType: 'Cafe',
  categoryIds: const ['cafe'],
  rating: 4.5,
  reviewCount: 100,
  hours: const [],
  distanceMeters: 500,
  latitude: 24.7136,
  longitude: 46.6753,
  photoUrls: const [],
  attributions: const ['Google Maps'],
  sourceCheckedAt: DateTime.utc(2026, 9, 8),
  isStale: false,
);

final class _MemorySavedPlaceStore implements SavedPlaceStore {
  _MemorySavedPlaceStore({this.delay = Duration.zero});

  final Duration delay;
  List<SavedPlace> places = [];

  @override
  Future<List<SavedPlace>> read() async {
    await Future<void>.delayed(delay);
    return [...places];
  }

  @override
  Future<void> write(List<SavedPlace> places) async {
    await Future<void>.delayed(delay);
    this.places = [...places];
  }

  @override
  Future<void> close() async {}
}

final class _MemorySecureStorage extends FlutterSecureStorage {
  _MemorySecureStorage();

  final values = <String, String>{};

  @override
  Future<String?> read({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async => values[key];

  @override
  Future<void> write({
    required String key,
    required String? value,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    if (value == null) {
      values.remove(key);
    } else {
      values[key] = value;
    }
  }

  @override
  Future<void> delete({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    values.remove(key);
  }
}
