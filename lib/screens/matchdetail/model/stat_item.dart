class StatItem {
  final String label;
  final String value;

  StatItem({
    required this.label,
    required this.value,
  });

  factory StatItem.fromJson(Map<String, dynamic> json) {
    return StatItem(
      label: json['label'],
      value: json['value'],
    );
  }
}