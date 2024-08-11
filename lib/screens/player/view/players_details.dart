import 'package:flutter/material.dart';
import 'package:live_score_application/screens/home/model/TopPlayerModel.dart';

class PlayersDetailsPage extends StatelessWidget {
  final TopPlayerModel player;

  const PlayersDetailsPage({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Players Ranking', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ClipOval(
              child: Image.network(
                player.imageUrl ?? '',
                width: 150,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 100, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              player.playerName ?? 'Unknown Player',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white,fontFamily: 'Urbanist'),
            ),
            const SizedBox(height: 10),
            Text(
              player.teamName ?? 'Unknown Team',
              style: const TextStyle(fontSize: 18, color: Colors.white,fontFamily: 'Urbanist'),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildDetailRow('Rank', player.playerPlace ?? 'Unknown'),
                  _buildDetailRow('Team', player.teamName ?? 'Unknown'),
                  _buildDetailRow('Goals', player.goals?.toString() ?? 'Unknown'),
                  _buildDetailRow('Assist', player.assists?.toString() ?? 'Unknown'),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
