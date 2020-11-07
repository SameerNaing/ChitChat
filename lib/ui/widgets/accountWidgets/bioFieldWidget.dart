import 'package:flutter/material.dart';

import 'package:chit_chat/ui/ui.dart';

class BioFieldWidget extends StatelessWidget {
  final Function onSave;
  final Function validate;

  const BioFieldWidget({Key key, this.onSave, this.validate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: getPropWidth(20),
        left: getPropWidth(20),
      ),
      child: SizedBox(
        height: getPropHeight(110),
        child: TextFormField(
          maxLines: 4,
          maxLength: 60,
          onSaved: onSave,
          validator: validate,
          style: TextStyle(color: aColor2, fontFamily: 'Roboto'),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: aColor2.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(20),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: aColor2.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(20),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: errorColor),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: errorColor),
              borderRadius: BorderRadius.circular(20),
            ),
            labelText: 'Bio',
            contentPadding: EdgeInsets.symmetric(
                horizontal: getPropWidth(20), vertical: getPropHeight(15)),
          ),
        ),
      ),
    );
  }
}
