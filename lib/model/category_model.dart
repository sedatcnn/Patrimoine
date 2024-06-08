class Category {
  String name;
  String id;

  Category({
    required this.id, // Changed 'categoryID' to 'id'
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Changed 'categoryID' to 'id'
      'name': name,
    };
  }

  Category.fromMap(Map<String, dynamic> map,
      {required this.id}) // Changed 'categoryID' to 'id'
      : name = map['name'];
}
