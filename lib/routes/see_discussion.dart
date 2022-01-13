import 'package:classroom/model/chat_model.dart';
import 'package:classroom/model/database_users.dart';
import 'package:classroom/services/db.dart';
import 'package:classroom/widgets/chat_bubble.dart';
import 'package:classroom/widgets/loading_spinner.dart';
import 'package:classroom/widgets/text_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DiscussionText extends StatelessWidget {
  final String classid;
  final UserFromDatabase user;
  const DiscussionText({Key? key, required this.user, required this.classid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController message = TextEditingController();

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
        body: Consumer<Database>(builder: (context, db, _) {
          return StreamBuilder<List<ChatModelX>>(
              stream: db.classDiscuss(classid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Stack(
                    children: <Widget>[
                      ListView.builder(
                        reverse: true,
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 10, bottom: 80),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ChatBubble(
                              ismentor: snapshot.data![index].ismentor,
                              text: snapshot.data![index].text,
                              isCurrentUser:
                                  snapshot.data![index].uid == db.uid);
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          width: double.infinity,
                          color: CupertinoTheme.of(context)
                              .scaffoldBackgroundColor,
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
                                    onPressed: () {
                                      db.addChat(
                                          ChatModelX(
                                              ismentor: user.isMentor,
                                              text: message.text,
                                              time: Timestamp.now(),
                                              uid: db.uid),
                                          classid);
                                      message.clear();
                                    },
                                  ),
                                  controller: message,
                                  placeholder: "Message",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return loadingSpinner();
                }
              });
        }),

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
