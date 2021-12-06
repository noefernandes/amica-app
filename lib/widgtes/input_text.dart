import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  String labelText;
  String? validator;
  TextInputType? textInputType;
  final IconData? prefixIcon;
  InputText({Key? key, required this.labelText, this.validator, this.textInputType, this.prefixIcon }) : super(key: key);

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  TextEditingController inputController = TextEditingController();

  InputDecoration buildTextInputDecoration(String labelText, TextEditingController controller, Icon  prefixIcon) {
    return InputDecoration(
      labelText: widget.labelText,
      
      labelStyle: const TextStyle(
        color: Colors.black,
        height: 0,
        fontSize: 20,
      ),
      fillColor: Colors.grey[50],
      filled: true,
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
          width: 1.5,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
          width: 1,
        ),
      ),
      suffixIcon: InkWell(
        onTap: () => inputController.clear(),
        child: const Icon(Icons.cancel),
      ),
      prefixIcon: prefixIcon
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      cursorColor: const Color(0xff4FA9A7),
      style: const TextStyle(color: Colors.black, fontSize: 22),
      decoration: buildTextInputDecoration(widget.labelText, inputController, Icon(widget.prefixIcon)),
      controller: inputController,
      validator: (value) {
        if (value!.isEmpty) return widget.validator;
      },
    );
  }
}