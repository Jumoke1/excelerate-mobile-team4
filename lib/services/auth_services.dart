import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void signUpUser(
  String name,
  String email,
  String password,
  String confirmPassword,
  String role,
) async {

  // 1. Validate input
  if (email.isEmpty || password.isEmpty) {
    // print("Fields cannot be empty");
    return;
  }

  if (password != confirmPassword) {
    // print("Passwords do not match");
    return;
  }

  try {

    // 2. Create user in Firebase Auth
     var userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // 3. Get UID
    String uid = userCredential.user!.uid;

    // 4. Save user in Firestore
    await FirebaseFirestore.instance.collection("users").doc(uid).set({
      "name": name,
      "email": email,
      "role": role,
    });

    // print("User created successfully");

  } catch (e) {
    // print("Error: $e");
  }
}

//login 
Future<bool> loginUser(String email, String password) async {
  try {

    if (email.isEmpty || password.isEmpty) {
      // print("Fields cannot be empty");
      return false;
    }

    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // print("Login successful: $uid");

    return true;

  } catch (e) {
    // print("Login failed: $e");
    return false;
  }
}