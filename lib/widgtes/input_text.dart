import 'package:flutter/material.dart';

class TextFielInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final Icon icon;
  const TextFielInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false ,
    required this.hintText,
    required this.textInputType,
    required this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context)
    );

    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(8),
        prefixIcon: icon,
        
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}