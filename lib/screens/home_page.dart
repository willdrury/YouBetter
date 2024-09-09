import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:you_better/models/user.dart';
import 'package:you_better/providers/settings_provider.dart';
import 'package:you_better/screens/inbox_screen.dart';
import 'package:you_better/widgets/challenge_list.dart';
import 'package:you_better/screens/friend_screen.dart';
import 'package:you_better/screens/settings_screen.dart';
import 'package:you_better/models/challenge.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:you_better/widgets/profile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key}) ;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController tabController;
  late int currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = 0;
    tabController = TabController(length: 3, vsync: this);
    tabController.animation!.addListener(() {
      final value = tabController.animation!.value.round();
      if (value != currentPage && mounted && value != 2) {
        changePage(value);
      }},
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

  void _setScreen(String identifier) async {
    if (identifier == 'settings') {
      Navigator.of(context).push<Map<Setting, bool>>(
          MaterialPageRoute(builder: (ctx) => const SettingsScreen())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset('assets/images/YouBetterLogo.png', height: 30, width: 30,),
              const SizedBox(width: 10,),
              Text(
                'YouBetter',
                style: GoogleFonts.robotoSlab(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ],
          )
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push<Map<Setting, bool>>(
                  MaterialPageRoute(builder: (ctx) => const InboxScreen())
              );
            },
            icon: const Icon(Icons.notifications, color: Colors.white,),
          ),
          IconButton(
            onPressed: () => _setScreen('settings'),
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
            ChallengeList(),
            const FriendsScreen(),
            const Profile(),
          ],
        ),
        child: TabBar(
          splashBorderRadius: BorderRadius.circular(30),
          indicatorPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          controller: tabController,
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 4,
              ),
              insets: const EdgeInsets.fromLTRB(16, 0, 16, 8)),
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