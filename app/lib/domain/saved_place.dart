import 'package:hayer_client/hayer_client.dart';

enum SavedPlaceCollection { wantToTry, favorites }

final class SavedPlace {
  const SavedPlace({
    required this.place,
    required this.collection,
    required this.savedAt,
    required this.updatedAt,
    this.note,
  });

  factory SavedPlace.fromJson(Map<String, Object?> json) => SavedPlace(
    place: PlaceSnapshot.fromJson(
      (json['place']! as Map).cast<String, dynamic>(),
    ),
    collection: SavedPlaceCollection.values.byName(
      json['collection']! as String,
    ),
    note: json['note'] as String?,
    savedAt: DateTime.parse(json['savedAt']! as String).toUtc(),
    updatedAt: DateTime.parse(json['updatedAt']! as String).toUtc(),
  );

  final PlaceSnapshot place;
  final SavedPlaceCollection collection;
  final String? note;
  final DateTime savedAt;
  final DateTime updatedAt;

  SavedPlace copyWith({
    PlaceSnapshot? place,
    SavedPlaceCollection? collection,
    Object? note = _unchanged,
    DateTime? savedAt,
    DateTime? updatedAt,
  }) => SavedPlace(
    place: place ?? this.place,
    collection: collection ?? this.collection,
    note: identical(note, _unchanged) ? this.note : note as String?,
    savedAt: savedAt ?? this.savedAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  Map<String, Object?> toJson() => {
    'place': place.toJson(),
    'collection': collection.name,
    if (note != null) 'note': note,
    'savedAt': savedAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}

const _unchanged = Object();
