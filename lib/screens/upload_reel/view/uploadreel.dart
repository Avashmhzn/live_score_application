import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';


Future<void> uploadReel(File videoFile, String description, String username) async {
  try {

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("No user is signed in");
    }


    await user.reload();
    User? updatedUser = FirebaseAuth.instance.currentUser;
    String userId = updatedUser?.uid ?? '';


    print('User ID: $userId');
    print('Username: $username');
    print('User Email: ${updatedUser?.email}');


    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    // Reference to Firebase Storage
    Reference storageRef = FirebaseStorage.instance.ref().child('reels').child(fileName);


    UploadTask uploadTask = storageRef.putFile(videoFile);
    print('Uploading video file...');
    TaskSnapshot taskSnapshot = await uploadTask;
    print('Upload completed');


    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    print('Download URL: $downloadUrl');


    await FirebaseFirestore.instance.collection('reels').add({
      'videoUrl': downloadUrl,
      'description': description,
      'userId': userId,
      'username': username,
      'timestamp': FieldValue.serverTimestamp(),
    }).then((doc) {
      print('Reel metadata saved with document ID: ${doc.id}');
    }).catchError((error) {
      print('Error saving metadata to Firestore: $error');
      throw error;
    });

    print('Reel uploaded successfully with username: $username');

  } catch (e) {
    print('Error uploading reel: $e');
    throw e;
  }
}