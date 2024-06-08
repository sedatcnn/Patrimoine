import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:patrimonie/model/task.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  var taskList = <Task>[].obs;
  CollectionReference tasks = FirebaseFirestore.instance.collection('Tasks');

  Future addTask({required Task task}) async {
    await tasks.add(task.toMap());
    getTasks();
  }

  void getTasks() async {
    try {
      taskList.clear();
      QuerySnapshot querySnapshot = await tasks.get();
      for (var doc in querySnapshot.docs) {
        print("Document Data: ${doc.data()}");
        var task = Task.fromMap(doc.data() as Map<String, dynamic>, id: doc.id);
        taskList.add(task);
      }
      print("Tasks fetched successfully");
    } catch (e) {
      print("Error fetching tasks: $e");
    }
  }

  Future<void> delete(String taskId) async {
    await tasks.doc(taskId).delete();
    getTasks();
  }
}
