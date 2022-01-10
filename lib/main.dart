import 'package:classroom/controllers/color_controllers.dart';
import 'package:classroom/controllers/typography.dart';
import 'package:classroom/routes/login.dart';
import 'package:classroom/services/auth.dart';
import 'package:classroom/widgets/loadingSpinner.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:classroom/controllers/home_controllers.dart';
import 'package:classroom/views/home.dart';
import 'package:classroom/views/playlist.dart';
import 'package:classroom/views/trend.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<ColorPicker>(create: (ctx) => ColorPicker()),
      Provider<Auth>(create: (ctx) => Auth()),
      Provider<TypoGraphyOfApp>(create: (ctx) => TypoGraphyOfApp()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(builder: (context, auth, _) {
      return StreamBuilder<Object?>(
        stream: auth.onAuthChange,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final _user = snapshot.data;
            if (_user == null) {
              return const SignIn();
            } else {
              return const HomePage();
            }
          } else {
            return loadingSpinner();
          }
        },
      );
    });
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
    final color = Provider.of<ColorPicker>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeController(),
        )
      ],
      child: CupertinoApp(
        theme: CupertinoThemeData(
          brightness: color.light ? Brightness.light : Brightness.dark,
          primaryColor: CupertinoColors.systemBlue,
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
