import 'package:flutter/material.dart';

class AddPostHeader extends StatelessWidget {
  final String content;
  final Function onClosingPage;
  final Function addPostFun;
  const AddPostHeader(
      {required this.content,
      required this.onClosingPage,
      required this.addPostFun,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => onClosingPage(),
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        const SizedBox(
          width: 20,
        ),
        const Text(
          "Ceate Post",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Expanded(child: Container()),
        TextButton(
          onPressed: content.isEmpty ? null : () => addPostFun(),
          child: Text(
            "POST",
            style:
                TextStyle(color: content.isEmpty ? Colors.grey : Colors.white),
          ),
        )
      ],
    );
  }
}
