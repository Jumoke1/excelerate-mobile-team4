import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'lib/firebase_options.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firestore = FirebaseFirestore.instance;
  
  // Your original static data
  final programs = [
    {
      'title': 'AI & Machine Learning',
      'type': 'Technology',
      'hostOrganisation': 'Dr. Sarah Chen',
      'description': 'Learn AI and Machine Learning fundamentals',
      'skills': ['Python', 'TensorFlow', 'Machine Learning'],
      'experienceLevel': 'Intermediate',
      'careerFields': ['Data Science', 'AI Engineer'],
      'durationWeeks': 12,
      'weeklyHoursRequired': 10,
      'applicationDeadline': Timestamp.fromDate(DateTime(2026, 12, 31)),
      'startDate': Timestamp.fromDate(DateTime(2026, 7, 1)),
      'isActive': true,
      'rewards': {'certificate': true},
      'createdBy': 'admin',
      'createdAt': Timestamp.now(),
      'updatedAt': Timestamp.now(),
    },
    {
      'title': 'Digital Marketing Pro',
      'type': 'Marketing',
      'hostOrganisation': 'Marcus Thorne',
      'description': 'Master digital marketing strategies',
      'skills': ['SEO', 'Social Media', 'Content Marketing'],
      'experienceLevel': 'Beginner',
      'careerFields': ['Marketing', 'Digital Marketing'],
      'durationWeeks': 8,
      'weeklyHoursRequired': 8,
      'applicationDeadline': Timestamp.fromDate(DateTime(2026, 12, 31)),
      'startDate': Timestamp.fromDate(DateTime(2026, 7, 1)),
      'isActive': true,
      'rewards': {'certificate': true},
      'createdBy': 'admin',
      'createdAt': Timestamp.now(),
      'updatedAt': Timestamp.now(),
    },
    {
      'title': 'UX/UI Design Bootcamp',
      'type': 'Design',
      'hostOrganisation': 'Emma Wilson',
      'description': 'Become a professional UX/UI designer',
      'skills': ['Figma', 'User Research', 'Prototyping'],
      'experienceLevel': 'Beginner',
      'careerFields': ['UX Designer', 'UI Designer'],
      'durationWeeks': 10,
      'weeklyHoursRequired': 12,
      'applicationDeadline': Timestamp.fromDate(DateTime(2026, 12, 31)),
      'startDate': Timestamp.fromDate(DateTime(2026, 7, 1)),
      'isActive': true,
      'rewards': {'certificate': true},
      'createdBy': 'admin',
      'createdAt': Timestamp.now(),
      'updatedAt': Timestamp.now(),
    },
    {
      'title': 'Full-Stack Web Development',
      'type': 'Technology',
      'hostOrganisation': 'James Rodriguez',
      'description': 'Become a full-stack web developer',
      'skills': ['JavaScript', 'React', 'Node.js', 'MongoDB'],
      'experienceLevel': 'Intermediate',
      'careerFields': ['Web Development', 'Full Stack'],
      'durationWeeks': 16,
      'weeklyHoursRequired': 15,
      'applicationDeadline': Timestamp.fromDate(DateTime(2026, 12, 31)),
      'startDate': Timestamp.fromDate(DateTime(2026, 7, 1)),
      'isActive': true,
      'rewards': {'certificate': true},
      'createdBy': 'admin',
      'createdAt': Timestamp.now(),
      'updatedAt': Timestamp.now(),
    },
    {
      'title': 'Business Strategy Mastery',
      'type': 'Business',
      'hostOrganisation': 'Lisa Anderson',
      'description': 'Master business strategy and management',
      'skills': ['Strategy', 'Leadership', 'Management'],
      'experienceLevel': 'Intermediate',
      'careerFields': ['Business', 'Management'],
      'durationWeeks': 6,
      'weeklyHoursRequired': 8,
      'applicationDeadline': Timestamp.fromDate(DateTime(2026, 12, 31)),
      'startDate': Timestamp.fromDate(DateTime(2026, 7, 1)),
      'isActive': true,
      'rewards': {'certificate': true},
      'createdBy': 'admin',
      'createdAt': Timestamp.now(),
      'updatedAt': Timestamp.now(),
    },
    {
      'title': 'Data Science with Python',
      'type': 'Technology',
      'hostOrganisation': 'Dr. Raj Patel',
      'description': 'Learn data science with Python',
      'skills': ['Python', 'Pandas', 'NumPy', 'Data Visualization'],
      'experienceLevel': 'Intermediate',
      'careerFields': ['Data Science', 'Data Analyst'],
      'durationWeeks': 14,
      'weeklyHoursRequired': 12,
      'applicationDeadline': Timestamp.fromDate(DateTime(2026, 12, 31)),
      'startDate': Timestamp.fromDate(DateTime(2026, 7, 1)),
      'isActive': true,
      'rewards': {'certificate': true},
      'createdBy': 'admin',
      'createdAt': Timestamp.now(),
      'updatedAt': Timestamp.now(),
    },
  ];

  print('\n📥 Adding ${programs.length} programs to Firestore...\n');

  int added = 0;
  int skipped = 0;

  for (var program in programs) {
    try {
      // Check if program already exists
      final existing = await firestore
          .collection('programmes')
          .where('title', isEqualTo: program['title'])
          .get();

      if (existing.docs.isEmpty) {
        await firestore.collection('programmes').add(program);
        print('✅ Added: ${program['title']}');
        added++;
      } else {
        print('⏭️ Skipped (already exists): ${program['title']}');
        skipped++;
      }
    } catch (e) {
      print('❌ Error adding ${program['title']}: $e');
    }
  }

  print('\n' + '='*50);
  print('📊 Summary:');
  print('   ✅ Added: $added programs');
  print('   ⏭️ Skipped: $skipped programs (already exist)');
  print('='*50);

  // Show all programs now
  print('\n📚 All programs in database now:');
  final snapshot = await firestore.collection('programmes').get();
  final types = <String>{};
  for (var doc in snapshot.docs) {
    final data = doc.data();
    final type = data['type'] as String?;
    if (type != null && type.isNotEmpty) {
      types.add(type);
    }
    print('   📝 ${data['title']} → ${data['type'] ?? 'NO TYPE'}');
  }

  print('\n📊 Categories available:');
  for (var type in types.toList()..sort()) {
    final count = snapshot.docs.where((d) => d.data()['type'] == type).length;
    print('   "$type" → $count programs');
  }

  print('\n✅ Done! Restart your app to see the new data.');
}
