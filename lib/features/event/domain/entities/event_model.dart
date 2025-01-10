import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_model.freezed.dart';

@freezed
class EventModel with _$EventModel {
  const factory EventModel({
    required String id,
    required String name,
    required String description,
    required String image,
    required DateTime startDate,
    required DateTime endDate,
    required int turnsPerDay,
  }) = _EventModel;
}
