import 'package:flutter/material.dart';

class ScheduleMatch extends StatelessWidget {
  const ScheduleMatch({super.key, required ScrollController scrollController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Upcoming Matches', style: TextStyle(color: Colors.white,fontFamily: 'Urbanist'),),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          FilterTabs(),
          Expanded(
            child: ListView(
              children: const [
                MatchDay(
                  date: '29 Jan 2024',
                  matches: [
                    MatchItem( homeTeam: 'N Forest',time: '06:30', awayTeam: 'Liverpool'),
                    MatchItem( homeTeam: 'Man City',time: '07:30', awayTeam: 'Brighton'),
                    MatchItem( homeTeam: 'Wolves', time: '08:30',awayTeam: 'Leicester'),
                  ],
                ),
                MatchDay(
                  date: '30 Jan 2022',
                  matches: [
                    MatchItem( homeTeam: 'N Forest',time: '06:30', awayTeam: 'Liverpool'),
                    MatchItem( homeTeam: 'Man City',time: '07:30', awayTeam: 'Brighton'),
                    MatchItem( homeTeam: 'Wolves',time: '08:30', awayTeam: 'Leicester'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FilterTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            FilterTab(label: 'Turkey Cup', color: Colors.red),
            FilterTab(label: 'LaLiga', color: Colors.blue),
            FilterTab(label: 'Premier League', color: Colors.green),
            FilterTab(label: 'Bundesliga', color: Colors.yellow),
          ],
        ),
      ),
    );
  }
}

class FilterTab extends StatelessWidget {
  final String label;
  final Color color;

  const FilterTab({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Chip(
        label: Text(label, style: const TextStyle(color: Colors.white,fontFamily: 'Urbanist')),
        backgroundColor: color,
      ),
    );
  }
}

class MatchDay extends StatelessWidget {
  final String date;
  final List<MatchItem> matches;

  const MatchDay({required this.date, required this.matches});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(date, style: const TextStyle(color: Colors.white, fontSize: 18.0,fontFamily: 'Urbanist')),
          ...matches,
        ],
      ),
    );
  }
}

class MatchItem extends StatelessWidget {
  final String time;
  final String homeTeam;
  final String awayTeam;

  const MatchItem({required this.time, required this.homeTeam, required this.awayTeam});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text(homeTeam, style: const TextStyle(color: Colors.white, fontSize: 16.0)),
          Text(time, style: const TextStyle(color: Colors.green, fontSize: 16.0)),
          Text(awayTeam, style: const TextStyle(color: Colors.white, fontSize: 16.0)),
        ],
      ),
    );
  }
}