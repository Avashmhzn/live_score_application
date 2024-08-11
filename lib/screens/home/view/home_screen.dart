import 'package:flutter/material.dart';
import 'package:live_score_application/allscreen/all_screen.dart';
import 'package:live_score_application/screens/home/controller/team_controller.dart';
import 'package:live_score_application/screens/home/model/team_model.dart';
import 'package:live_score_application/screens/home/widgets/finish_match_slider.dart';
import 'package:live_score_application/screens/home/widgets/match_slider.dart';
import 'package:live_score_application/widgets/player_rank_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  final ScrollController scrollController;
  const HomeScreen({super.key, required this.scrollController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _controller = PageController();
  final TeamController _teamController = TeamController();
  MatchesModel? _matchesModel;
  User? user;
  String? username;
  String? imageUrl;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _fetchMatches();
    _fetchUserData();
  }

  Future<void> _fetchMatches() async {
    try {
      await _teamController.fetchMatches([73, 76, 77, 81], [78, 79, 80, 82]);
      if (mounted) {
        setState(() {
          _matchesModel = _teamController.matchesModel;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          print('Error fetching matches: $e');
        });
      }
    }
  }

  Future<void> _fetchUserData() async {
    if (user != null) {
      final userId = user!.uid;
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

      setState(() {
        username = userDoc['username'];
        imageUrl = userDoc['imageUrl'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: widget.scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFFBBFF00),
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/image/football.png',
                          color: Colors.black,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Livoball',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Hello ${username ?? 'User'},',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontFamily: 'Urbanist',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.notifications, color: Colors.white),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      backgroundColor: Colors.grey[800],
                      radius: 20,
                      backgroundImage: imageUrl != null
                          ? NetworkImage(imageUrl!)
                          : const NetworkImage('https://i.stack.imgur.com/l60Hf.png'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Finished Matches',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                LiveMatchesSlider(controller: _controller),
                const SizedBox(height: 10),
                Center(
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 2,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: Colors.blueAccent,
                      dotColor: Colors.grey,
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 8,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Upcoming Matches',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_matchesModel != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllScreen(
                                matchesModel: _matchesModel!,
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'See All',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Urbanist',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                if (_matchesModel != null &&
                    _matchesModel!.firstTeamVSSecondTeam != null)
                  MatchSlider(matches: _matchesModel!.firstTeamVSSecondTeam!),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Players Ranking',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'See All',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Urbanist',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                GestureDetector(child: const PlayerRankSlider()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
