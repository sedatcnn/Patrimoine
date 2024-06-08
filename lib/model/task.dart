class Task {
  String? id;
  String? title;
  String? date;
  String? startTime;
  String? ulasim;
  int? remind;
  int? color;
  String? group;
  List<String>? category;

  Task({
    this.id,
    this.title,
    this.group,
    this.category,
    this.date,
    this.startTime,
    this.ulasim,
    this.remind,
    this.color,
  });

  factory Task.fromMap(Map<String, dynamic> map, {String? id}) {
    // Handle category as a list of strings
    List<String>? categoryList;
    if (map['category'] is List<dynamic>) {
      categoryList = map['category'].cast<String>(); // Cast to List<String>
    } else if (map['category'] is String) {
      // If category is a single string, convert it to a list with one element
      categoryList = [map['category'] as String];
    }

    return Task(
      id: id,
      group: map['group'] as String?,
      title: map['title'] as String?,
      category: categoryList,
      date: map['date'] as String?,
      ulasim: map['ulasim'] as String?,
      startTime: map['startTime'] as String?,
      remind: map['remind'] is int
          ? map['remind'] as int
          : int.tryParse(map['remind']?.toString() ?? ''),
      color: map['color'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date,
      'group': group,
      'category': category,
      'ulasim': ulasim,
      'startTime': startTime,
      'remind': remind,
      'color': color,
    };
  }
}
