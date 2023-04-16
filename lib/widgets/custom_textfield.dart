import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField1 extends StatelessWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? title;
  final EdgeInsetsGeometry? contentPadding;
  final bool obscureText;
  final TextEditingController? controller;
  final Color? fillColor;
  final bool readOnly;
  final bool? showCursor;
  final FormFieldValidator<String>? validator;
  final void Function()? onTap;

  const CustomTextField1({
    Key? key,
    this.onTap,
    this.showCursor,
    this.readOnly = false,
    this.fillColor,
    this.contentPadding = const EdgeInsets.fromLTRB(10, 13.5, 10, 13.5),
    this.controller,
    this.suffixIcon,
    this.obscureText = false,
    this.hintText,
    this.prefixIcon,
    this.title,
    this.validator
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: const TextStyle(color: Color(0xff858597), fontSize: 12),
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onTap: onTap,
          showCursor: showCursor,
          readOnly: readOnly,
          validator: validator,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            prefixIcon: prefixIcon,
            contentPadding: contentPadding,
            suffixIcon: suffixIcon,
            // suffixIconConstraints: BoxConstraints.expand(width: 40),
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            errorStyle: TextStyle(
              color: Colors.red,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffB8B8D2)),
              borderRadius: BorderRadius.circular(6),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Get.theme.primaryColor),
              borderRadius: BorderRadius.circular(6),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade700),
              borderRadius: BorderRadius.circular(6),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade700, width: 1.5),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      ],
    );
  }
}
