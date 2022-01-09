import 'package:flutter/cupertino.dart';

class PlayListUI extends StatelessWidget {
  const PlayListUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const CupertinoSliverNavigationBar(
              largeTitle: Text('Trends'),
            )
          ];
        },
        body: ListView.builder(
          itemCount: 200,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: CupertinoColors.activeBlue,
                height: 200,
              ),
            );
          },
        ),
      ),
    );
  }
}
