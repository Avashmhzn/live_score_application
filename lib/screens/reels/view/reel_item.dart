
/*
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:live_score_application/screens/reels/model/model_reel.dart';


class ReelItem extends StatefulWidget {
  final Reel reel;

  const ReelItem({Key? key, required this.reel}) : super(key: key);

  @override
  _ReelItemState createState() => _ReelItemState();
}

class _ReelItemState extends State<ReelItem> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    final videoUrl = widget.reel.videoUrl;
    if (videoUrl != null) {
      _controller = VideoPlayerController.network(videoUrl)
        ..initialize().then((_) {
          setState(() {});
          _controller.play();
          _isPlaying = true;
        });
      _controller.setLooping(true);
    } else {
      // Handle null videoUrl case
      print("Error: videoUrl is null");
    }
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoUrl = widget.reel.videoUrl;
    if (videoUrl == null) {
      return const Center(
        child: Text(
          "Error: videoUrl is null",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    }

    return Stack(
      children: [
        GestureDetector(
          onTap: _togglePlayPause,
          child: Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
                : const CircularProgressIndicator(),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Text(
            widget.reel.description ?? 'No description available',
            style: const TextStyle(color: Colors.white, fontSize: 16,fontFamily: 'Urbanist'),
          ),
        ),
        const SizedBox(height: 10,),
        Positioned(
          bottom: 40,
          left: 20,
          child: Text(
            widget.reel.username ?? 'No username available',
            style: const TextStyle(color: Colors.white, fontSize: 16,fontFamily: 'Urbanist'),
          ),
        ),
        if (!_isPlaying && _controller.value.isInitialized)
          const Center(
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 100,
            ),
          ),
      ],
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:live_score_application/screens/reels/model/model_reel.dart';

class ReelItem extends StatefulWidget {
  final Reel reel;

  const ReelItem({Key? key, required this.reel}) : super(key: key);

  @override
  _ReelItemState createState() => _ReelItemState();
}

class _ReelItemState extends State<ReelItem> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    final videoUrl = widget.reel.videoUrl;
    if (videoUrl.isNotEmpty) {
      _controller = VideoPlayerController.network(videoUrl)
        ..initialize().then((_) {
          setState(() {});
          _controller.play();
          _isPlaying = true;
        });
      _controller.setLooping(true);
    } else {
      // Handle null videoUrl case
      print("Error: videoUrl is null");
    }

    fetchUserProfileImage();
  }

  Future<void> fetchUserProfileImage() async {
    if (widget.reel.userId.isNotEmpty) {
      var userDoc = await FirebaseFirestore.instance.collection('users').doc(widget.reel.userId).get();
      if (userDoc.exists) {
        setState(() {
          profileImageUrl = userDoc['imageUrl'];
        });
      }
    } else {
      // Handle null userId case
      print("Error: userId is null");
    }
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoUrl = widget.reel.videoUrl;
    if (videoUrl.isEmpty) {
      return Center(
        child: Text(
          "Error: videoUrl is null",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    }

    return Stack(
      children: [
        GestureDetector(
          onTap: _togglePlayPause,
          child: Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
                : const CircularProgressIndicator(),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 20,
                backgroundImage: profileImageUrl != null
                    ? NetworkImage(profileImageUrl!)
                    : null,
                child: profileImageUrl == null
                    ? const Icon(Icons.person, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: 10,), // Spacing between profile picture and username
              Text(
                widget.reel.username,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Urbanist',fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          left: 30,
          child: Text(
            widget.reel.description,
            style: const TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Urbanist'),
          ),
        ),
        if (!_isPlaying && _controller.value.isInitialized)
          Center(
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 100,
            ),
          ),
      ],
    );
  }
}
