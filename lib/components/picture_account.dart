import 'package:flutter/material.dart';

class PictureAccount extends StatelessWidget {
  final String image;
  PictureAccount({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          width: MediaQuery.of(context).size.width / 5,
          height: MediaQuery.of(context).size.width / 5,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.grey[200],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(75),
            child: image.isNotEmpty
                ? Image.network(image)
                : Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.grey[500],
                  ),
          ),
        ),
      ),
    );
  }
}
