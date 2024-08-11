//previous code
/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_score_application/provider/reel_provider.dart';
import 'package:live_score_application/screens/reels/view/reel_item.dart';

class ReelScreen extends StatefulWidget {
  const ReelScreen({super.key, required ScrollController scrollController});

  @override
  _ReelScreenState createState() => _ReelScreenState();
}

class _ReelScreenState extends State<ReelScreen> {
  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reels', style: TextStyle(color: Colors.white,fontFamily: 'Urbanist')),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.grey.shade900,
      body: Consumer(
        builder: (context, ref, _) {
          final reelListAsyncValue = ref.watch(reelsProvider);

          return reelListAsyncValue.when(
            data: (reelList) {
              if (reelList.isEmpty) {
                return const Center(child: Text('No reels found.'));
              }
              return PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                itemCount: reelList.length,
                itemBuilder: (context, index) {
                  final reel = reelList[index];
                  return ReelItem(reel: reel);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          );
        },
      ),
    );
  }
}*/

//new code
/*
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_score_application/provider/reel_provider.dart';
import 'package:live_score_application/screens/reels/view/reel_item.dart';
import 'dart:math';

class ReelScreen extends StatefulWidget {
  const ReelScreen({super.key, required ScrollController scrollController});

  @override
  _ReelScreenState createState() => _ReelScreenState();
}

class _ReelScreenState extends State<ReelScreen> {
  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reels', style: TextStyle(color: Colors.white, fontFamily: 'Urbanist')),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.grey.shade900,
      body: Consumer(
        builder: (context, ref, _) {
          final reelListAsyncValue = ref.watch(reelsProvider);

          return reelListAsyncValue.when(
            data: (reelList) {
              if (reelList.isEmpty) {
                return const Center(child: Text('No reels found.'));
              }

              // Shuffle the list of reels
              final shuffledReelList = List.from(reelList)..shuffle(Random());

              return PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                itemCount: shuffledReelList.length,
                itemBuilder: (context, index) {
                  final reel = shuffledReelList[index];
                  return ReelItem(reel: reel);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          );
        },
      ),
    );
  }
}
*/

/*new code */
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_score_application/provider/reel_provider.dart';
import 'package:live_score_application/screens/reels/view/reel_item.dart';
import 'dart:math';

class ReelScreen extends StatefulWidget {
  const ReelScreen({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  _ReelScreenState createState() => _ReelScreenState();
}

class _ReelScreenState extends State<ReelScreen> {
  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _refreshReels(WidgetRef ref) async {
    await ref.refresh(reelsProvider.future);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reels', style: TextStyle(color: Colors.white, fontFamily: 'Urbanist',fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.grey.shade900,
      body: Consumer(
        builder: (context, ref, _) {
          final reelListAsyncValue = ref.watch(reelsProvider);

          return reelListAsyncValue.when(
            data: (reelList) {
              if (reelList.isEmpty) {
                return const Center(child: Text('No reels found.'));
              }

              // Shuffle the list of reels
              final shuffledReelList = List.from(reelList)..shuffle(Random());

              return RefreshIndicator(
                onRefresh: () => _refreshReels(ref),
                child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: shuffledReelList.length,
                  itemBuilder: (context, index) {
                    final reel = shuffledReelList[index];
                    return ReelItem(reel: reel);
                  },
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          );
        },
      ),
    );
  }
}
