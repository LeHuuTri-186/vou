import 'package:vou/features/event/domain/entities/sort_model.dart';

class EventFilter {
  final String searchName;
  final List<Sort> sorts;
  final List<String> userStatusFilter;
  final List<String> statusFilter;
  final int page;
  final int perPage;

  EventFilter({
    required this.sorts,
    required this.searchName,
    required this.userStatusFilter,
    required this.statusFilter,
    required this.page,
    required this.perPage,
  });

  EventFilter copyWith({
    String? searchName,
    List<String>? userStatusFilter,
    List<String>? statusFilter,
    int? page,
    int? perPage,
    List<Sort>? sorts,
  }) =>
      EventFilter(
        searchName: searchName ?? this.searchName,
        userStatusFilter: userStatusFilter ?? this.userStatusFilter,
        statusFilter: statusFilter ?? this.statusFilter,
        page: page ?? this.page,
        perPage: perPage ?? this.perPage,
        sorts: sorts ?? this.sorts,
      );
}
