import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dca/components/footer.dart';
import 'package:dca/components/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class SubmitPage extends StatelessWidget {
  SubmitPage({super.key});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

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
        'submissionDate': FieldValue.serverTimestamp(),
      };

      // Add validation
      if (_titleController.text.isEmpty || 
          _urlController.text.isEmpty || 
          _emailController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all required fields')),
        );
        return;
      }

      // Save to Firestore
      await _firestore.collection('submissions').add(submissionData);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submission successful!')),
      );

      // Clear form
      _titleController.clear();
      _categoryController.clear();
      _urlController.clear();
      _descriptionController.clear();
      _nameController.clear();
      _countryController.clear();
      _emailController.clear();

    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting form: ${e.toString()}')),
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
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                focusColor: Color.fromARGB(0, 16, 15, 15),
                fillColor: Color.fromARGB(0, 16, 15, 15),
                hoverColor: Color.fromARGB(0, 16, 15, 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(45),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 52, 51, 49),
                  ),
              )),
              items: [
                DropdownMenuItem(
                  value: "Websites",
                  child: Text("Websites", style: TextStyle(
                    color: Color.fromARGB(255, 206, 205, 195)
                  ),),
                ),

                DropdownMenuItem(
                  value: "Mobiel Apps",
                  child: Text("Mobile Apps", style: TextStyle(
                    color: Color.fromARGB(255, 206, 205, 195)
                  ),),
                ),

                DropdownMenuItem(
                  value: "Desktop Apps",
                  child: Text("Desktop Apps", style: TextStyle(
                    color: Color.fromARGB(255, 206, 205, 195)
                  ),),
                ),

                DropdownMenuItem(
                  value: "Pakages",
                  child: Text("Packeges", style: TextStyle(
                    color: Color.fromARGB(255, 206, 205, 195)
                  ),),
                ),
              ], 
              onChanged: (Object? value) {},
            ),
          ),

          SizedBox(height: 20,),

          Padding(
            padding: EdgeInsets.only(left: mediaQueryData.size.width / 3, right: mediaQueryData.size.width / 3),
            child: TextField(
              controller: _urlController,
              decoration: InputDecoration(
                hintText: "URL (include https://)",
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

          TextButton(
          onPressed: () {
            
          },
           child: Text(
            "Thumbanil (1200 x 697)",
            style: TextStyle(
            color: Color.fromARGB(255, 206, 205, 195),
            ),
          )
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