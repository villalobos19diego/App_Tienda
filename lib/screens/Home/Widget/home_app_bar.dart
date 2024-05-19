import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          style: IconButton.styleFrom(
            backgroundColor: kcontentColor,
            padding: const EdgeInsets.all(15),
          ),
          onPressed: () {},
          icon: Image.asset(
            "images/icon.png",
            height: 20,
            color: kprimaryColor,
          ),
        ),
        IconButton(
          style: IconButton.styleFrom(
            backgroundColor: kcontentColor,
            padding: const EdgeInsets.all(15),
          ),
          onPressed: () {},
          iconSize: 30,
          icon: const Icon(Icons.notifications_outlined, color: kprimaryColor,),
        ),
      ],
    );
  }
}


//
// class NotificationManager {
//   //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//
//   void initialize() {
//     var configure = _firebaseMessaging.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         // Se llama cuando la aplicación está en primer plano y se recibe una notificación.
//         // Puedes manejar cómo mostrar la notificación aquí.
//         _showNotification(message);
//       },
//       onLaunch: (Map<String, dynamic> message) async {
//         // Se llama cuando el usuario toca la notificación y la aplicación estaba cerrada.
//         // Puedes manejar cómo abrir la aplicación y mostrar la notificación aquí.
//       },
//       onResume: (Map<String, dynamic> message) async {
//         // Se llama cuando el usuario toca la notificación y la aplicación estaba en segundo plano.
//         // Puedes manejar cómo abrir la aplicación y mostrar la notificación aquí.
//       },
//     );
//   }
//
//   void _showNotification(Map<String, dynamic> message) {
//     // Aquí puedes mostrar la notificación en la campanita.
//     // Por ejemplo, podrías utilizar un SnackBar o cualquier otro widget que prefieras.
//     // Esto es solo un ejemplo básico para mostrar el mensaje en la consola.
//     print('Mensaje de notificación: $message');
//   }
// }
//
// class NotificationIconButton extends StatelessWidget {
//   final NotificationManager notificationManager = NotificationManager();
//
//   NotificationIconButton() {
//     notificationManager.initialize();
//   }