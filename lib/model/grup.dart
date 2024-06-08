class Grups {
  String? userID;
  String name;
  String kisiler;

  Grups({
    this.userID,
    required this.name,
    required this.kisiler,
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'name': name,
      'kisiler': kisiler,
    };
  }

  Grups.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        kisiler = map['kisiler'],
        name = map['name'];
}
