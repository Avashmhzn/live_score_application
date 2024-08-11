import 'package:flutter/material.dart';
import 'package:live_score_application/screens/home/model/livematch.dart';
import 'package:live_score_application/screens/matchdetail/controller/match_detail_controller.dart';
import 'package:live_score_application/screens/matchdetail/model/match_model.dart';
import 'package:live_score_application/services/api_services.dart';
import 'package:live_score_application/global/widgets/custom_back.dart';

class MatchDetailScreen extends StatefulWidget {
  final LiveMatch detail;

  MatchDetailScreen({required this.detail});

  @override
  State<MatchDetailScreen> createState() => _MatchDetailScreenState();
}

class _MatchDetailScreenState extends State<MatchDetailScreen>
    with SingleTickerProviderStateMixin {
  List<MatchModel> matchEvents = [];
  bool isLoading = true;
  bool hasError = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    fetchData();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      String from = '2023-04-05';
      String to = '2023-04-05';
      String leagueId = '152';
      var events = await MatchDetailController().fetchMatchEvents(from, to, leagueId);
      List<MatchModel> matches = [];
      for (var i in events) {
        matches.add(MatchModel.fromJson(i));
      }
      setState(() {
        matchEvents = matches;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://watermark.lovepik.com/photo/50091/3009.jpg_wh1200.jpg',
                  ),
                  fit: BoxFit.fill,
                  alignment: AlignmentDirectional.topCenter,
                ),
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.5),
            ),
            /*CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Row(
                          children: [
                            CustomBackButton(),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.detail.stadium,
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Date: ${widget.detail.matchDate}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Image.network(widget.detail.homeLogo,
                                        width: 100),
                                    Text(
                                      widget.detail.homeTeam,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  widget.detail.score,
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Urbanist',
                                  ),
                                ),
                                Column(
                                  children: [
                                    Image.network(widget.detail.awayLogo,
                                        width: 100),
                                    Text(
                                      widget.detail.awayTeam,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (isLoading)
                        const Center(
                          child: CircularProgressIndicator(),
                        )
                      else if (hasError)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Error fetching data',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        )
                      else if (matchEvents.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'No match events available',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 20.0),
                    color: Colors.black,
                    child: Container(
                      color: Colors.black,
                      child: TabBar(
                        controller: _tabController,
                        unselectedLabelColor: Colors.grey,
                        labelColor: Colors.black,
                        labelStyle: const TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.bold,
                        ),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xFFBBFF00),
                        ),
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 5.0),
                        indicatorColor: Colors.black,
                        dividerColor: Colors.transparent,
                        tabs: [
                          Tab(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.transparent,
                              ),
                              child: const Text(
                                'Stats',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.transparent,
                              ),
                              child: const Text(
                                'Summary',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.transparent,
                              ),
                              child: const Text(
                                'Lineups',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverFillRemaining(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Container(
                        color: Colors.black,
                        child: buildStatsView(),
                      ),
                      Container(
                        color: Colors.black,
                        child: buildSummaryView(),
                      ),
                      Container(
                        color: Colors.black,
                        child: buildLineupsView(),
                      ),
                    ],
                  ),
                ),
              ],
            )*/
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Row(
                      children: [
                        CustomBackButton(),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.detail.stadium,
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Date: ${widget.detail.matchDate}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Image.network(widget.detail.homeLogo, width: 100),
                                Text(
                                  widget.detail.homeTeam,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                  ),
                                ),
                                const Text(
                                  'Home',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Urbanist',
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              widget.detail.score,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Urbanist',
                              ),
                            ),
                            Column(
                              children: [
                                Image.network(widget.detail.awayLogo, width: 100),
                                Text(
                                  widget.detail.awayTeam,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const Text(
                                  'Away',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Urbanist',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else if (hasError)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Error fetching data',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    )
                  else if (matchEvents.isEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'No match events available',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                  Container(

                    color: Colors.black,
                    child: Column(
                      children: [
                        Padding(
                      padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 20.0),
                          child: TabBar(
                            controller: _tabController,
                            unselectedLabelColor: Colors.grey,
                            labelColor: Colors.black,
                            labelStyle: const TextStyle(
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.bold,
                            ),
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color(0xFFBBFF00),
                            ),
                            labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                            indicatorColor: Colors.black,
                            dividerColor: Colors.transparent,
                            tabs: [
                              Tab(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.transparent,
                                  ),
                                  child: const Text(
                                    'Stats',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.transparent,
                                  ),
                                  child: const Text(
                                    'Lineups',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 1000,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              Container(
                                color: Colors.black,
                                child: buildStatsView(),
                              ),
                              Container(
                                color: Colors.black,
                                child: buildLineupsView(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildStatsView() {
    return ListView.builder(
      itemCount: matchEvents.length,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (matchEvents[index].matchId == widget.detail.matchId) {
          var statistics = matchEvents[index].statistics ?? [];
          return Column(
            children: statistics.map((stats) {
              double homeValue =
                  double.tryParse(stats.home?.replaceAll('%', '') ?? '0') ??
                      0.0;
              double awayValue =
                  double.tryParse(stats.away?.replaceAll('%', '') ?? '0') ??
                      0.0;
              double total = homeValue + awayValue;
              double homeProgress = total != 0 ? homeValue / total : 0;
              double awayProgress = total != 0 ? awayValue / total : 0;

              Color homeProgressColor = homeValue > 0.5 * total
                  ? const Color(0xFFBBFF00)
                  : Colors.white;
              Color awayProgressColor = awayValue > 0.5 * total
                  ? const Color(0xFFBBFF00)
                  : Colors.white;
              print('HOMEVALUE ${stats.home} AWAY VALUE ${stats.away}');
              return Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        stats.type!,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontFamily: 'Urbanist'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          stats.home!,
                          style: TextStyle(
                              color: homeProgressColor,
                              fontSize: 18,
                              fontFamily: 'Urbanist'),
                        ),
                        Text(
                          stats.away!,
                          style: TextStyle(
                              color: awayProgressColor,
                              fontSize: 18,
                              fontFamily: 'Urbanist'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Transform.flip(
                            flipX: true,
                            child: LinearProgressIndicator(
                              borderRadius: BorderRadius.circular(20),
                              value: homeProgress,
                              minHeight: 8,
                              backgroundColor: Colors.grey.shade700,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  homeProgressColor),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: LinearProgressIndicator(
                            borderRadius: BorderRadius.circular(20),
                            value: awayProgress,
                            minHeight: 8,
                            backgroundColor: Colors.grey.shade700,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                awayProgressColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }


  Widget buildLineupsView() {
    return SingleChildScrollView(
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(matchEvents.length, (index) {
          final matchEvent = matchEvents[index];
          if (matchEvent.matchId == widget.detail.matchId) {
            final lineup = matchEvent.lineup;
            final homeStartingLineups = lineup?.home?.startingLineups ?? [];
            final awayStartingLineups = lineup?.away?.startingLineups ?? [];

            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      for (var player in homeStartingLineups)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "${player.lineupNumber ?? ''} ",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                TextSpan(
                                  text: player.lineupPlayer ?? '',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Urbanist',
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 10),
                      for (var player in awayStartingLineups)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: RichText(
                            textAlign: TextAlign.end,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: player.lineupPlayer ?? '',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Urbanist',
                                    fontSize: 12,
                                  ),
                                ),
                                TextSpan(
                                  text: " ${player.lineupNumber ?? ''}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      ),
    );
  }
}

