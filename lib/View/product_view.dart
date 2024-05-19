
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductRepository {
  final CollectionReference productsCollection =
  FirebaseFirestore.instance.collection('products');

  Future<void> incrementViews(String productId) async {
    await productsCollection.doc(productId).update({
      'views': FieldValue.increment(1),
    });
  }

  Stream<int> watchViews(String productId) {
    return productsCollection.doc(productId).snapshots().map((snapshot) {
      return snapshot['views'] ?? 0;
    });
  }
}

class ProductViewsProvider extends ChangeNotifier {
  final ProductRepository _repository;

  ProductViewsProvider(this._repository);

  Future<void> incrementViews(String productId) async {
    await _repository.incrementViews(productId);
  }

  Stream<int> watchViews(String productId) {
    return _repository.watchViews(productId);
  }
}