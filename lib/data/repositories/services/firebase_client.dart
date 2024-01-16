import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc_firebase_2/modules/home_page/models/message.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/models/user.dart';

class FirebaseClient {
  final CollectionReference _messageCollection =
      FirebaseFirestore.instance.collection('messages');

  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Future<UserModel?> signUpUser(String email, String password) async {
  //   try {
  //     final UserCredential userCredential =
  //         await _firebaseAuth.createUserWithEmailAndPassword(
  //       email: email.trim(),
  //       password: password.trim(),
  //     );
  //     final User? firebaseUser = userCredential.user;
  //     if (firebaseUser != null) {
  //       return UserModel(
  //         id: firebaseUser.uid,
  //         email: firebaseUser.email ?? '',
  //         displayName: firebaseUser.displayName ?? '',
  //       );
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     print(e.toString());
  //   }
  //   return null;
  // }

  // Future<void> signOutUser() async {
  //   final User? firebaseUser = FirebaseAuth.instance.currentUser;
  //   if (firebaseUser != null) {
  //     await FirebaseAuth.instance.signOut();
  //   }
  // }

  Future<void> sentMessage(String message, int userId) async {
    try {
      await _messageCollection.add({
        'userId': userId,
        'text': message,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<Message>> getAllMessages() async {
    try {
      QuerySnapshot querySnapshot = await _messageCollection.get();
      List<Message> messages = querySnapshot.docs
          .map((e) => Message.fromDocumentSnapshot(e))
          .toList();
      return messages;
    } catch (e) {
      return [];
    }
  }
}
