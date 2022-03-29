import 'package:flutter/material.dart';

Widget buildInput(String text,controller) {
  return Column(
    children: [
      Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))),
        child: TextFormField(
          maxLines: 1,
          autocorrect: false,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: text,
              hintStyle: TextStyle(color: Colors.grey )),
          controller: controller,
        ),
      ),
      SizedBox(
        height: 10,
      ),
    ],
  );
}
