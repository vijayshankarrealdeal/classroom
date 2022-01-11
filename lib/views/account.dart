import 'package:classroom/services/auth.dart';
import 'package:classroom/widgets/error_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class TrendsUI extends StatelessWidget {
  const TrendsUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        body: CustomScrollView(
          slivers: [],
        ),
      ),
    );
  }
}
