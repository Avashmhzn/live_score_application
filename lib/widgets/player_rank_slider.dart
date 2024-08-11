import 'package:flutter/material.dart';
import 'package:live_score_application/screens/home/controller/player_controller.dart';
import 'package:live_score_application/screens/home/model/TopPlayerModel.dart';
import 'package:live_score_application/widgets/player_rank_card.dart';
import 'package:live_score_application/widgets/player_rank_skeletion.dart';

class PlayerRankSlider extends StatefulWidget {
  const PlayerRankSlider({super.key});

  @override
  _PlayerRankSliderState createState() => _PlayerRankSliderState();
}

class _PlayerRankSliderState extends State<PlayerRankSlider> {
  final PlayerRankController _playerRankController = PlayerRankController();

  @override
  void initState() {
    super.initState();
    _playerRankController.fetchPlayers(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _playerRankController.isLoading
        ? Center(
      child: Container(
        height: 250,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (context, index) {
            return PlayerRankSkeletion();
          },
        ),
      ),
    )
        : _playerRankController.errorMessage.isNotEmpty
        ? Center(child: Text(_playerRankController.errorMessage))
        : Center(
      child: Container(
        height: 250,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _playerRankController.players.length,
          itemBuilder: (context, index) {
            TopPlayerModel player = _playerRankController.players[index];
            return PlayerRankCard(player: player);
          },
        ),
      ),
    );
  }
}
