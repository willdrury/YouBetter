import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:you_better/challenge_list.dart';
import 'package:you_better/friend_screen.dart';
import 'package:you_better/stats_screen.dart';
import 'package:you_better/settings_screen.dart';
import 'package:you_better/models/challenge.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List<Challenge> activeChallenges = getActiveChallenges();
  late TabController tabController;
  late int currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = 0;
    tabController = TabController(length: 4, vsync: this);
    tabController.animation!.addListener(
          () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted && value != 2) {
          changePage(value);
        }
      },
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  //TODO: navigate to and create challenge screen
  void _createChallenge() {
    setState(() {
      activeChallenges.add(createChallenge());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'YouBetter',
            style: GoogleFonts.robotoSlab(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, color: Colors.white,),
          )
        ],
      ),
      body: BottomBar(
        borderRadius: BorderRadius.circular(500),
        showIcon: true,
        width: MediaQuery.of(context).size.width * 0.8,
        barColor: Colors.black,
        start: 2,
        end: 0,
        offset: 10,
        barAlignment: Alignment.bottomCenter,
        iconHeight: 35,
        iconWidth: 35,
        fit: StackFit.expand,
        reverse: false,
        hideOnScroll: true,
        scrollOpposite: false,
        onBottomBarHidden: () {},
        onBottomBarShown: () {},
        body: (context, controller) => TabBarView(
          controller: tabController,
          dragStartBehavior: DragStartBehavior.down,
          physics: const BouncingScrollPhysics(),
          children: [
            ChallengeList(challenges: activeChallenges),
            const StatsScreen(),
            FriendsScreen(),
            const SettingsScreen(),
          ],
        ),
        child: TabBar(
          indicatorPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          controller: tabController,
          indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                color: Colors.pink,
                width: 4,
              ),
              insets: EdgeInsets.fromLTRB(16, 0, 16, 8)),
          tabs: const [
            SizedBox(
              height: 55,
              width: 40,
              child: Center(
                  child: Icon(
                    Icons.home,
                    color: Colors.white,
                  )),
            ),
            SizedBox(
              height: 55,
              width: 40,
              child: Center(
                  child: Icon(
                    Icons.trending_up,
                    color: Colors.white,
                  )),
            ),
            SizedBox(
              height: 55,
              width: 40,
              child: Center(
                  child: Icon(
                    Icons.groups,
                    color: Colors.white,
                  )),
            ),
            SizedBox(
              height: 55,
              width: 40,
              child: Center(
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}