import 'package:classroom/controllers/color_controllers.dart';
import 'package:classroom/controllers/font_controller.dart';
import 'package:classroom/model/database_users.dart';
import 'package:classroom/routes/login.dart';
import 'package:classroom/routes/user_info.dart';
import 'package:classroom/services/auth.dart';
import 'package:classroom/services/db.dart';
import 'package:classroom/widgets/loading_spinner.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:classroom/views/home.dart';
import 'package:classroom/views/account.dart';
import 'package:classroom/views/trend.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ColorPicker>(create: (ctx) => ColorPicker()),
        Provider<Auth>(create: (ctx) => Auth()),
        Provider<FontsForApp>(create: (ctx) => FontsForApp()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    final color = Provider.of<ColorPicker>(context);
    return StreamBuilder<User?>(
      stream: auth.onAuthChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? _user = snapshot.data;
          if (_user == null) {
            return CupertinoApp(
              theme: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  textStyle: GoogleFonts.sourceSansPro(
                    color: color.light
                        ? CupertinoColors.white
                        : CupertinoColors.black,
                  ),
                ),
                brightness: color.light ? Brightness.light : Brightness.dark,
                primaryColor: CupertinoColors.systemBlue,
              ),
              home: const SignIn(),
            );
          } else {
            return ChangeNotifierProvider<Database>(
              create: (ctx) => Database(uid: _user.uid, email: _user.email),
              child: HomePage(
                email: _user.email,
                uid: _user.uid,
              ),
            );
          }
        } else {
          return loadingSpinner();
        }
      },
    );
  }
}

class HomePage extends StatefulWidget {
  final String uid;
  final String email;
  const HomePage({Key? key, required this.email, required this.uid})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();

  CupertinoTabController tabController =
      CupertinoTabController(initialIndex: 0);

  @override
  void initState() {
    super.initState();
    tabController = CupertinoTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    final listOfKeys = [firstTabNavKey, secondTabNavKey, thirdTabNavKey];
    List homeScreenList = [
      const HomeUI(),
      const PlayListUI(),
      const TrendsUI(),
    ];
    return Consumer2<Database, ColorPicker>(builder: (context, db, color, _) {
      return CupertinoApp(
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
          child: StreamBuilder<List<UserFromDatabase>>(
              stream: db.userstream(),
              builder: (context, usersnap) {
                if (usersnap.hasData) {
                  if (usersnap.data!.any((element) => element.uid == db.uid)) {
                    return Provider<UserFromDatabase>.value(
                      value: usersnap.data!
                          .where((element) => element.uid == db.uid)
                          .first,
                      child: CupertinoTabScaffold(
                        controller: tabController,
                        tabBar: CupertinoTabBar(
                          items: const <BottomNavigationBarItem>[
                            BottomNavigationBarItem(
                              icon: Icon(CupertinoIcons.home),
                              label: 'Home',
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(CupertinoIcons.triangle),
                              label: 'Trending',
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(CupertinoIcons.app_badge_fill),
                              label: 'Notification',
                            ),
                          ],
                        ),
                        tabBuilder: (context, index) {
                          return CupertinoTabView(
                            builder: (BuildContext context) => CupertinoTabView(
                              navigatorKey: listOfKeys[
                                  index], //set navigatorKey here which was initialized before
                              builder: (context) {
                                return homeScreenList[index];
                              },
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const MakePage();
                  }
                }
                return loadingSpinner();
              }),
        ),
      );
    });
  }
}
