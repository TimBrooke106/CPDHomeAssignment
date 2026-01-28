class Note {
  final String id;
  final String title;
  final String body;
  final String? imagePath; // NEW
  final DateTime createdAt;

  Note({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    this.imagePath, // NEW
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "body": body,
        "imagePath": imagePath, // NEW
        "createdAt": createdAt.toIso8601String(),
      };

  static Note fromMap(Map<dynamic, dynamic> map) => Note(
        id: map["id"] as String,
        title: map["title"] as String,
        body: map["body"] as String,
        imagePath: map["imagePath"] as String?, // NEW
        createdAt: DateTime.parse(map["createdAt"] as String),
      );
}
