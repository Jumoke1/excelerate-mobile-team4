
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/programme_model.dart';

class ProgrammeService {
  final CollectionReference _programmesCollection =
      FirebaseFirestore.instance.collection('programmes');

  // EXISTING METHODS 
  
  Future<DocumentReference> createProgramme(ProgrammeModel programme) {
    return _programmesCollection.add(programme.toFirestore());
  }

  Future<ProgrammeModel?> getProgramme(String programmeId) async {
    DocumentSnapshot doc = await _programmesCollection.doc(programmeId).get();
    if (doc.exists) {
      return ProgrammeModel.fromFirestore(doc);
    }
    return null;
  }

  Future<void> updateProgramme(String programmeId, Map<String, dynamic> data) {
    return _programmesCollection.doc(programmeId).update(data);
  }

  Future<void> deleteProgramme(String programmeId) {
    return _programmesCollection.doc(programmeId).delete();
  }

  // METHODS FOR EXPLORE SCREEN 

  /// Get all active programs as a stream (for real-time updates)
  /// REMOVED orderBy to avoid index issues
  Stream<List<ProgrammeModel>> getActivePrograms() {
    return _programmesCollection
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProgrammeModel.fromFirestore(doc);
      }).toList();
    });
  }

  /// Get active programs by category/type
  /// REMOVED orderBy to avoid index issues
  Stream<List<ProgrammeModel>> getActiveProgramsByCategory(String category) {
    Query query = _programmesCollection.where('isActive', isEqualTo: true);
    
    if (category != 'All') {
      query = query.where('type', isEqualTo: category);
    }
    
    return query
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProgrammeModel.fromFirestore(doc);
      }).toList();
    });
  }

  /// Get a single program with real-time updates
  Stream<ProgrammeModel?> getProgrammeStream(String programmeId) {
    return _programmesCollection
        .doc(programmeId)
        .snapshots()
        .map((doc) {
      if (doc.exists) {
        return ProgrammeModel.fromFirestore(doc);
      }
      return null;
    });
  }

  /// Get programs by experience level
  Stream<List<ProgrammeModel>> getProgramsByExperienceLevel(String level) {
    return _programmesCollection
        .where('isActive', isEqualTo: true)
        .where('experienceLevel', isEqualTo: level)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProgrammeModel.fromFirestore(doc);
      }).toList();
    });
  }

  /// Search programs by title or description (client-side filtering)
  Stream<List<ProgrammeModel>> searchPrograms(String searchTerm) {
    return _programmesCollection
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ProgrammeModel.fromFirestore(doc))
          .where((program) =>
              program.title.toLowerCase().contains(searchTerm.toLowerCase()) ||
              program.description.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    });
  }

  /// Get featured programs (most recent 3 programs)
  Stream<List<ProgrammeModel>> getFeaturedPrograms() {
    return _programmesCollection
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      final programs = snapshot.docs.map((doc) {
        return ProgrammeModel.fromFirestore(doc);
      }).toList();
      
      // Sort on client side by createdAt (newest first)
      programs.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      
      // Return only first 3
      return programs.take(3).toList();
    });
  }

  /// Get program count by category
  Future<int> getProgramCountByCategory(String category) async {
    Query query = _programmesCollection.where('isActive', isEqualTo: true);
    if (category != 'All') {
      query = query.where('type', isEqualTo: category);
    }
    final snapshot = await query.get();
    return snapshot.docs.length;
  }

  /// Get all distinct categories
  Future<List<String>> getCategories() async {
    final snapshot = await _programmesCollection
        .where('isActive', isEqualTo: true)
        .get();
    
    Set<String> categories = {};
    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      if (data.containsKey('type') && data['type'] != null) {
        categories.add(data['type'].toString());
      }
    }
    return categories.toList()..sort();
  }

  /// Get programs sorted by creation date (client-side sorting)
  Stream<List<ProgrammeModel>> getProgramsSortedByDate() {
    return _programmesCollection
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      final programs = snapshot.docs.map((doc) {
        return ProgrammeModel.fromFirestore(doc);
      }).toList();
      
      // Sort by createdAt (newest first)
      programs.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      
      return programs;
    });
  }

  /// Get programs with client-side sorting by category
  Stream<List<ProgrammeModel>> getProgramsByCategorySorted(String category) {
    Query query = _programmesCollection.where('isActive', isEqualTo: true);
    
    if (category != 'All') {
      query = query.where('type', isEqualTo: category);
    }
    
    return query
        .snapshots()
        .map((snapshot) {
      final programs = snapshot.docs.map((doc) {
        return ProgrammeModel.fromFirestore(doc);
      }).toList();
      
      // Sort by createdAt (newest first)
      programs.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      
      return programs;
    });
  }
}