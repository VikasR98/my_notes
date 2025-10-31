class DiaryEntry {
  int? id;
  String title;
  String description;
  String dateTime;
  int mood;
  int createdAt;
  int updatedAt;

  DiaryEntry({
    this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.mood,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert a DiaryEntry to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date_time': dateTime,
      'mood': mood,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  // Create a DiaryEntry from a Map
  factory DiaryEntry.fromMap(Map<String, dynamic> map) {
    return DiaryEntry(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        dateTime: map['date_time'],
        mood: map['mood'],
        createdAt: map['created_at'],
        updatedAt: map['updated_at']);
  }
}
