import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';

class ChangeProfileImage extends StatefulWidget {
  @override
  _ChangeProfileImageState createState() => _ChangeProfileImageState();
}

class _ChangeProfileImageState extends State<ChangeProfileImage> {
  final cropKey = GlobalKey<CropState>();
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _buildCropImage(image);
    setState(() {
      _image = image;

    });
  }

  Widget _buildCropImage(image) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(20.0),
      child: Crop(
        key: cropKey,
        image: FileImage(image),
        aspectRatio: 1.0 / 1.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Update your Profile Image",
            style: Theme.of(context).textTheme.title),
        SizedBox(height: 20),
        Container(
          height: 180,
          width: 180,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(300),
            child: _image != null
                ? Image.file(_image,fit: BoxFit.cover,)
                : Image.asset(
                    "assets/images/user_default.jpg",
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        SizedBox(height: 20),
        RaisedButton(
          color: Theme.of(context).primaryColor,
          child: Text(
            "Upload image",
            style: Theme.of(context)
                .textTheme
                .title
                .apply(color: Theme.of(context).backgroundColor),
          ),
          onPressed: () {
            getImage();
          },
        ),
      ],
    );
  }
}
