import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MatchSkeleton extends StatelessWidget {
  const MatchSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Container(
        width: 400,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: 100,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 10),
            Container(
              height: 15,
              width: 100,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 5),
            Container(
              height: 15,
              width: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 5),
            Container(
              height: 20,
              width: 60,
              color: Colors.grey[400],
            ),

          ],
        ),
      ),
    );
  }
}
