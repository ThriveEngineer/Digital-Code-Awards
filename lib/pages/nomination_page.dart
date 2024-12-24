import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NominationPage extends StatefulWidget {
  const NominationPage({super.key});

  @override
  State<NominationPage> createState() => _NominationPageState();
}

class _NominationPageState extends State<NominationPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'Best App';
  
  final List<String> _nominationCategories = [
    'Best App',
    'Best Website',
    'Best Package',
    'Best Desktop App',
    'Best Designed App',
    'Best Designed Website',
    'Best Designed Desktop App',
    'Most Innovative App',
    'Most Innovative Website',
    'Most Innovative Desktop App',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nominations'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 400,
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Color.fromARGB(255, 206, 205, 195)),
                      decoration: InputDecoration(
                        hintText: 'Search projects to nominate...',
                        hintStyle: const TextStyle(color: Color.fromARGB(255, 158, 158, 151)),
                        prefixIcon: const Icon(Icons.search, color: Color.fromARGB(255, 158, 158, 151)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(45),
                          borderSide: const BorderSide(color: Color.fromARGB(255, 52, 51, 49)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(45),
                          borderSide: const BorderSide(color: Color.fromARGB(255, 52, 51, 49)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(45),
                          borderSide: const BorderSide(color: Color.fromARGB(255, 206, 205, 195)),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
                  ),
                  
                  const SizedBox(width: 20),
                  
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color.fromARGB(255, 52, 51, 49)),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DropdownButton<String>(
                      value: _selectedCategory,
                      dropdownColor: Colors.black,
                      style: const TextStyle(color: Color.fromARGB(255, 206, 205, 195)),
                      underline: Container(),
                      items: _nominationCategories.map((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCategory = newValue ?? 'Best App';
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('submissions').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong'));
                  }

                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  var filteredProjects = snapshot.data!.docs.where((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return _searchQuery.isEmpty ||
                        data['title'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
                        data['description'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
                  }).toList();

                  if (filteredProjects.isEmpty) {
                    return const Center(child: Text('No projects found'));
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1.45,
                    ),
                    itemCount: filteredProjects.length,
                    itemBuilder: (context, index) {
                      final data = filteredProjects[index].data() as Map<String, dynamic>;
                      final projectId = filteredProjects[index].id;
                      final nominations = (data['nominations'] as List?)?.cast<String>() ?? [];

                      return NominationCard(
                        projectId: projectId,
                        title: data['title'] ?? '',
                        description: data['description'] ?? '',
                        thumbnailUrl: data['thumbnailUrl'] ?? '',
                        category: data['category'] ?? '',
                        projectBy: data['projectBy'] ?? '',
                        isNominated: nominations.contains(_selectedCategory),
                        onNominate: () => _nominateProject(projectId, _selectedCategory),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _nominateProject(String projectId, String category) async {
    final projectRef = FirebaseFirestore.instance.collection('submissions').doc(projectId);
    
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(projectRef);
      final nominations = (snapshot.data()?['nominations'] as List?)?.cast<String>() ?? [];
      
      if (!nominations.contains(category)) {
        nominations.add(category);
        transaction.update(projectRef, {'nominations': nominations});
      }
    });
  }
}

class NominationCard extends StatelessWidget {
  final String projectId;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String category;
  final String projectBy;
  final bool isNominated;
  final VoidCallback onNominate;

  const NominationCard({
    super.key,
    required this.projectId,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.category,
    required this.projectBy,
    required this.isNominated,
    required this.onNominate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 28, 27, 26),
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 150,
            child: Stack(
              children: [
                if (thumbnailUrl.isNotEmpty)
                  Image.network(
                    thumbnailUrl,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  )
                else
                  Container(
                    color: Colors.grey[900],
                    child: const Center(
                      child: Icon(
                        Icons.image,
                        color: Colors.grey,
                        size: 40,
                      ),
                    ),
                  ),
                if (isNominated)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Nominated',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 206, 205, 195),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 158, 158, 151),
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'By $projectBy',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 158, 158, 151),
                        fontSize: 12,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: isNominated ? null : onNominate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isNominated ? Colors.grey : Colors.amber,
                        foregroundColor: Colors.black,
                      ),
                      child: Text(isNominated ? 'Nominated' : 'Nominate'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}