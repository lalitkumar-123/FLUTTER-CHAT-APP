import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePicker extends StatefulWidget {
  ImagePicker(this.imagePickerFn);

  final void Function(File pickedimage) imagePickerFn;

  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  File _imagepic;

  void _pickimage() async {
    final imagepicked = await ImagePicker().getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxWidth: 150,
    );
    setState(() {
      _imagepic = imagepicked;
    });
    widget.imagePickerFn(_imagepic);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(radius: 25, backgroundImage: _imagepic!=null ? FileImage(_imagepic) : null),
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: _pickimage,
          icon: Icon(Icons.image),
          label: Text("Add Image"),
        ),
      ]
    );
  }
}
