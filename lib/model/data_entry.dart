class DiaryEntry {
  int? id;
  String title;
  String description;
  String dateTime;
  int mood;

  DiaryEntry({
    this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.mood,
  });

  // Convert a DiaryEntry to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date_time': dateTime,
      'mood': mood,
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
    );
  }
}
