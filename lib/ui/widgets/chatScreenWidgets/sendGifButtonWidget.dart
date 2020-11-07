import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chit_chat/ui/ui.dart';
import 'package:giphy_picker/giphy_picker.dart';
import 'package:chit_chat/constants/stringConstants.dart';
import 'package:chit_chat/blocs/blocs.dart';

class SendGifButtonWidget extends StatelessWidget {
  const SendGifButtonWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickGif(context),
      child: Container(
        height: getPropHeight(25),
        width: getPropWidth(25),
        decoration: BoxDecoration(
          border: Border.all(color: pColor1),
        ),
        child: SvgPicture.asset(
          'assets/SvgIcons/gif.svg',
          color: pColor1,
          height: getPropHeight(15),
          width: getPropWidth(15),
        ),
      ),
    );
  }

  _pickGif(BuildContext context) async {
    final gif = await GiphyPicker.pickGif(
      context: context,
      apiKey: GIPHY_APIKEY,
    );
    if (gif != null) {
      BlocProvider.of<MessageBloc>(context)
          .add(SendGif(url: gif.images.original.url));
    }
  }
}
