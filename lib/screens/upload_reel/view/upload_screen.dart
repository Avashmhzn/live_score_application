/*
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:live_score_application/screens/upload_reel/view/uploadreel.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadReelScreen extends StatefulWidget {
  @override
  _UploadReelScreenState createState() => _UploadReelScreenState();
}

class _UploadReelScreenState extends State<UploadReelScreen> {
  final _descriptionController = TextEditingController();
  File? _videoFile;
  final _picker = ImagePicker();
  VideoPlayerController? _videoPlayerController;
  String? username;

  @override
  void initState() {
    super.initState();
    _fetchUsername();
  }

  Future<void> _fetchUsername() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      setState(() {
        username = userDoc['username'];
      });
    }
  }

  Future<void> _pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
        _initializeVideoPlayer();
      });
    }
  }

  void _initializeVideoPlayer() {
    if (_videoFile != null) {
      _videoPlayerController = VideoPlayerController.file(_videoFile!)
        ..initialize().then((_) {
          setState(() {});
          _videoPlayerController!.play();
        });
    }
  }

  Future<void> _uploadReel() async {
    if (_videoFile != null && _descriptionController.text.isNotEmpty && username != null) {
      try {
        await uploadReel(
          _videoFile!,
          _descriptionController.text,
          username!, // Pass the username
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload reel: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please provide a video and description')),
      );
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Reel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_videoFile != null && _videoPlayerController != null && _videoPlayerController!.value.isInitialized)
              Container(
                height: 200,
                child: AspectRatio(
                  aspectRatio: _videoPlayerController!.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController!),
                ),
              ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickVideo,
              child: Text('Pick Video'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadReel,
              child: Text('Upload Reel'),
            ),
          ],
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:live_score_application/screens/upload_reel/view/uploadreel.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class UploadReelScreen extends StatefulWidget {
  @override
  _UploadReelScreenState createState() => _UploadReelScreenState();
}

class _UploadReelScreenState extends State<UploadReelScreen> {
  final _descriptionController = TextEditingController();
  File? _videoFile;
  final _picker = ImagePicker();
  VideoPlayerController? _videoPlayerController;
  String? username;

  @override
  void initState() {
    super.initState();
    _fetchUsername();
  }

  Future<void> _fetchUsername() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();
      setState(() {
        username = userDoc['username'];
      });
    }
  }

  Future<void> _pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
        _initializeVideoPlayer();
      });
    }
  }

  void _initializeVideoPlayer() {
    if (_videoFile != null) {
      _videoPlayerController = VideoPlayerController.file(_videoFile!)
        ..initialize().then((_) {
          setState(() {});
          _videoPlayerController!.play();
        });
    }
  }

  Future<void> _uploadReel() async {
    if (_videoFile != null && _descriptionController.text.isNotEmpty && username != null) {
      try {
        await uploadReel(
          _videoFile!,
          _descriptionController.text,
          username!, // Pass the username
        );
        // Show Snackbar on successful upload
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Reel uploaded successfully'),
            duration: Duration(seconds: 2), // Adjust as needed
          ),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload reel: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide a video and description')),
      );
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Reel',style: TextStyle(color: Colors.white),),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_videoFile != null &&
                _videoPlayerController != null &&
                _videoPlayerController!.value.isInitialized)
              Container(
                height: 200,
                child: AspectRatio(
                  aspectRatio: _videoPlayerController!.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController!),
                ),
              ),
            TextField(
              controller: _descriptionController,
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: 'Description',labelStyle: TextStyle(color: Colors.white),hintStyle: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickVideo,
              child: const Text('Pick Video'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadReel,
              child: const Text('Upload Reel'),
            ),
          ],
        ),
      ),
    );
  }
}
