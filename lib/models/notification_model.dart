class NotificationModel {
  final int? id;
  final String? title;
  final String? description;
  final int? userId;
  final DateTime createdAt;

  const NotificationModel({
    this.id,
    this.title,
    this.description,
    this.userId,
    required this.createdAt,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
