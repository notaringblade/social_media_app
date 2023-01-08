import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:social_media_app/main_pages/explore_page.dart';
import 'package:social_media_app/main_pages/friends_page.dart';
import 'package:social_media_app/main_pages/home_page.dart';
import 'package:social_media_app/main_pages/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin {
  int currentIndex = 0;

  final user = FirebaseAuth.instance.currentUser;

  PageController pageController = PageController();

  List<Widget> screens = [
    const HomePage(),
    // FriendsPage(),
    const ExplorePage(),
    const ProfilePage()
  ];

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(Icons.menu, size: 24, color: Colors.white),
        backgroundColor: Colors.transparent,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: screens,
      ),
      backgroundColor: const Color(0xff222222),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white, width: 1)),
          color: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: GNav(
            selectedIndex: currentIndex,

            activeColor: Colors.black,
            duration: Duration(milliseconds: 300),
            tabBackgroundColor: const Color(0xffffffff),
            color: Colors.grey,
            gap: 8,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            // backgroundColor: Color(0xff232023),
            style: GnavStyle.google,
            // tabActiveBorder: Border.all(color: Color(0xff232023), width: 2),
            tabs: const [
              GButton(
                icon: Icons.home_outlined,
                text: "Home",
              ),
              // GButton(
              //   icon: Icons.people_outline_outlined,
              //   text: "Friends",
              // ),
              GButton(
                icon: Icons.explore_outlined,
                text: "Discover",
              ),
              GButton(
                icon: Icons.person_outline,
                text: "User",
              ),
            ],
            onTabChange: onTapped
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
