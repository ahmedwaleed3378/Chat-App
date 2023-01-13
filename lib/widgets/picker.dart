import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePick extends StatefulWidget {
  ImagePick(this.imagePickFn);
  final void Function(File pickedImage) imagePickFn;
  @override
  State<ImagePick> createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> {
  File? _pickedimage;
  final ImagePicker imagePicker = ImagePicker();
  Future<void> Picking(ImageSource src) async {
    final pickedImageFile = await imagePicker.pickImage(source: src);
    if (pickedImageFile != null) {
      setState(() {
        _pickedimage = File(pickedImageFile.path);
      });
      widget.imagePickFn(_pickedimage!);
    } else {
      print('no image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedimage != null ? FileImage(_pickedimage!) : null,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(
                        TextStyle(color: Colors.orange[800]))),
                onPressed: () {
                  Picking(ImageSource.camera);
                },
                icon: Icon(Icons.photo_camera_outlined),
                label: Text(
                  'Take a photo',
                  textAlign: TextAlign.center,
                )),
            TextButton.icon(
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(
                        TextStyle(color: Colors.orange[800]))),
                onPressed: () {
                  Picking(ImageSource.gallery);
                },
                icon: Icon(Icons.image_outlined),
                label: Text(
                  'Add a photo',
                  textAlign: TextAlign.center,
                )),
          ],
        )
      ],
    );
  }
}
