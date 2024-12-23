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
  
  final List<String> _categories = [
    'All',
    'Website',
    'Mobile App',
    'Desktop App',
    'Packages'
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // APP BAR
          Padding(
            padding: const EdgeInsets.only(left: 270, right: 270, top: 20),
            child: MyAppBar(),
          ),

          // Search and Filter Section
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Search Bar
                Container(
                  width: 400,
                  child: TextField(
                    controller: _searchController,
                    style: TextStyle(color: Color.fromARGB(255, 206, 205, 195)),
                    decoration: InputDecoration(
                      hintText: 'Search submissions...',
                      hintStyle: TextStyle(color: Color.fromARGB(255, 158, 158, 151)),
                      prefixIcon: Icon(Icons.search, color: Color.fromARGB(255, 158, 158, 151)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                        borderSide: BorderSide(color: Color.fromARGB(255, 52, 51, 49)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                        borderSide: BorderSide(color: Color.fromARGB(255, 52, 51, 49)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                        borderSide: BorderSide(color: Color.fromARGB(255, 206, 205, 195)),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
                
                SizedBox(width: 20),
                
                // Category Filter Dropdown
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 52, 51, 49)),
                    borderRadius: BorderRadius.circular(45),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    dropdownColor: Colors.black,
                    style: TextStyle(color: Color.fromARGB(255, 206, 205, 195)),
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
              ],
            ),
          ),

          // Submissions Grid
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('submissions').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(color: Color.fromARGB(255, 206, 205, 195)),
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 206, 205, 195),
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
                  return Center(
                    child: Text(
                      'No submissions found',
                      style: TextStyle(color: Color.fromARGB(255, 206, 205, 195)),
                    ),
                  );
                }

                return GridView.builder(
                  padding: EdgeInsets.all(20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1.45,
                  ),
                  itemCount: filteredSubmissions.length,
                  itemBuilder: (context, index) {
                    final data = filteredSubmissions[index].data() as Map<String, dynamic>;
                    return SubmissionCard(
                      title: data['title'] ?? '',
                      description: data['description'] ?? '',
                      thumbnailUrl: data['thumbnailUrl'] ?? '',
                      projectUrl: data['url'] ?? '',
                      category: data['category'] ?? '',
                      projectBy: data['projectBy'] ?? '',
                      country: data['country'] ?? '',
                      submissionDate: data['submissionDate'].toDate(),
                    );
                  },
                );
              },
            ),
          ),

          // Footer
          Footer(),
        ],
      ),
    );
  }
}

class SubmissionCard extends StatelessWidget {
  final String title;
  final String description;
  final String thumbnailUrl;
  final String projectUrl;
  final String category;
  final String projectBy;
  final String country;
  final DateTime? submissionDate;

  const SubmissionCard({
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.projectUrl,
    required this.category,
    required this.projectBy,
    required this.country,
    required this.submissionDate,
  });

  @override
  Widget build(BuildContext context) {
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
            country: country, // Make sure to pass this from your card data
            submissionDate: submissionDate, // And this as well
          ),
        ),
      );
    },
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 28, 27, 26),
          borderRadius: BorderRadius.circular(15),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            Expanded(
              child: thumbnailUrl.isNotEmpty
                  ? Image.network(
                      thumbnailUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: Colors.grey[900],
                      child: Center(
                        child: Icon(
                          Icons.image,
                          color: Colors.grey[700],
                          size: 40,
                        ),
                      ),
                    ),
            ),
      
            // Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Color.fromARGB(255, 206, 205, 195),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Color.fromARGB(255, 158, 158, 151),
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'By $projectBy',
                        style: TextStyle(
                          color: Color.fromARGB(255, 158, 158, 151),
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color: Color.fromARGB(255, 158, 158, 151),
                            fontSize: 12,
                          ),
                        ),
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