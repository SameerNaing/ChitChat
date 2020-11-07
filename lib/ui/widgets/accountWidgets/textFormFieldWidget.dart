import 'package:flutter/material.dart';

import 'package:chit_chat/ui/ui.dart';

class TextFormFieldWidget extends StatelessWidget {
  final Function onSave;
  final Function validate;
  final Function onChange;
  final String hintText;
  final bool isPassword;
  final bool space;

  const TextFormFieldWidget(
      {Key key,
      this.hintText,
      this.isPassword,
      this.space,
      this.onChange,
      this.onSave,
      this.validate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: getPropWidth(20),
        left: getPropWidth(20),
      ),
      child: SizedBox(
        height: getPropHeight(space ? 80 : 53),
        child: TextFormField(
          onChanged: onChange,
          onSaved: onSave,
          validator: validate,
          style: TextStyle(color: aColor2, fontFamily: 'Roboto'),
          obscureText: isPassword ?? true,
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
            hintText: hintText ?? '',
            contentPadding: EdgeInsets.symmetric(horizontal: getPropWidth(20)),
          ),
        ),
      ),
    );
  }
}
