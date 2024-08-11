import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FinishedMatchSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
