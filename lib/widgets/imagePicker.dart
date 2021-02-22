import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as systemPath;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _image;

  Future<void> _takePicture() async {
    final imageFile =
        await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if(imageFile == null){
      return;
    }
    setState(() {
      _image = imageFile;
    });
    final appDir = await systemPath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        height: 100,
        width: 150,
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
        alignment: Alignment.center,
        child: _image != null
            ? Image.file(
                _image,
                fit: BoxFit.cover,
                width: double.infinity,
              )
            : Text(
                'No Image Taken',
                textAlign: TextAlign.center,
              ),
      ),
      SizedBox(
        width: 10,
      ),
      Expanded(
        child: FlatButton.icon(
          onPressed: _takePicture,
          icon: Icon(Icons.camera),
          label: Text('TakePicture'),
          textColor: Theme.of(context).primaryColor,
        ),
      )
    ]);
  }
}
