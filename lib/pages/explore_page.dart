import 'package:dca/components/voting_system.dart';
import 'package:dca/pages/submission_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dca/components/my_app_bar.dart';
import 'package:dca/components/footer.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  String _searchQuery = '';
  String _sortBy = 'points'; 
  bool _descending = true;
  
  final List<String> _categories = [
    'All',
    'Website',
    'Mobile App',
    'Desktop App',
    'Packages'
  ];

  Stream<QuerySnapshot> get _submissionsStream => FirebaseFirestore.instance
    .collection('submissions')
    .orderBy(_sortBy, descending: _descending)
    .snapshots();

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  // APP BAR
                  Padding(
                    padding: currentWidth > 1200 ? 
                      const EdgeInsets.only(left: 270, right: 270, top: 20) : 
                      const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: const MyAppBar(),
                  ),

                  // Search and Filter Section
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Search Bar
                        SizedBox(
                          width: currentWidth > 1200 ? 400 : 100,
                          child: TextField(
                            controller: _searchController,
                            style: const TextStyle(color: Color.fromARGB(255, 206, 205, 195)),
                            decoration: InputDecoration(
                              hintText: 'Search submissions...',
                              hintStyle: const TextStyle(color: Color.fromARGB(255, 158, 158, 151)),
                              prefixIcon: const Icon(Icons.search, color: Color.fromARGB(255, 158, 158, 151)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: Color.fromARGB(255, 52, 51, 49)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: Color.fromARGB(255, 52, 51, 49)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
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
                        
                        // Category Filter Dropdown
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color.fromARGB(255, 52, 51, 49)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: currentWidth > 1200 ? const EdgeInsets.symmetric(horizontal: 16) : const EdgeInsets.symmetric(horizontal: 8),
                          child: DropdownButton<String>(
                            value: _selectedCategory,
                            dropdownColor: Colors.black,
                            style: const TextStyle(color: Color.fromARGB(255, 206, 205, 195)),
                            underline: Container(),
                            items: _categories.map((String category) {
                              return DropdownMenuItem<String>(
                                value: category,
                                child: Text(category),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedCategory = newValue ?? 'All';
                              });
                            },
                          ),
                        ),

                        const SizedBox(width: 20),

                        // Sort
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color.fromARGB(255, 52, 51, 49)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: currentWidth > 1200 ? const EdgeInsets.symmetric(horizontal: 16) : const EdgeInsets.symmetric(horizontal: 8),
                          child: DropdownButton<String>(
                            value: '${_sortBy}${_descending ? "Desc" : "Asc"}',
                            dropdownColor: Colors.black,
                            style: const TextStyle(color: Color.fromARGB(255, 206, 205, 195)),
                            underline: Container(),
                            items: const [
                              DropdownMenuItem(value: 'pointsDesc', child: Text('Most Votes')),
                              DropdownMenuItem(value: 'pointsAsc', child: Text('Least Votes')),
                              DropdownMenuItem(value: 'submissionDateDesc', child: Text('Newest')),
                              DropdownMenuItem(value: 'submissionDateAsc', child: Text('Oldest')),
                            ],
                            onChanged: (String? newValue) {
                              setState(() {
                                _sortBy = newValue?.replaceAll('Desc', '').replaceAll('Asc', '') ?? 'points';
                                _descending = newValue?.contains('Desc') ?? true;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Submissions Grid
            StreamBuilder<QuerySnapshot>(
              stream: _submissionsStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Color.fromARGB(255, 206, 205, 195)),
                      ),
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 206, 205, 195),
                      ),
                    ),
                  );
                }

                // Filter submissions based on search query and category
                var filteredSubmissions = snapshot.data!.docs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final matchesSearch = _searchQuery.isEmpty ||
                      data['title'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
                      data['description'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
                  final matchesCategory = _selectedCategory == 'All' ||
                      data['category'] == _selectedCategory;
                  return matchesSearch && matchesCategory;
                }).toList();

                if (filteredSubmissions.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Text(
                        'No submissions found',
                        style: TextStyle(color: Color.fromARGB(255, 206, 205, 195)),
                      ),
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1.45,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final data = filteredSubmissions[index].data() as Map<String, dynamic>;
                        final doc = filteredSubmissions[index];
                        return SubmissionCard(
                          title: data['title'] ?? '',
                          description: data['description'] ?? '',
                          thumbnailUrl: data['thumbnailUrl'] ?? '',
                          projectUrl: data['url'] ?? '',
                          category: data['category'] ?? '',
                          projectBy: data['projectBy'] ?? '',
                          country: data['country'] ?? '',
                          id: doc.id,
                          points: (data['points'] ?? 0) as int,
                          votesCount: (data['votesCount'] ?? 0) as int,
                          nominations: (data['nominations'] as List?)?.cast<String>() ?? [],
                          submissionDate: (data['submissionDate'] as Timestamp?)?.toDate(),
                        );
                      },
                      childCount: filteredSubmissions.length,
                    ),
                  ),
                );
              },
            ),

            // Footer
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Footer(),
            ),
          ],
        ),
      ),
    );
  }
}

class SubmissionCard extends StatelessWidget {
  final String id;
  final int points;
  final int votesCount;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String projectUrl;
  final String category;
  final String projectBy;
  final String country;
  final DateTime? submissionDate;
  final List<String> nominations;

  const SubmissionCard({
    super.key,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.projectUrl,
    required this.category,
    required this.projectBy,
    required this.country,
    required this.submissionDate,
    required this.id,
    required this.points,
    required this.votesCount,
    required this.nominations,
  });

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubmissionDetailPage(
              title: title,
              description: description,
              thumbnailUrl: thumbnailUrl,
              projectUrl: projectUrl,
              category: category,
              projectBy: projectBy,
              country: country,
              submissionDate: submissionDate,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 28, 27, 26),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color.fromARGB(255, 52, 51, 49)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail with nominations badge
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).width / 8,
                  width: double.infinity,
                  child: thumbnailUrl.isNotEmpty
                      ? Image.network(
                          thumbnailUrl,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: Colors.grey[900],
                          child: const Center(
                            child: Icon(
                              Icons.image,
                              color: Colors.grey,
                              size: 40,
                            ),
                          ),
                        ),
                ),
                if (nominations.isNotEmpty)
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

            // Content
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
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          category,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 158, 158, 151),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      VotingSystem(
                        projectId: id,
                        currentPoints: points,
                        votesCount: votesCount,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}