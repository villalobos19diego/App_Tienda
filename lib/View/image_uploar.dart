


import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploader {
  final ImagePicker _picker = ImagePicker();

  Future<void> uploadImageAndUpdateShoeDocument(String documentId) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final selectedImage = File(image.path);
      final imageUrl = await _uploadImage(selectedImage);
      await _updateShoeDocument(documentId, {'image': imageUrl});
    } else {
      print('No se seleccionó ninguna imagen');
    }
  }

  Future<String> _uploadImage(File image) async {
    final reference = FirebaseStorage.instance.ref().child('productos/${DateTime.now().millisecondsSinceEpoch}');
    await reference.putFile(image);
    final url = await reference.getDownloadURL();
    return url;
  }

  Future<void> _updateShoeDocument(String documentId, Map<String, dynamic> data) async {
    final docRef = FirebaseFirestore.instance.collection('shoes').doc(documentId);
    await docRef.update(data);
  }
}




