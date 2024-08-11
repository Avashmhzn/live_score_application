import 'package:flutter/material.dart';
import 'package:live_score_application/screens/home/model/TopPlayerModel.dart';
import 'package:iconsax/iconsax.dart';
import 'package:live_score_application/screens/player/view/players_details.dart';

class PlayerRankCard extends StatelessWidget {
  final TopPlayerModel player;

  PlayerRankCard({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => PlayersDetailsPage(player: player),));
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 120,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Center(
                  child: player.imageUrl != null && player.imageUrl!.isNotEmpty
                      ? SizedBox(
                    height: 120,
                    width: 100,
                    child: Image.network(
                      player.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return Container(
                          height: 100,
                          width: 100,
                          color: Colors.transparent,
                          child: const Icon(
                            Iconsax.user,
                            color: Colors.black,
                            size: 70,
                          ),
                        );
                      },
                    ),
                  )
                      : const Icon(
                    Iconsax.user,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Text(
              '${player.playerName}',
              style: const TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Urbanist'),
            ),
            const SizedBox(height: 8),
            Text(
              '${player.teamName}',
              style: const TextStyle(color: Colors.black, fontFamily: 'Urbanist'),
            ),
            const SizedBox(height: 8),
            Text(
              'Ranking: ${player.playerPlace}',
              style: const TextStyle(color: Colors.black, fontFamily: 'Urbanist'),
            ),
            const SizedBox(height: 8),
            /*Text(
              'Assists: ${player.assists}',
              style: const TextStyle(color: Colors.black, fontFamily: 'Urbanist'),
            ),
            const SizedBox(height: 8),
            Text(
              'PK Goals: ${player.penaltyGoals}',
              style: const TextStyle(color: Colors.black, fontFamily: 'Urbanist'),
            ),*/
          ],
        ),
      ),
    );
  }
}
