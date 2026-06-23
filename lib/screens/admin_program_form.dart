import 'package:flutter/material.dart';

class AdminProgramForm extends StatefulWidget {
  const AdminProgramForm({super.key});

  @override
  State<AdminProgramForm> createState() => _AdminProgramFormState();
}

class _AdminProgramFormState extends State<AdminProgramForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController =
      TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();

  String? _selectedProgramType;

  DateTime? _startDate;
  DateTime? _deadlineDate;

  final List<String> _programTypes = [
    'Internship',
    'Course',
    'Bootcamp',
    'Workshop',
    'Certification',
    'Other',
  ];

  Future<void> _pickDate(bool isStartDate) async {
    DateTime initialDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _deadlineDate = picked;
        }
      });
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();

    _titleController.clear();
    _descriptionController.clear();
    _durationController.clear();
    _skillsController.clear();

    setState(() {
      _selectedProgramType = null;
      _startDate = null;
      _deadlineDate = null;
    });
  }

  Future<void> _submitForm() async {
  if (_formKey.currentState!.validate()) {
    try {
      Map<String, dynamic> programData = {
        "title": _titleController.text.trim(),
        "type": _selectedProgramType,
        "description": _descriptionController.text.trim(),
        "duration": _durationController.text.trim(),
        "skills": _skillsController.text.trim(),
        "startDate": _startDate?.toIso8601String(),
        "deadline": _deadlineDate?.toIso8601String(),
        "createdAt": FieldValue.serverTimestamp(), // tracks when it was added
      };

      await FirebaseFirestore.instance
          .collection('programs') // your Firestore collection
          .add(programData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Program Submitted Successfully")),
      );

      _resetForm();

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }
}

  String formatDate(DateTime? date) {
    if (date == null) return "Select Date";
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Program"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [

                  // Program Name
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: "Program Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Enter program name" : null,
                  ),

                  const SizedBox(height: 16),

                  // Program Type
                  DropdownButtonFormField<String>(
                    value: _selectedProgramType,
                    decoration: const InputDecoration(
                      labelText: "Program Type",
                      border: OutlineInputBorder(),
                    ),
                    items: _programTypes
                        .map(
                          (type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedProgramType = value;
                      });
                    },
                    validator: (value) =>
                        value == null ? "Select program type" : null,
                  ),

                  const SizedBox(height: 16),

                  // Description
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Enter description" : null,
                  ),

                  const SizedBox(height: 16),

                  // Duration
                  TextFormField(
                    controller: _durationController,
                    decoration: const InputDecoration(
                      labelText: "Duration",
                      hintText: "e.g. 12 Weeks",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Enter duration" : null,
                  ),

                  const SizedBox(height: 16),

                  // Skills
                  TextFormField(
                    controller: _skillsController,
                    decoration: const InputDecoration(
                      labelText: "Required Skills",
                      hintText: "Flutter, Firebase, UI/UX",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Start Date
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.grey),
                    ),
                    title: Text(
                      "Start Date: ${formatDate(_startDate)}",
                    ),
                    trailing: const Icon(Icons.calendar_month),
                    onTap: () => _pickDate(true),
                  ),

                  const SizedBox(height: 16),

                  // Deadline
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.grey),
                    ),
                    title: Text(
                      "Application Deadline: ${formatDate(_deadlineDate)}",
                    ),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () => _pickDate(false),
                  ),

                  const SizedBox(height: 30),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          child: const Text("Submit"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _resetForm,
                          child: const Text("Reset"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}