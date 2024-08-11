import 'package:flutter/material.dart';
import 'package:live_score_application/screens/home/model/team_model.dart';
import 'package:live_score_application/screens/home/widgets/match_card.dart';
import 'package:live_score_application/screens/home/widgets/match_skeletion.dart';

class MatchSlider extends StatefulWidget {
  final List<FirstTeamVSSecondTeam> matches;

  MatchSlider({required this.matches});

  @override
  State<MatchSlider> createState() => _MatchSliderState();
}

class _MatchSliderState extends State<MatchSlider> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? Container(
        height: 200,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (context, index) {
            return MatchSkeleton();
          },
        ),
      )
          : Container(
        height: 200,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.matches.length,
          itemBuilder: (context, index) {
            return MatchCard(match: widget.matches[index]);
          },
        ),
      ),
    );
  }
}
