import 'package:flutter/material.dart';

class TextFieldView extends StatelessWidget {
  final String hintText;
  final bool obsecureText;
  final TextEditingController textEditingController;

  const TextFieldView(
      {super.key,
      required this.hintText,
      required this.obsecureText,
      required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        obscureText: obsecureText,
        controller: textEditingController,
        cursorOpacityAnimates: true,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
