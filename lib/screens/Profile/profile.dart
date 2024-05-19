import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:authenticationapp/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';






class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  late User? _user;
  String _imageUrl = '';
  final Map<String, String> _userData = {};

@override
void initState(){
  super.initState();
  getUser();
}
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('user').snapshots(),

      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              Map<String, dynamic>? data = documents[index].data()! as Map<
                  String,
                  dynamic>?;
              final String userId = documents[index]
                  .id; // Get user ID outside the closure

              _userData.putIfAbsent(
                  userId, () => data?['name'] as String ?? 'Unknown Name');

              return Container(
                margin: EdgeInsets.only(top: 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image with tappable container for potential update
                        GestureDetector(
                          onTap: () => handleImageSelection(),
                          child: Image.network(
                            data?['imgUrl'] as String ?? 'default_image_url',
                            width: 100,
                            height: 100,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          _userData[userId] ?? 'Unknown Name',
                          // Use stored name for efficiency
                          style: TextStyle(fontSize: 20),
                        ),
                        // Button with tappable functionality for name update
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () =>
                              _handleNameUpdate(
                                  context, userId), // Pass userId here
                        ),
                      ],
                    ),
                    SizedBox(height: 14),
                    TextButton.icon(
                      icon: Icon(Icons.exit_to_app, color: Colors.white),
                      // Establece el color del icono
                      label:
                      Text(
                        'Cerrar sesión',


                        style: TextStyle(color: Colors
                            .white), // Establece el color del texto
                      ),


                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors
                            .orange),
                        // Establece el color de fondo del botón
                      ),
                      onPressed: () => _signOut(context),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Center(
              child: CircularProgressIndicator());
        }
      },
    );
  }
  Future<void> getUser() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _user = user;
      });
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        _imageUrl = userDoc['imgUrl'];
      });
    }
  }

  Future<void> handleImageSelection() async {
  if( _user !=null ){
    await _pickImage();

  }else{
    print('Error: _user is null');
  }
    // await getUser();
    // await _pickImage();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      String imagePath = 'images/${_user!.uid}/${DateTime.now()}.png';
      await _storage.ref().child(imagePath).putFile(image);
      String imageUrl = await _storage.ref(imagePath).getDownloadURL();
      setState(() {
        _imageUrl = imageUrl;
      });
      await _firestore.collection('user').doc(_user!.uid).update({
        'imgUrl': imageUrl,
      });
    }
  }

  User? get user => _user;
  String get imageUrl => _imageUrl;






  void _handleNameUpdate(BuildContext context, String userId) async {
    final nameController = TextEditingController(
        text: _userData[userId]); // Create controller with initial name

    final newName = await showDialog<String>(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Actualizar nombre'),
            content: TextField(
              controller: nameController, // Pass the controller to the TextField
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, nameController.text),
                // Access text directly from controller
                child: Text('Actualizar'),
              ),
            ],
          ),
    );
    if (newName != null) {
      // Update Firestore with new name
      await FirebaseFirestore.instance.collection('user').doc(userId).update
        ({'name': newName});

      // Update local data for efficiency
      setState(() {
        _userData[userId] = newName;
      });
    }
  }

  void _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
    if(context.mounted){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LogIn()));
    }
    } catch (e) {
      print("Error al cerrar sesion: $e");
    }
  }
}




