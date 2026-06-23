// import 'package:cloud_firestore/cloud_firestore.dart';

// Future<void> seedPrograms() async {
//   final firestore = FirebaseFirestore.instance;

//   final programs = [
//     {
//       "title": "Full-Stack Web Development",
//       "type": "Technology",
//       "hostOrganisation": "Excelerate Academy",
//       "description": "Learn to build modern web applications using Flutter, Node.js, and Firebase.",
//       "skills": ["Flutter", "Node.js", "Firebase", "JavaScript"],
//       "experienceLevel": "Beginner",
//       "careerFields": ["Software Engineering", "Web Development"],
//       "durationWeeks": 16,
//       "weeklyHoursRequired": 10,
//       "weeklyHoursRequired": Timestamp.now(),
//       "startDate": Timestamp.now(),
//       "isActive": true,
//       "rewards": {
//         "certificate": true,
//         "badge": "Full-Stack Developer"
//       },
//       "createdBy": "admin",
//       "createdAt": Timestamp.now(),
//       "updatedAt": Timestamp.now(),
//     },

//     {
//       "title": "UI/UX Design Bootcamp",
//       "type": "Design",
//       "hostOrganisation": "Excelerate Academy",
//       "description": "Master user experience design, wireframing, and Figma tools.",
//       "skills": ["Figma", "Wireframing", "User Research", "Prototyping"],
//       "experienceLevel": "Beginner",
//       "careerFields": ["Product Design", "UI/UX"],
//       "durationWeeks": 10,
//       "weeklyHoursRequired": 8,
//       "applicationDeadline": Timestamp.now(),
//       "startDate": Timestamp.now(),
//       "isActive": true,
//       "rewards": {
//         "certificate": true,
//         "badge": "UI Designer"
//       },
//       "createdBy": "admin",
//       "createdAt": Timestamp.now(),
//       "updatedAt": Timestamp.now(),
//     },

//     {
//       "title": "Digital Marketing Mastery",
//       "type": "Marketing",
//       "hostOrganisation": "Excelerate Academy",
//       "description": "Learn SEO, social media marketing, Google Ads, and content strategy.",
//       "skills": ["SEO", "Google Ads", "Content Marketing", "Social Media"],
//       "experienceLevel": "Beginner",
//       "careerFields": ["Marketing", "Growth"],
//       "durationWeeks": 8,
//       "weeklyHoursRequired": 6,
//       "applicationDeadline": Timestamp.now(),
//       "startDate": Timestamp.now(),
//       "isActive": true,
//       "rewards": {
//         "certificate": true,
//         "badge": "Marketing Specialist"
//       },
//       "createdBy": "admin",
//       "createdAt": Timestamp.now(),
//       "updatedAt": Timestamp.now(),
//     },

//     {
//       "title": "Business Strategy & Entrepreneurship",
//       "type": "Business",
//       "hostOrganisation": "Excelerate Academy",
//       "description": "Learn how to build startups, business models, and growth strategies.",
//       "skills": ["Business Strategy", "Leadership", "Entrepreneurship"],
//       "experienceLevel": "Intermediate",
//       "careerFields": ["Business", "Startups"],
//       "durationWeeks": 6,
//       "weeklyHoursRequired": 5,
//       "applicationDeadline": Timestamp.now(),
//       "startDate": Timestamp.now(),
//       "isActive": true,
//       "rewards": {
//         "certificate": true,
//         "badge": "Business Strategist"
//       },
//       "createdBy": "admin",
//       "createdAt": Timestamp.now(),
//       "updatedAt": Timestamp.now(),
//     },

//     {
//       "title": "Data Science with Python",
//       "type": "Technology",
//       "hostOrganisation": "Excelerate Academy",
//       "description": "Learn data analysis, visualization, and machine learning with Python.",
//       "skills": ["Python", "Pandas", "NumPy", "Machine Learning"],
//       "experienceLevel": "Intermediate",
//       "careerFields": ["Data Science", "AI"],
//       "durationWeeks": 14,
//       "weeklyHoursRequired": 12,
//       "applicationDeadline": Timestamp.now(),
//       "startDate": Timestamp.now(),
//       "isActive": true,
//       "rewards": {
//         "certificate": true,
//         "badge": "Data Scientist"
//       },
//       "createdBy": "admin",
//       "createdAt": Timestamp.now(),
//       "updatedAt": Timestamp.now(),
//     }
//   ];

//   for (final program in programs) {
//     await firestore.collection('programmes').add(program);
//   }

//   print("Seed completed successfully");
// }