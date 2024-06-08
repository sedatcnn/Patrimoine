import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:patrimonie/model/grup.dart';

class GrupsService {
  final CollectionReference grupsCollection =
      FirebaseFirestore.instance.collection('gruplar');

  // Yeni bir grup oluşturma
  Future<void> createGrup(String userID, String name, String kisiler) async {
    try {
      await grupsCollection.add({
        'userID': userID,
        'name': name,
        'kisiler': kisiler,
      });
    } catch (e) {
      print("Hata: $e");
    }
  }

  // Tüm grupları getirme
  Stream<List<Grups>> getGrups() {
    return grupsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Grups.fromMap(data);
      }).toList();
    });
  }

  // Belirli bir grup güncelleme
  Future<void> updateGrup(String docID, String name, String kisiler) async {
    try {
      await grupsCollection.doc(docID).update({
        'name': name,
        'kisiler': kisiler,
      });
    } catch (e) {
      print("Hata: $e");
    }
  }

  // Belirli bir grup silme
  Future<void> deleteGrup(String docID) async {
    try {
      await grupsCollection.doc(docID).delete();
    } catch (e) {
      print("Hata: $e");
    }
  }
}
