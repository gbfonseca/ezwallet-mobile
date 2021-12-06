import 'package:flutter/material.dart';

import '../../utils/constants/sizes.dart';
import '../../utils/ui/colors.dart';

class TitleWidget extends StatelessWidget {
  String text;
  TitleWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(
            color: ColorConstants.kFontColor,
            fontSize: FontSizeConstants.s32,
            fontWeight: FontWeight.bold),
      );
}
