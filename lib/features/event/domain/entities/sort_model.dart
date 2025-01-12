class Sort {
  final String field;
  final bool isAsc;

  Sort({
    required this.field,
    required this.isAsc,
  });

  factory Sort.fromJson(Map<String, dynamic> json) {
    return Sort(
      field: json['field'] as String,
      isAsc: json['isAsc'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'field': field,
      'isAsc': isAsc,
    };
  }
}