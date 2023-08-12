import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.type,
      required this.prefix,
      required this.color,
      required this.controllerName,
      required this.label,
      required this.valedate});
  final Color color;
  final String? Function(String?) valedate;
  final String label;
  final Icon prefix;
  final TextEditingController controllerName;
  final TextInputType type;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerName,
      keyboardType: type,
      validator: valedate,
      decoration: InputDecoration(
        labelText: label,
        border: InputBorder.none,
        prefixIcon: prefix,
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(
              color: Colors.black12,
              width: 1,
            )),
        focusedBorder: const OutlineInputBorder(
            //Outline border type for TextFeild
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(
              color: Colors.black12,
              width: 1,
            )),
      ),
    );
  }
}

class CustomBottom extends StatelessWidget {
  final Color buttonColor;
  final double height;
  final String text;
  final Function onPress;
  final Color borderColor;
  final TextStyle textStyleForButton;
  const CustomBottom(
      {super.key,
      required this.text,
      required this.height,
      required this.buttonColor,
      required this.onPress,
      required this.borderColor,
      required this.textStyleForButton});
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          onPress();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: height,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 3),
            color: buttonColor,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Center(
              child: Text(
            text,
            style: textStyleForButton,
          )),
        ));
  }
}
