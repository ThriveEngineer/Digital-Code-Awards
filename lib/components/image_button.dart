import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadButton extends StatefulWidget {
  final Function(String) onImageUploaded;

  const ImageUploadButton({Key? key, required this.onImageUploaded}) : super(key: key);

  @override
  _ImageUploadButtonState createState() => _ImageUploadButtonState();
}

class _ImageUploadButtonState extends State<ImageUploadButton> {
  bool _isUploading = false;
  String? _imageName;
  final ImagePicker _picker = ImagePicker();

  Future<void> _uploadImage() async {
    try {
      // Pick image
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200,
        maxHeight: 697,
      );

      if (pickedFile == null) return;

      setState(() {
        _isUploading = true;
        _imageName = pickedFile.name;
      });

      // Create storage reference
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child('thumbnails/${DateTime.now().millisecondsSinceEpoch}_${pickedFile.name}');

      // Upload file
      if (kIsWeb) {
        // Handle web upload
        final bytes = await pickedFile.readAsBytes();
        await imageRef.putData(bytes);
      } else {
        // Handle mobile upload
        final file = File(pickedFile.path);
        await imageRef.putFile(file);
      }

      // Get download URL
      final downloadUrl = await imageRef.getDownloadURL();

      // Call the callback with the URL
      widget.onImageUploaded(downloadUrl);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image uploaded successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: $e')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 28, 27, 26),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(45),
              side: BorderSide(color: Color.fromARGB(255, 52, 51, 49)),
            ),
          ),
          onPressed: _isUploading ? null : _uploadImage,
          child: _isUploading
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 206, 205, 195),
                  ),
                )
              : Text(
                  "Upload Thumbnail (1200 x 697)",
                  style: TextStyle(
                    color: Color.fromARGB(255, 206, 205, 195),
                  ),
                ),
        ),
        if (_imageName != null && !_isUploading)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Selected: $_imageName',
              style: TextStyle(
                color: Color.fromARGB(255, 206, 205, 195),
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}