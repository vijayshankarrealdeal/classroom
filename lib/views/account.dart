import 'package:classroom/controllers/color_controllers.dart';
import 'package:classroom/controllers/font_controller.dart';
import 'package:classroom/services/auth.dart';
import 'package:classroom/widgets/error_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrendsUI extends StatelessWidget {
  const TrendsUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final font = Provider.of<FontsForApp>(context);
    final color = Provider.of<ColorPicker>(context);

    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: const Text('Notification'),
              trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Text('Logout'),
                  onPressed: () => logout(
                        context,
                        "You Have Sign in again",
                        Provider.of<Auth>(context, listen: false),
                      )),
            )
          ];
        },
        body: ListView(
          children: [
            Container(
              height: 200,
              color: CupertinoColors.activeBlue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: CupertinoColors.systemTeal,
                      radius: 50,
                    ),
                    const SizedBox(width: 10),
                    font.headline1("Name", color),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: font.headline1("Notifications", color),
            ),
            ListView.builder(
              itemCount: 100,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: CupertinoColors.activeGreen,
                    ),
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
