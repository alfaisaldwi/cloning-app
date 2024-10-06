import 'dart:io';

import 'package:fast8_test/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () async {
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    if (pickedFile != null) {
                      _image = File(pickedFile.path);
                    }
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () async {
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.camera);
                  setState(() {
                    if (pickedFile != null) {
                      _image = File(pickedFile.path);
                    }
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: _image == null
              ? Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      // color: Colors.grey[300],
                      child: Icon(Icons.camera_alt, size: 50),
                    ),
                    buildHorizontalSpacer(12),
                    Text('Upload KTP')
                  ],
                )
              : Image.file(_image!, height: 150, width: 150, fit: BoxFit.cover),
        ),
      ],
    );
  }
}
