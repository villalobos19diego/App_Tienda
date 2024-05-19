//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
//
//
//
// class ProfileManager {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//
//   User? _user;
//   String _imageUrl = '';
//
//   Future<void> getUser() async {
//     User? user = _auth.currentUser;
//     if (user != null) {
//       _user = user;
//       DocumentSnapshot userDoc =
//       await _firestore.collection('users').doc(user.uid).get();
//       _imageUrl = userDoc['imgUrl'];
//     }
//   }
//
//   Future<void> handleImageSelection() async {
//     await _pickImage();
//   }
//
//   Future<void> _pickImage() async {
//     final pickedFile =
//     await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       File image = File(pickedFile.path);
//       String imagePath = 'images/${_user!.uid}/${DateTime.now()}.png';
//       await _storage.ref().child(imagePath).putFile(image);
//       String imageUrl = await _storage.ref(imagePath).getDownloadURL();
//       _imageUrl = imageUrl;
//       await _firestore.collection('user').doc(_user!.uid).update({
//         'imgUrl': imageUrl,
//       });
//     }
//   }
//
//   User? get user => _user;
//   String get imageUrl => _imageUrl;
//
//
// }