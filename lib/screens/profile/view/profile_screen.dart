import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:live_score_application/routes/app_route.dart';
import 'package:live_score_application/screens/profile/widgets/menu_item.dart';
import 'package:live_score_application/user_auth/firebase_auth_implementation/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  User? user;
  String? username;
  String? imageUrl;
  String? email;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (user != null) {
      final userId = user!.uid;
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

      setState(() {
        username = userDoc['username'];
        imageUrl = userDoc['imageUrl'];
        email = userDoc['email'];
      });
    }
  }

  Future<void> _logout(BuildContext context) async {
    try {
      await _authService.signOut();
      AppRoute().navigateToLoginScreen(context);
    } catch (e) {
      print("Error signing out: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        controller: widget.scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.black,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[800],
                      radius: 60,
                      backgroundImage: imageUrl != null
                          ? NetworkImage(imageUrl!)
                          : const NetworkImage('https://i.stack.imgur.com/l60Hf.png'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Urbanist',
                        ),
                        children: [
                          const TextSpan(text: 'Welcome '),
                          TextSpan(
                            text: username ?? 'User',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        MenuItem(
                          icon: Icons.notifications,
                          text: 'Notifications',
                          onTap: () {
                            // Implement notifications action
                          },
                        ),
                        MenuItem(
                          icon: Icons.upload,
                          text: 'Upload',
                          onTap: () {
                            AppRoute().navigateToUploadScreen(context);
                          },
                        ),
                        MenuItem(
                          icon: Icons.settings,
                          text: 'Settings',
                          onTap: () {
                            // Implement settings action
                          },
                        ),
                        MenuItem(
                          icon: Icons.help,
                          text: 'Help & Info',
                          onTap: () {
                            // Implement help & info action
                          },
                        ),
                        MenuItem(
                          icon: Iconsax.logout,
                          text: 'Log Out',
                          onTap: () async {
                            await _logout(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}