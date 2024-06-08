import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:patrimonie/model/category_model.dart';

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<LatLng>> getCategoryLocations(String categoryName) async {
    try {
      final querySnapshot = await _firestore
          .collection('CategoryLocations')
          .where('category', isEqualTo: categoryName)
          .get();
      final locations = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return LatLng(data['latitude'], data['longitude']);
      }).toList();
      return locations;
    } catch (e) {
      print('Error fetching category locations: $e');
      return [];
    }
  }

  // Stream to listen for changes in categories (optional)
  Stream<List<Category>> get categories {
    return _firestore.collection('Category').snapshots().map((querySnapshot) {
      final categories = querySnapshot.docs
          .map((doc) => Category.fromMap(doc.data(), id: doc.id))
          .toList();
      return categories;
    });
  }

  // Future to get all categories at once
  Future<List<Category>> getCategories() async {
    try {
      final querySnapshot = await _firestore.collection('Category').get();
      final categories = querySnapshot.docs
          .map((doc) => Category.fromMap(doc.data(), id: doc.id))
          .toList();
      return categories;
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }

  // Get a specific category by its ID (optional)
  Future<Category?> getCategoryById(String id) async {
    try {
      final docSnapshot = await _firestore.collection('Category').doc(id).get();
      if (docSnapshot.exists) {
        return Category.fromMap(docSnapshot.data()!,
            id: id); // Pass `id` for consistency
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching category by ID: $e');
      return null;
    }
  }
}
