import 'package:classroom/controllers/home_controllers.dart';
import 'package:classroom/views/home.dart';
import 'package:classroom/views/playlist.dart';
import 'package:classroom/views/trend.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();

  late CupertinoTabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = CupertinoTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    final listOfKeys = [firstTabNavKey, secondTabNavKey, thirdTabNavKey];

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeController(),
        )
      ],
      
      child: CupertinoApp(
        theme: const CupertinoThemeData(
          brightness: Brightness.dark,
          primaryColor: CupertinoColors.systemRed,
        ),
        home: WillPopScope(
          onWillPop: () async {
            return !await listOfKeys[tabController.index]
                .currentState!
                .maybePop();
          },
          child: CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.circle),
                  label: 'Trending',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.music_albums),
                  label: 'Playlist',
                ),
              ],
            ),
            tabBuilder: (BuildContext context, int index) {
              return CupertinoTabView(
                builder: (BuildContext context) => CupertinoTabView(
                  navigatorKey: listOfKeys[index],
                  builder: (ctx) {
                    switch (index) {
                      case 0:
                        return const HomeUI();
                      case 1:
                        return const PlayListUI();
                      case 2:
                        return const TrendsUI();
                    }
                    return Container();
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
