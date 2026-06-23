// lib/screens/admin/admin_programs_screen.dart
import 'package:flutter/material.dart';
import '../../../widgets/admin_bottom_nav.dart';
import 'admin_home_screen.dart';

//import model and services 
import '../services/programme_service.dart';
import '../models/programme_model.dart';

// create connection to backend services
final ProgrammeService programmeService = ProgrammeService();

class AdminProgramsScreen extends StatelessWidget {
  const AdminProgramsScreen({super.key});

    //helper function so ui can call services 
   Future<List<ProgrammeModel>>getPrograms() {
     return programmeService.getProgrammes();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text('Programs',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const AdminHomeScreen()),
            );
          },
        ),
      ),


      //brige between the backend and ui 
       body: FutureBuilder<List<ProgrammeModel>>(
        future: getPrograms(),
        builder: (context, snapshot) {

            //loading state 
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

            //handles empty cases, when firestore returns nothing 
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No programs found"));
          }

            //extact data from fire store
          final programs = snapshot.data!;

          //data list that was extracted 
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: programs.length,
            itemBuilder: (context, index) {
              final program = programs[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(program.title),
                  subtitle: Text(program.hostOrganisation),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
              );
            },
          );
        },
      ),


      bottomNavigationBar: const AdminBottomNav(
        currentDestination: AdminNavDestination.programs,
      ),
    );
  }
}
