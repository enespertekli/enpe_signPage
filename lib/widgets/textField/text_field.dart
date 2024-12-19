import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class PTextField extends StatelessWidget {
  const PTextField({
    super.key,
    required this.controller,
    required this.text,
    this.prefixIcon,
    this.suffixIcon,
    this.fontSize = PSizes.fontSizeMd,
    this.validator,
    this.onpressed,
    this.obscureText=false, this.keyboardType ,
  });

  final TextEditingController controller;
  final String text;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final double? fontSize;
  final String? Function(String?)? validator;
  final Function()? onpressed;
  final bool obscureText;
  final TextInputType? keyboardType;
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType:keyboardType ,
      obscureText: obscureText,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        labelText: text,
        labelStyle: TextStyle(fontSize: fontSize),
        border: const OutlineInputBorder(),
        prefixIcon: Icon(
          prefixIcon,
          color: PColors.primary,
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(PSizes.borderRadiusMd),
          borderSide: BorderSide(color: PColors.primary.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(PSizes.borderRadiusMd),
          borderSide: BorderSide(color: PColors.primary.withOpacity(0.7)),
        ),
      ),
    );
  }
}
