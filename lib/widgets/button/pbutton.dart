// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class PButton extends StatelessWidget {
  const PButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = PColors.primary,
    this.textColor = PColors.white,
    this.textSize = PSizes.fontSizeLg,
    this.width,
  });
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? textSize;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 135.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          
            padding: EdgeInsets.all(PSizes.xsH),
            backgroundColor: backgroundColor,
            overlayColor: PColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(PSizes.borderRadiusMd),
            )),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: textSize),
        ),
      ),
    );
  }
}
