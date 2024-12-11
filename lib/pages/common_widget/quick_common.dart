import 'package:flutter/material.dart';

class NewMessageIndicator extends StatelessWidget {
  const NewMessageIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Icon(Icons.people), // Replace with your desired icon
        Positioned(
          right: -2,
          top: -2,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.green, // Change the color as needed
            ),
          ),
        ),
      ],
    );
  }
}
