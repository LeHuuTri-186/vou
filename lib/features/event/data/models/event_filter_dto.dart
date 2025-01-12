import '../../domain/entities/event_filter_model.dart';
import '../../domain/entities/sort_model.dart';

class EventFilterDto {
  final String searchName;
  final List<String> userStatusFilter;
  final List<String> statusFilter;
  final List<Sort> sorts;
  final int page;
  final int perPage;

  EventFilterDto({
    required this.searchName,
    required this.userStatusFilter,
    required this.statusFilter,
    required this.sorts,
    required this.page,
    required this.perPage,
  });

  // Factory to create from JSON
  factory EventFilterDto.fromJson(Map<String, dynamic> json) {
    return EventFilterDto(
      searchName: json['searchName'] as String,
      userStatusFilter: List<String>.from(json['userStatusFilter'] as List),
      statusFilter: List<String>.from(json['statusFilter'] as List),
      sorts: (json['sorts'] as List)
          .map((sort) => Sort.fromJson(sort as Map<String, dynamic>))
          .toList(),
      page: json['page'] as int,
      perPage: json['perPage'] as int,
    );
  }

  // Method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'searchName': searchName,
      'userStatusFilter': userStatusFilter,
      'statusFilter': statusFilter,
      'sorts': sorts.map((sort) => sort.toJson()).toList(),
      'page': page,
      'perPage': perPage,
    };
  }

  // Convert DTO to Domain Entity
  EventFilter toDomain() {
    return EventFilter(
      searchName: searchName,
      userStatusFilter: userStatusFilter,
      statusFilter: statusFilter,
      sorts: sorts,
      page: page,
      perPage: perPage,
    );
  }

  // Convert Domain Entity to DTO
  factory EventFilterDto.fromDomain(EventFilter filter) {
    return EventFilterDto(
      searchName: filter.searchName,
      userStatusFilter: filter.userStatusFilter,
      statusFilter: filter.statusFilter,
      sorts: filter.sorts,
      page: filter.page,
      perPage: filter.perPage,
    );
  }
}
