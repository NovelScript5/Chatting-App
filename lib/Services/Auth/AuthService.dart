import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {

// Instance of auth and firestore
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Sign In
Future<UserCredential> signIn(String email,String password) async {

try {

// Sign In
UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

// Integrate with firestore
_firestore.collection("People").doc(userCredential.user!.uid).set({

"uid":userCredential.user!.uid,
"email":email

},SetOptions(merge: true));

return userCredential;

} on FirebaseAuthException catch (e) {

throw Exception(e.code);

}

}

// Create a new user
Future<UserCredential> SignUp(String email, String password) async {

try {

// Create a new user
UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

// Integrate with firestore
_firestore.collection("People").doc(userCredential.user!.uid).set({
"uid":userCredential.user!.uid,
"email":email
});

return userCredential;

} on FirebaseAuthException catch (e) {

throw Exception(e.code);

}
} 

Future<void> SignOut() async {

return await _firebaseAuth.signOut();

}

}