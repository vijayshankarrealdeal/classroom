import 'package:classroom/controllers/chat_data.dart';
import 'package:classroom/widgets/chat_bubble.dart';
import 'package:classroom/widgets/text_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DiscussionText extends StatelessWidget {
  const DiscussionText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _message = TextEditingController();
    return CupertinoPageScaffold(
      child: NestedScrollView(
        // physics: const NeverScrollableScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              previousPageTitle: "Classes",
              largeTitle: const Text('Talk'),
              trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(CupertinoIcons.video_camera),
                  onPressed: () {}),
            )
          ];
        },
        body: Stack(
          children: <Widget>[
            ChangeNotifierProvider(
              create: (conetxt) => ChatControllers(),
              child: Consumer<ChatControllers>(builder: (context, chatdata, _) {
                return ListView.builder(
                  reverse: true,
                  itemCount: chatdata.datapublic.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 10, bottom: 80),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ChatBubble(
                        text: chatdata.data[index].text,
                        isCurrentUser: chatdata.data[index].isCurrentUser);
                  },
                );
              }),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: double.infinity,
                color: CupertinoTheme.of(context).scaffoldBackgroundColor,
                child: Row(
                  children: <Widget>[
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      child: const Icon(
                        CupertinoIcons.add,
                        color: CupertinoColors.systemBlue,
                      ),
                    ),
                    Expanded(
                      child: FormFeildApp(
                        suffix: CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: const Text('Send'),
                          onPressed: () {},
                        ),
                        controller: _message,
                        placeholder: "Message",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        // ListView(
        //   children: [
        //     Align(
        //         alignment: Alignment.bottomLeft,
        //         child: Container(
        //             color: CupertinoColors.activeBlue,
        //             child: FormFeildApp(
        //                 placeholder: 'Text', controller: _message))),
        //     ListView.builder(
        //       physics: const NeverScrollableScrollPhysics(),
        //       shrinkWrap: true,
        //       itemCount: 8,
        //       itemBuilder: (conetxt, index) {
        //         return Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Container(
        //             height: 200,
        //             color: CupertinoColors.systemRed,
        //           ),
        //         );
        //       },
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
