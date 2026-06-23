// lib/delete_duplicates.dart
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> deleteFrontendPrograms() async {
  final firestore = FirebaseFirestore.instance;
  
  try {
    // Get all programs
    final snapshot = await firestore.collection('programmes').get();
    
    int deletedCount = 0;
    
    // Delete all with "Frontend Development" in title
    for (var doc in snapshot.docs) {
      final data = doc.data();
      if (data['title'] == 'Frontend Development') {
        await doc.reference.delete();
        deletedCount++;
        print('🗑️ Deleted: ${doc.id} - ${data['title']}');
      }
    }
    
    print('✅ Deleted $deletedCount Frontend Development programs!');
  } catch (e) {
    print('❌ Error: $e');
  }
}

// OPTIONAL: Delete ALL programs (use carefully!)
Future<void> deleteAllPrograms() async {
  final firestore = FirebaseFirestore.instance;
  
  try {
    final snapshot = await firestore.collection('programmes').get();
    
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
      print('🗑️ Deleted: ${doc.id}');
    }
    
    print('✅ Deleted ALL programs!');
  } catch (e) {
    print('❌ Error: $e');
  }
}