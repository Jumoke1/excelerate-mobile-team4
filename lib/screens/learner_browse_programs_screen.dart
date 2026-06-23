
// lib/screens/learner_browse_programs_screen.dart
import 'package:flutter/material.dart';
import 'learner_program_details_screen.dart';
import '../models/programme_model.dart';
import '../services/programme_service.dart';

const kPrimary = Color(0xFFE0194A);
const kPurple = Color(0xFF9B59B6);
const kBg = Color(0xFFF7F7F7);
const kCardBg = Colors.white;
const kBorder = Color(0xFFE8E8E8);
const kMutedFg = Color(0xFF949494);
const kFg = Colors.black;
const kTeal = Color(0xFF0891B2);
const kOrange = Color(0xFFEA580C);

class LearnerBrowseProgramsScreen extends StatefulWidget {
  final String? searchQuery;

  const LearnerBrowseProgramsScreen({super.key, this.searchQuery});

  @override
  State<LearnerBrowseProgramsScreen> createState() =>
      _LearnerBrowseProgramsScreenState();
}

class _LearnerBrowseProgramsScreenState
    extends State<LearnerBrowseProgramsScreen> {
  String _selectedFilter = 'All';
  final TextEditingController _searchCtrl = TextEditingController();
  late Future<List<ProgrammeModel>> _programsFuture;

  @override
  void initState() {
    super.initState();
    if (widget.searchQuery != null) {
      _searchCtrl.text = widget.searchQuery!;
    }
    _programsFuture = ProgrammeService().getProgrammes();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            _buildSearchAndFilters(),
            Expanded(child: _buildProgramsGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: kCardBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: kBorder),
                ),
                child: const Icon(Icons.arrow_back, size: 20, color: kFg),
              ),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              'Browse Programs',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: kFg,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: Column(
        children: [
          Container(
            height: 44,
            decoration: BoxDecoration(
              color: kCardBg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kBorder),
            ),
            child: Row(
              children: [
                const SizedBox(width: 12),
                const Icon(Icons.search, color: kMutedFg, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _searchCtrl,
                    onChanged: (_) => setState(() {}),
                    style: const TextStyle(fontSize: 13),
                    decoration: const InputDecoration(
                      hintText: 'Search programs...',
                      hintStyle: TextStyle(color: kMutedFg, fontSize: 13),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 36,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFilterChip('All'),
                const SizedBox(width: 8),
                _buildFilterChip('Technology'),
                const SizedBox(width: 8),
                _buildFilterChip('Business'),
                const SizedBox(width: 8),
                _buildFilterChip('Marketing'),
                const SizedBox(width: 8),
                _buildFilterChip('Design'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => setState(() => _selectedFilter = label),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? kPrimary : kCardBg,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected ? kPrimary : kBorder,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : kFg,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgramsGrid() {
    return FutureBuilder<List<ProgrammeModel>>(
        future: _programsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 48, color: kMutedFg),
                  SizedBox(height: 12),
                  Text(
                    'No programs found',
                    style: TextStyle(
                      fontSize: 14,
                      color: kMutedFg,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }

          final allPrograms = snapshot.data!;
          var filteredPrograms = allPrograms;
          if (_selectedFilter != 'All') {
            filteredPrograms = filteredPrograms
                .where((p) => p.type == _selectedFilter)
                .toList();
          }
          if (_searchCtrl.text.isNotEmpty) {
            final q = _searchCtrl.text.toLowerCase();
            filteredPrograms = filteredPrograms
                .where((p) => p.title.toLowerCase().contains(q))
                .toList();
          }

          if (filteredPrograms.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 48, color: kMutedFg),
                  SizedBox(height: 12),
                  Text(
                    'No programs found for your criteria',
                    style: TextStyle(
                      fontSize: 14,
                      color: kMutedFg,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemCount: filteredPrograms.length,
            itemBuilder: (context, index) {
              return _buildProgramGridCard(filteredPrograms[index]);
            },
          );
        });
  }

  Widget _buildProgramGridCard(ProgrammeModel program) {
    const iconColor = kTeal;

    const progress = 0.0;
    const isStarted = progress > 0;
    final duration = '${program.durationWeeks} weeks';
    const modules = '... modules';

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LearnerProgramDetailsScreen(
                program: program,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: kCardBg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: kBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top color banner with icon
              Container(
                height: 90,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [iconColor, iconColor.withValues(alpha: 0.7)],
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(14),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.school_rounded,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      program.title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: kFg,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.book_outlined,
                            size: 11, color: kMutedFg),
                        const SizedBox(width: 4),
                        const Text(
                          modules,
                          style: TextStyle(
                            fontSize: 10,
                            color: kMutedFg,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            size: 11, color: kMutedFg),
                        const SizedBox(width: 4),
                        Text(
                          duration,
                          style: const TextStyle(
                            fontSize: 10,
                            color: kMutedFg,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (isStarted)
                      Stack(
                        children: [
                          Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: kBg,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: progress,
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: kPrimary,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: kPrimary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'NEW',
                          style: TextStyle(
                            color: kPrimary,
                            fontSize: 8,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
