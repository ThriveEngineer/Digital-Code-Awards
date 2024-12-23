import 'package:flutter/material.dart';
import 'package:dca/components/my_app_bar.dart';
import 'package:dca/components/footer.dart';
import 'package:url_launcher/url_launcher.dart';

class SubmissionDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String thumbnailUrl;
  final String projectUrl;
  final String category;
  final String projectBy;
  final String country;
  final DateTime? submissionDate;

  const SubmissionDetailPage({
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.projectUrl,
    required this.category,
    required this.projectBy,
    required this.country,
    this.submissionDate,
  });

  Future<void> _launchURL() async {
    if (!await launchUrl(Uri.parse(projectUrl))) {
      throw Exception('Could not launch $projectUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // APP BAR
          Padding(
            padding: const EdgeInsets.only(left: 270, right: 270, top: 20),
            child: MyAppBar(),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Back Button
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back, 
                          color: Color.fromARGB(255, 206, 205, 195)),
                        label: Text('Back to Explore',
                          style: TextStyle(
                            color: Color.fromARGB(255, 206, 205, 195)
                          )),
                      ),
                    ),
                  ),

                  // Title
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Color.fromARGB(255, 206, 205, 195),
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // Metadata Row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildMetadataItem(Icons.person, projectBy),
                        _buildMetadataItem(Icons.location_on, country),
                        _buildMetadataItem(Icons.category, category),
                        if (submissionDate != null)
                          _buildMetadataItem(
                            Icons.calendar_today,
                            submissionDate!.toLocal().toString().split(' ')[0],
                          ),
                      ],
                    ),
                  ),

                  // Thumbnail Image
                  if (thumbnailUrl.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.network(
                          thumbnailUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                  // Description
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.2,
                      vertical: 20,
                    ),
                    child: Text(
                      description,
                      style: TextStyle(
                        color: Color.fromARGB(255, 158, 158, 151),
                        fontSize: 18,
                        height: 1.6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // Visit Project Button
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 28, 27, 26),
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                          side: BorderSide(
                            color: Color.fromARGB(255, 52, 51, 49),
                          ),
                        ),
                      ),
                      onPressed: _launchURL,
                      child: Text(
                        'Visit Project',
                        style: TextStyle(
                          color: Color.fromARGB(255, 206, 205, 195),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Footer
          Footer(),
        ],
      ),
    );
  }

  Widget _buildMetadataItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Color.fromARGB(255, 158, 158, 151),
            size: 16,
          ),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: Color.fromARGB(255, 158, 158, 151),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}