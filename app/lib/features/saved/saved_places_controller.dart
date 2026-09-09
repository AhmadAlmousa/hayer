import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayer_client/hayer_client.dart';

import '../../core/providers.dart';
import '../../domain/saved_place.dart';

final savedPlacesControllerProvider =
    NotifierProvider<SavedPlacesController, SavedPlacesState>(
      SavedPlacesController.new,
    );

final class SavedPlacesState {
  const SavedPlacesState({
    this.places = const [],
    this.loading = false,
    this.savingPlaceIds = const {},
    this.error,
  });

  final List<SavedPlace> places;
  final bool loading;
  final Set<String> savingPlaceIds;
  final Object? error;

  bool contains(String placeId) =>
      places.any((saved) => saved.place.placeId == placeId);

  SavedPlace? find(String placeId) =>
      places.where((saved) => saved.place.placeId == placeId).firstOrNull;

  SavedPlacesState copyWith({
    List<SavedPlace>? places,
    bool? loading,
    Set<String>? savingPlaceIds,
    Object? error = _unchanged,
  }) => SavedPlacesState(
    places: places ?? this.places,
    loading: loading ?? this.loading,
    savingPlaceIds: savingPlaceIds ?? this.savingPlaceIds,
    error: identical(error, _unchanged) ? this.error : error,
  );
}

class SavedPlacesController extends Notifier<SavedPlacesState> {
  @override
  SavedPlacesState build() {
    unawaited(Future<void>.microtask(reload));
    return const SavedPlacesState(loading: true);
  }

  Future<void> reload() async {
    state = state.copyWith(loading: true, error: null);
    try {
      final places = await ref.read(savedPlacesRepositoryProvider).load();
      state = state.copyWith(places: places, loading: false, error: null);
    } catch (error) {
      state = state.copyWith(loading: false, error: error);
    }
  }

  Future<bool> toggle(PlaceSnapshot place) async {
    final placeId = place.placeId;
    if (state.savingPlaceIds.contains(placeId)) return state.contains(placeId);
    _markSaving(placeId, true);
    try {
      final repository = ref.read(savedPlacesRepositoryProvider);
      final wasSaved = state.contains(placeId);
      final places = wasSaved
          ? await repository.remove(placeId)
          : await repository.save(place);
      state = state.copyWith(places: places, error: null);
      return !wasSaved;
    } catch (error) {
      state = state.copyWith(error: error);
      rethrow;
    } finally {
      _markSaving(placeId, false);
    }
  }

  Future<void> update({
    required String placeId,
    required SavedPlaceCollection collection,
    String? note,
  }) async {
    _markSaving(placeId, true);
    try {
      final places = await ref
          .read(savedPlacesRepositoryProvider)
          .update(placeId: placeId, collection: collection, note: note);
      state = state.copyWith(places: places, error: null);
    } catch (error) {
      state = state.copyWith(error: error);
      rethrow;
    } finally {
      _markSaving(placeId, false);
    }
  }

  Future<void> remove(String placeId) async {
    _markSaving(placeId, true);
    try {
      final places = await ref
          .read(savedPlacesRepositoryProvider)
          .remove(placeId);
      state = state.copyWith(places: places, error: null);
    } catch (error) {
      state = state.copyWith(error: error);
      rethrow;
    } finally {
      _markSaving(placeId, false);
    }
  }

  void _markSaving(String placeId, bool saving) {
    final ids = {...state.savingPlaceIds};
    if (saving) {
      ids.add(placeId);
    } else {
      ids.remove(placeId);
    }
    state = state.copyWith(savingPlaceIds: ids);
  }
}

const _unchanged = Object();
