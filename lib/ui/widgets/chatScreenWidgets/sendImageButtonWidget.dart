import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:chit_chat/blocs/blocs.dart';

class SendImageButtonWidget extends StatelessWidget {
  ImagePicker _picker = ImagePicker();
  SendImageButtonWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDialog(context),
      child: SvgPicture.asset(
        'assets/SvgIcons/image-gallery.svg',
        color: pColor1,
        height: getPropHeight(25),
        width: getPropWidth(25),
      ),
    );
  }

  _pickImage(BuildContext context, ImageSource source) async {
    PickedFile pickedImage = await _picker.getImage(source: source);
    if (pickedImage != null) {
      File file = File(pickedImage.path);
      BlocProvider.of<MessageBloc>(context).add(SendImage(image: file));
    }
  }

  _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Choose'),
            content: Row(
              children: [
                Spacer(flex: 1),
                Container(
                  height: getPropHeight(100),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          _pickImage(context, ImageSource.camera);
                        },
                        child: Icon(Icons.camera, size: getPropWidth(50)),
                      ),
                      SizedBox(height: getPropHeight(12)),
                      Text('Camera')
                    ],
                  ),
                ),
                Spacer(flex: 2),
                Container(
                  height: getPropHeight(100),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          _pickImage(context, ImageSource.gallery);
                        },
                        child: Icon(Icons.photo_album, size: getPropWidth(50)),
                      ),
                      SizedBox(height: getPropHeight(12)),
                      Text('Photo Library')
                    ],
                  ),
                ),
                Spacer(flex: 1),
              ],
            ),
            actions: [
              FlatButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });
  }
}
