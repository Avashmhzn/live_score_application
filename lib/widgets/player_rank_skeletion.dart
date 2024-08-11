import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlayerRankSkeletion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Container(
        width: 150,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 15,
              width: 100,
              color: Colors.grey[400],
            ),
            SizedBox(height: 5),
            Container(
              height: 15,
              width: 80,
              color: Colors.grey[400],
            ),
            SizedBox(height: 5),
            Container(
              height: 15,
              width: 60,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}