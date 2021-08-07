import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  ImageDialog({required this.image, required this.onDelete});

  final dynamic image;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.file(image),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onDelete();
            },
            child: const Text(
              'Excluir',
              style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w500),
            ),
            style: ButtonStyle(
                textStyle: MaterialStateProperty.all<TextStyle>(
                    TextStyle(color: Colors.red))),
          )
        ],
      ),
    );
  }
}
