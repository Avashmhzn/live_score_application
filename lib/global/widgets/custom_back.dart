import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add your navigation logic here
        Navigator.of(context).pop();
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2.0),
        ),
        child: const Center(
          child: Icon(
            Icons.arrow_back,
            size: 24.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}