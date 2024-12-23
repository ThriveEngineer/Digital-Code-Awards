import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dca/components/footer.dart';
import 'package:dca/components/image_button.dart';
import 'package:dca/components/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class SubmitPage extends StatefulWidget {
  SubmitPage({super.key});

  @override
  State<SubmitPage> createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _categoryController = TextEditingController();

  final TextEditingController _urlController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _countryController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

  String? _thumbnailUrl;

  // Reference to Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to submit data to Firebase
  Future<void> _submitForm(BuildContext context) async {
  try {
    // Create a data object
    final submissionData = {
      'title': _titleController.text,
      'category': _categoryController.text,
      'url': _urlController.text,
      'description': _descriptionController.text,
      'projectBy': _nameController.text,
      'country': _countryController.text,
      'email': _emailController.text,
      'thumbnailUrl': _thumbnailUrl,
      'submissionDate': FieldValue.serverTimestamp(),
    };

    // Add validation
    if (_titleController.text.isEmpty || 
        _nameController.text.isEmpty || 
        _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    print('Attempting to save to Firestore...'); // Debug log

    // Save to Firestore - this will automatically create the collection
    await FirebaseFirestore.instance
        .collection('submissions')
        .add(submissionData);

    print('Successfully saved to Firestore'); // Debug log

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Submission successful!'),
        backgroundColor: Colors.green,
      ),
    );

    // Clear form
    _titleController.clear();
    _urlController.clear();
    _descriptionController.clear();
    _nameController.clear();
    _countryController.clear();
    _emailController.clear();

  } catch (e) {
    print('Error details: $e'); // Debug log
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error submitting form: ${e.toString()}'),
        backgroundColor: Colors.red,
      ),
    );
  }
}

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

      // Site
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(height: 200,),

                  SelectableText("Submit", style: TextStyle(
                    color: Color.fromARGB(255, 206, 205, 195),
                    fontSize: 50,
                    fontWeight: FontWeight.bold
                  ),),

                  SizedBox(height: 20,),

          SelectableText("Submit to get the chance to win an award", style: TextStyle(
            color: Color.fromARGB(255, 158, 158, 151),
            fontSize: 25,
            fontWeight: FontWeight.w600
          ),),

          SizedBox(height: 80,),

          Padding(
            padding: EdgeInsets.only(left: mediaQueryData.size.width / 3, right: mediaQueryData.size.width / 3),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "Title",
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 206, 205, 195),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(45),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 52, 51, 49),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 206, 205, 195),
                  ),
                  borderRadius: BorderRadius.circular(45)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 206, 205, 195),
                  ),
                  borderRadius: BorderRadius.circular(45)
                ),
              ),
            ),
          ),

          SizedBox(height: 20,),

          Padding(
            padding: EdgeInsets.only(left: mediaQueryData.size.width / 3, right: mediaQueryData.size.width / 3),
            child: TextField(
              controller: _categoryController,
              decoration: InputDecoration(
                hintText: "Category | Categories: Website, Mobile App, Desktop App, Package",
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 206, 205, 195),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(45),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 52, 51, 49),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 206, 205, 195),
                  ),
                  borderRadius: BorderRadius.circular(45)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 206, 205, 195),
                  ),
                  borderRadius: BorderRadius.circular(45)
                ),
              ),
            ),
          ),

          SizedBox(height: 20,),

          Padding(
            padding: EdgeInsets.only(left: mediaQueryData.size.width / 3, right: mediaQueryData.size.width / 3),
            child: TextField(
              controller: _urlController,
              decoration: InputDecoration(
                hintText: "URL (include https://) | When it's not a website just write URL in this field",
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 206, 205, 195),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(45),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 52, 51, 49),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 206, 205, 195),
                  ),
                  borderRadius: BorderRadius.circular(45)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 206, 205, 195),
                  ),
                  borderRadius: BorderRadius.circular(45)
                ),
              ),
            ),
          ),

          SizedBox(height: 20,),

          Padding(
            padding: EdgeInsets.only(left: mediaQueryData.size.width / 3, right: mediaQueryData.size.width / 3),
            child: TextField(
              maxLength: 35,
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: "Short Description",
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 206, 205, 195),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(45),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 52, 51, 49),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 206, 205, 195),
                  ),
                  borderRadius: BorderRadius.circular(45)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 206, 205, 195),
                  ),
                  borderRadius: BorderRadius.circular(45)
                ),
              ),
            ),
          ),

          ImageUploadButton(
            onImageUploaded: (String url) {
              setState(() {
                _thumbnailUrl = url;
              });
            },
          ),

          SizedBox(height: 20,),

          Padding(
            padding: EdgeInsets.only(left: mediaQueryData.size.width / 3, right: mediaQueryData.size.width / 3),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Project by",
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 206, 205, 195),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(45),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 52, 51, 49),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 206, 205, 195),
                  ),
                  borderRadius: BorderRadius.circular(45)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 206, 205, 195),
                  ),
                  borderRadius: BorderRadius.circular(45)
                ),
              ),
            ),
          ),

          SizedBox(height: 20,),

          Padding(
            padding: EdgeInsets.only(left: mediaQueryData.size.width / 3, right: mediaQueryData.size.width / 3),
            child: TextField(
              controller: _countryController,
              decoration: InputDecoration(
                hintText: "Country",
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 206, 205, 195),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(45),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 52, 51, 49),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 206, 205, 195),
                  ),
                  borderRadius: BorderRadius.circular(45)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 206, 205, 195),
                  ),
                  borderRadius: BorderRadius.circular(45)
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),

          Padding(
            padding: EdgeInsets.only(left: mediaQueryData.size.width / 3, right: mediaQueryData.size.width / 3),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Email",
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 206, 205, 195),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(45),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 52, 51, 49),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 206, 205, 195),
                  ),
                  borderRadius: BorderRadius.circular(45)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 206, 205, 195),
                  ),
                  borderRadius: BorderRadius.circular(45)
                ),
              ),
            ),
          ),

          SizedBox(height: 45,),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              overlayColor: Color.fromARGB(255, 206, 205, 195),
              backgroundColor: Color.fromARGB(255, 28, 27, 26),
              fixedSize: Size(150, 50),
              side: BorderSide(
                color: Color.fromARGB(255, 52, 51, 49),),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(45),
              ),
            ),
            onPressed: () => _submitForm(context), 
            child: Text(
              "Submit",
              style: TextStyle(
                color: Color.fromARGB(255, 206, 205, 195),
              ),
            )
          ),

            SizedBox(height: 100,),

            Footer(),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}