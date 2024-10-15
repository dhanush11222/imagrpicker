//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
//
//
// class ImagePickerDemo extends StatefulWidget {
//   @override
//   _ImagePickerDemoState createState() => _ImagePickerDemoState();
// }
//
// class _ImagePickerDemoState extends State<ImagePickerDemo> {
//   final ImagePicker _picker = ImagePicker();
//   ValueNotifier<File?> _imageNotifier = ValueNotifier<File?>(null);
//
//   // Function to pick image from gallery
//   Future<void> _pickFromGallery() async {
//     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       _imageNotifier.value = File(pickedFile.path);
//     }
//   }
//
//   // Function to capture image using camera
//   Future<void> _pickFromCamera() async {
//     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       _imageNotifier.value = File(pickedFile.path);
//     }
//   }
//
//   // Function to show dialog with options
//   void _showPickerOptions(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext bc) {
//         return SafeArea(
//           child: Wrap(
//             children: <Widget>[
//               ListTile(
//                 leading: Icon(Icons.photo_library, color: Colors.blueAccent),
//                 title: Text('Gallery'),
//                 onTap: () {
//                   _pickFromGallery();
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.camera_alt, color: Colors.blueAccent),
//                 title: Text('Camera'),
//                 onTap: () {
//                   _pickFromCamera();
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Image Picker"),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Instruction texts
//             Text(
//               "Capture or Select Document",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               "Make sure the photo is clear and readable",
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[700],
//               ),
//             ),
//             SizedBox(height: 30),
//
//             // GestureDetector for tapping the container to pick image
//             GestureDetector(
//               onTap: () {
//                 _showPickerOptions(context); // Show camera and gallery options
//               },
//               child: Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Container(
//                   width: double.infinity,
//                   height: 200,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: Colors.grey[200], // Light grey background color
//                   ),
//                   child: Center(
//                     child: ValueListenableBuilder<File?>(
//                       valueListenable: _imageNotifier,
//                       builder: (context, _image, child) {
//                         return _image == null
//                             ? Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.camera_alt,
//                               size: 50,
//                               color: Colors.grey[700], // Icon color
//                             ),
//                             SizedBox(height: 10),
//                             Text(
//                               "Tap to Capture",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.grey[700], // Text color
//                               ),
//                             ),
//                           ],
//                         )
//                             : ClipRRect(
//                           borderRadius: BorderRadius.circular(15),
//                           child: Image.file(
//                             _image,
//                             width: double.infinity,
//                             height: double.infinity,
//                             fit: BoxFit.cover,
//                           ),
//                         ); // Display the selected image
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _imageNotifier.dispose(); // Clean up the notifier when the widget is removed
//     super.dispose();
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     home: ImagePickerDemo(),
//     debugShowCheckedModeBanner: false,
//   ));
// }
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerDemo extends StatefulWidget {
  @override
  _ImagePickerDemoState createState() => _ImagePickerDemoState();
}

class _ImagePickerDemoState extends State<ImagePickerDemo> {
  final ImagePicker _picker = ImagePicker();
  final ValueNotifier<File?> _imageNotifier = ValueNotifier<File?>(null); // Using ValueNotifier

  // Pick an image from the gallery
  Future<void> _pickFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imageNotifier.value = File(pickedFile.path);
    }
  }

  // Capture an image using the camera
  Future<void> _pickFromCamera() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _imageNotifier.value = File(pickedFile.path);
    }
  }

  // Display picker options (camera or gallery)
  void _showPickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: [
              _buildOption(Icons.photo_library, 'Gallery', _pickFromGallery),
              _buildOption(Icons.camera_alt, 'Camera', _pickFromCamera),
            ],
          ),
        );
      },
    );
  }

  // Build picker option (Gallery or Camera)
  Widget _buildOption(IconData icon, String label, Function onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(label),
      onTap: () {
        onTap();
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Picker"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Instruction texts
            Text(
              "Capture or Select Document",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 8),
            Text(
              "Make sure the photo is clear and readable",
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            SizedBox(height: 30),

            // Image container with tap to pick option
            GestureDetector(
              onTap: () {
                _showPickerOptions(context); // Show picker options
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[200], // Light grey background color
                  ),
                  child: Center(
                    child: ValueListenableBuilder<File?>(
                      valueListenable: _imageNotifier,
                      builder: (context, _image, child) {
                        return _image == null
                            ? _buildPlaceholder() // Show placeholder if no image
                            : _buildImageDisplay(_image); // Show image if picked
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build the image placeholder when no image is selected
  Widget _buildPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.camera_alt, size: 50, color: Colors.grey[700]),
        SizedBox(height: 10),
        Text("Tap to Capture", style: TextStyle(fontSize: 16, color: Colors.grey[700])),
      ],
    );
  }

  // Build the image display widget after image selection
  Widget _buildImageDisplay(File _image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.file(
        _image,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  void dispose() {
    _imageNotifier.dispose(); // Clean up the notifier when the widget is disposed
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: ImagePickerDemo(),
    debugShowCheckedModeBanner: false,
  ));
}
