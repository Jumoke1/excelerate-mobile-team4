// lib/models/programme_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProgrammeModel {
  final String? id;
  final String title;
  final String type;
  final String hostOrganisation;
  final String description;
  final List<String> skills;
  final String experienceLevel;
  final List<String> careerFields;
  final int durationWeeks;
  final int weeklyHoursRequired;
  final DateTime startDate;
  final bool isActive;
  final Map<String, dynamic> rewards;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProgrammeModel({
    this.id,
    required this.title,
    required this.type,
    required this.hostOrganisation,
    required this.description,
    required this.skills,
    required this.experienceLevel,
    required this.careerFields,
    required this.durationWeeks,
    required this.weeklyHoursRequired,
    required this.startDate,
    required this.isActive,
    required this.rewards,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProgrammeModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProgrammeModel(
      id: doc.id,
      title: data['title'] ?? '',
      type: data['type'] ?? '',
      hostOrganisation: data['hostOrganisation'] ?? '',
      description: data['description'] ?? '',
      skills: List<String>.from(data['skills'] ?? []),
      experienceLevel: data['experienceLevel'] ?? '',
      careerFields: List<String>.from(data['careerFields'] ?? []),
      durationWeeks: data['durationWeeks'] ?? 0,
      weeklyHoursRequired: data['weeklyHoursRequired'] ?? 0,
      startDate: (data['startDate'] as Timestamp).toDate(),
      isActive: data['isActive'] ?? false,
      rewards: Map<String, dynamic>.from(data['rewards'] ?? {}),
      createdBy: data['createdBy'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'type': type,
      'hostOrganisation': hostOrganisation,
      'description': description,
      'skills': skills,
      'experienceLevel': experienceLevel,
      'careerFields': careerFields,
      'durationWeeks': durationWeeks,
      'weeklyHoursRequired': weeklyHoursRequired,
      'startDate': startDate,
      'isActive': isActive,
      'rewards': rewards,
      'createdBy': createdBy,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Helper method to get color based on type
  Color getTypeColor() {
    switch (type) {
      case 'Technology':
        return const Color(0xFF0891B2); // kTeal
      case 'Business':
        return const Color(0xFFE0194A); // kPrimary
      case 'Marketing':
        return const Color(0xFFEA580C); // kOrange
      case 'Design':
        return const Color(0xFF9B59B6); // kPurple
      default:
        return const Color(0xFF0891B2);
    }
  }

  // Helper method to get icon based on type
  IconData getTypeIcon() {
    switch (type) {
      case 'Technology':
        return Icons.code_rounded;
      case 'Business':
        return Icons.business_center_rounded;
      case 'Marketing':
        return Icons.trending_up_rounded;
      case 'Design':
        return Icons.palette_rounded;
      default:
        return Icons.school_rounded;
    }
  }

  // Helper method to get tag based on experience level
  String? getTag() {
    switch (experienceLevel) {
      case 'Beginner':
        return 'New';
      case 'Intermediate':
        return 'Popular';
      case 'Advanced':
        return 'Expert';
      default:
        return null;
    }
  }
}