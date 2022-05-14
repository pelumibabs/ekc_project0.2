import 'package:ekc_project/Pages/roomsPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Widgets/myAppBar.dart';
import '../theme/colors.dart';
import '../theme/config.dart';
import '../theme/constants.dart';
import 'A_loginPage.dart';

class GDashboard extends StatefulWidget {
  final Widget homePage;

  // final UserCredential? currentUser;

  // final currentUser;

  const GDashboard({required this.homePage}) : super();


  @override
  _GDashboardState createState() => _GDashboardState();
}

class _GDashboardState extends State<GDashboard> {
  int _selectedIndex = 1;
  final PageController _pageController = PageController(initialPage: 1);

  Widget tabWidget(
    String label, {
    required String asset,
    bool iconAsset = false,
    bool active = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (cShowTabBarTitles) ...[
          Text(
            '$label',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: active ? cRilDarkPurple.withOpacity(0.65) : Colors.grey),
          ),
          SizedBox(width: 6)
        ],
        iconAsset
            ? Icon(
                Icons.home_rounded,
                size: 27,
              )
            : SvgPicture.asset('$asset',
                width: 27,
                height: 27,
                // todo change color when active
                color: active ? cRilDarkPurple.withOpacity(0.65) : Colors.grey)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print('[Build] GDashboard');
    User? authUser = FirebaseAuth.instance.currentUser;
    print('FireAuth USER ${authUser?.displayName}');

    var screenWidth = MediaQuery.of(context).size.width;

    // todo: make it better, currently its update after touch.
    // print('XYZ pickedImage $pickedImage');
    // print('XYZ user ${user}');
    // if (pickedImage != null) setState(() {});

    return Scaffold(
      // key: ValueKey(pickedImage),
      appBar: AppBar(
        backgroundColor: cGrey100,
        elevation: 2,
        actions: [
          Center(
              child:
                  // pickedImage != null ?
                  // CircleAvatar(
                  //     backgroundColor: Colors.grey,
                  //     radius: 39 / 2, // 40
                  //     child: CircleAvatar(
                  //         backgroundColor: Colors.grey,
                  //         radius: 35, // 40
                  //         backgroundImage: FileImage(
                  //             File(pickedImage!.path)))
                  // ) :
          InkWell(
            onTap: (){
              showDialog(
                barrierDismissible: true,
                context: context,
                // barrierColor: StreamChatTheme.of(context).colorTheme.overlay,
                builder: (context) => Center(
                    child: AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      title: const Center(child:
                      Text("אתה בטוח שאתה רוצה להתנתק?",
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                      // content: Text("Saved successfully"),
                      actionsAlignment: MainAxisAlignment.center,
                      actions: [
                        TextButton(
                          onPressed: ()=>kNavigator(context).pop(),
                          child: const Text('חזור לראשי',
                              style: TextStyle(color: Colors.grey)),
                        ),
                        TextButton(
                          onPressed: () =>
                              kPushNavigator(context, const LoginPage(),
                                /*replace: true*/),
                          child: const Text('התנתק',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    )
                ),
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey[400]!,
              radius: 42 / 2,
              child:           CircleAvatar(
                backgroundColor: Colors.grey[400]!,
                radius: 37 / 2,
                backgroundImage: NetworkImage('${authUser?.photoURL}'),
              )),
          ),
          ),
          const SizedBox(width: 20),
        ],
        title: Container(
            height: 32,
            child: Row(
              children: [
                Image.asset(
                  'assets/RilTopiaTxt.png',
                ),
                Container(
                  padding: EdgeInsets.only(left: 4),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'BETA',
                    style: TextStyle(
                        // color: cRilDarkPurple.withOpacity(0.75),
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        // Theme.of(context).backgroundColor,
                        fontSize: 10),
                  ),
                ),
              ],
            )),
        /*Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            // color: Colors.grey,
            border: Border.all(
                color: cRilDarkPurple.withOpacity(0.65),
                width: 1.5),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(14),
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Statux',
                style: chatThemeData.textTheme.headlineBold.copyWith(
                    color: cRilDarkPurple.withOpacity(0.75),
                    fontWeight: FontWeight.w300,
                    // Theme.of(context).backgroundColor,
                    fontSize: 22),
              ),
              Container(
                padding: EdgeInsets.only(left: 6),
                alignment: Alignment.topLeft,
                child: Text(
                  'BETA',
                  style: chatThemeData.textTheme.headlineBold.copyWith(
                      color: cRilDarkPurple.withOpacity(0.75),
                      fontWeight: FontWeight.w500,
                      // Theme.of(context).backgroundColor,
                      fontSize: 10),
                ),
              ),
            ],
          ),
        ),*/
        bottom: PreferredSize(
          preferredSize: new Size(00.0, 50.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 42,
                // color: Colors.green,
                child: BottomNavigationBar(
                  // showSelectedLabels: false,
                  // showUnselectedLabels: false,
                  unselectedFontSize: 0,
                  selectedFontSize: 0,
                  backgroundColor: cGrey100,
                  // backgroundColor: Colors.yellow,
                  // type: BottomNavigationBarType.shifting,
                  elevation: 0,
                  selectedItemColor: cRilDarkPurple.withOpacity(0.65),
                  unselectedItemColor: Colors.grey,
                  currentIndex: _selectedIndex,
                  onTap: (value) {
                    // onTap Bottom icon
                    setState(() => _selectedIndex = value);
                    // _pageController.jumpToPage(value);
                    _pageController.animateToPage(value,
                        curve: Curves.easeInOut,
                        duration: Duration(milliseconds: 150));
                  },
                  items: [
                    BottomNavigationBarItem(
                      // title: SizedBox(),
                      label: '',
                      icon: Stack(
                        children: [
                          tabWidget(
                            "צ'אטים",
                            asset: 'assets/svg_icons/chat_2207562.svg',
                          ),
                          // StreamSvgIcon.message(),
/*                          Positioned(
                            top: 0,
                            right: cShowTabBarTitles ? 4 : 32,
                            child: UnreadIndicator(),
                          ),*/
                        ],
                      ),
                      activeIcon: Stack(
                        children: [
                          tabWidget("צ'אטים",
                              asset: 'assets/svg_icons/chat_2769104_filled.svg',
                              active: true),
/*                          Positioned(
                            top: 0,
                            right: cShowTabBarTitles ? 4 : 32,
                            child: UnreadIndicator(),
                          ),*/
                        ],
                      ),
                    ),
                    BottomNavigationBarItem(
                      // title: SizedBox(),
                      label: '',
                      icon: tabWidget(
                        'רילטופיה',
                        asset: 'assets/svg_icons/CleanLogo.svg',
                      ),
                      activeIcon: tabWidget('רילטופיה',
                          asset: 'assets/svg_icons/CleanLogo.svg',
                          active: true),
/*                      icon: tabWidget(
                        'ראשי',
                        iconAsset: true,
                        asset: 'assets/icons/oStatusx.svg',
                      ),
                      activeIcon: tabWidget('ראשי',
                        iconAsset: true,
                          asset: 'assets/icons/oStatusx.svg', active: true),
                    */
                    ),
                    BottomNavigationBarItem(
                      // title: SizedBox(),
                      label: '',
                      icon: tabWidget(
                        'שאלות',
                        asset: 'assets/svg_icons/2questionMarksOC.svg',
                      ),
                      activeIcon: tabWidget('שאלות',
                          asset: 'assets/svg_icons/2questionMarksOC.svg',
                          active: true),
                    ),
                  ],
                ),
              ),
              // Container(
              //   height: 5,
              //   color: Colors.green,
              // )
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: SlideEffect(
                      spacing: cMinimizeIndicator ? screenWidth / 3 * 0.2 : 0,
                      radius: 6.0,
                      dotWidth: cMinimizeIndicator
                          ? screenWidth / 3 * 0.8
                          : screenWidth / 3,
                      dotHeight: 3.0,
                      paintStyle: PaintingStyle.fill,
                      strokeWidth: 1,
                      dotColor: cGrey100,
                      activeDotColor: cRilDarkPurple.withOpacity(0.65)),
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        // physics: const NeverScrollableScrollPhysics(), // disable swipe
        controller: _pageController,
        onPageChanged: (pageIndex) {
          // On Swipe left or right
          setState(() => _selectedIndex = pageIndex);
          // _pageController.jumpToPage(pageIndex);
          _pageController.animateToPage(pageIndex,
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 150));
        },
        children: [
          const RoomsPage(),
          widget.homePage, // [flyerChatV2.dart]
          Scaffold(appBar: myAppBar('Coming soon!'),)
        ],
      ));
  }

  @override
  void initState() {

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // print('XOXOX didChangeDependencies ');
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

}

