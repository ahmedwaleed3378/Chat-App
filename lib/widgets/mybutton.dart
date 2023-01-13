import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({required this.color, required this.title, required this.onpressed});
  final Color color;
  final String title;
  final VoidCallback onpressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 5,
        color: color,
        child: MaterialButton(
            onPressed: onpressed,
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}

TextField MyTextField(String hint, String value) {
  return TextField(
    textAlign: TextAlign.center,
    decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        hintText: hint,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 10)),
    onChanged: ((val) {
      value = val;
    }),
  );
}
