import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/models/user.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addUserData(UserModel userData) async {
    print("userData UID${userData.uid}");

    await _db.collection("Users").doc(userData.uid).set(userData.toMap());
  }

  Future<List<UserModel>> retrieveUserData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("Users").get();
    print("snapshot$snapshot");
    return snapshot.docs
        .map((docSnapshot) => UserModel.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<String> retrieveUserName(UserModel user) async {
    // DocumentSnapshot<Map<String, dynamic>> docSnapshot =
    //     await _db.collection("Users").doc(user.uid).get();
    // DocumentSnapshot userSnapshot =
    //     await _db.collection('Users').doc('1').get();
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await _db.collection("Users").doc(user.uid).get();
    print(userSnapshot);
    if (userSnapshot.exists) {
      // User found, return a UserModel object
      print(UserModel.fromDocumentSnapshot(userSnapshot));
      return UserModel.fromDocumentSnapshot(userSnapshot).displayName!;
    } else {
      // User not found
      print('not found');
    }
    // print("data:" + docSnapshot.data()!["displayName"]);
    // return docSnapshot.data()!["displayName"];
    return 'Bank';
  }
}
