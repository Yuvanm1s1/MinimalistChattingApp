import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({Key? key, required this.message, required this.isCurrentUSer}) : super(key: key);

  final String message;
  final bool isCurrentUSer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Container(
        constraints: BoxConstraints(maxWidth: 200), // Limit message width
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 25),
        decoration: BoxDecoration(
          color: isCurrentUSer ? Colors.yellow.shade300 : Colors.grey.shade500,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message,
          style: TextStyle(
            fontSize: 16, // Adjust font size as needed
            color: Colors.black87, // Set text color
          ),
        ),
      ),
    );
  }
}
