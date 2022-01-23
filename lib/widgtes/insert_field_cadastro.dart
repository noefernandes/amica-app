import 'package:flutter/material.dart';

class InsertFieldCadastro extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String fieldName;
  final TextInputType textInputType;
  const InsertFieldCadastro({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.fieldName,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(15));

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Text(
              fieldName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          TextField(
            controller: textEditingController,
            decoration: InputDecoration(
                border: inputBorder,
                focusedBorder: inputBorder,
                enabledBorder: inputBorder,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(8),
                isDense: true),
            keyboardType: textInputType,
            obscureText: isPass,
          ),
        ],
      ),
    );
  }
}
