import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:live_score_application/screens/reels/model/model_reel.dart';

final reelsProvider = FutureProvider<List<Reel>>((ref) async {
  final querySnapshot = await FirebaseFirestore.instance.collection('reels').get();
  return querySnapshot.docs.map((doc) {
    final data = doc.data();
    return Reel(
      id: doc.id,
      videoUrl: data['videoUrl'],
      description: data['description'],
      userId: data['userId'],
      username: data['username'],
    );
  }).toList();
});
