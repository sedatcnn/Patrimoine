import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:patrimonie/model/category_model.dart';

class CategoriService {
  CollectionReference categori =
      FirebaseFirestore.instance.collection('Categori');

  Future<List<Category>> getTasks() async {
    try {
      List<Category> taskList = [];
      QuerySnapshot querySnapshot = await categori.get(); // Corrected here
      for (var doc in querySnapshot.docs) {
        print("Document Data: ${doc.data()}");
        var task =
            Category.fromMap(doc.data() as Map<String, dynamic>, id: doc.id);
        taskList.add(task);
      }
      print("Tasks fetched successfully");
      return taskList;
    } catch (e) {
      print("Error fetching tasks: $e");
      return []; // Return an empty list if there's an error
    }
  }
}
