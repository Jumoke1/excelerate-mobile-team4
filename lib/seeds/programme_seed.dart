import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/programme_service.dart';
import '../models/programme_model.dart';

Future<void> seedProgrammes() async {
   // print("🔥 SEED STARTED");
  final service = ProgrammeService();

  await service.createProgramme(
    
    ProgrammeModel(
      title: "Frontend Development",
      type: "Internship",
      hostOrganisation: "Tech Hub",
      description: "Learn HTML, CSS, JS",

      skills: ["HTML", "CSS", "JavaScript"],
      experienceLevel: "Beginner",
      careerFields: ["Frontend", "Web Development"],

      durationWeeks: 10,
      weeklyHoursRequired: 8,

      applicationDeadline: Timestamp.fromDate(
        DateTime(2026, 12, 31),
      ),

      startDate: Timestamp.fromDate(
        DateTime(2026, 7, 1),
      ),

      isActive: true,

      rewards: {
        "certificate": true,
        "stipend": "Yes",
      },

      createdBy: "admin_001",

      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    ),
  );
  // print("✅ SEED FINISHED");
}