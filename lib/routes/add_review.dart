import 'package:classroom/model/all_topics.dart';
import 'package:classroom/model/database_users.dart';
import 'package:classroom/services/db.dart';
import 'package:classroom/widgets/text_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AddReview extends StatelessWidget {
  final String classid;
  final ClassDataStudent data;
  final UserFromDatabase user;
  const AddReview(
      {Key? key, required this.data, required this.user, required this.classid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController message = TextEditingController();

    return CupertinoPageScaffold(
      child: NestedScrollView(
        // physics: const NeverScrollableScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const CupertinoSliverNavigationBar(
              previousPageTitle: "",
              largeTitle: Text('add Review'),
            )
          ];
        },
        body: Consumer<Database>(builder: (context, db, _) {
          return Stack(
            children: <Widget>[
              ListView.builder(
                reverse: true,
                itemCount: data.reviews.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 10, bottom: 80),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return SizedBox(
                    child: Text(data.reviews[index]['uid'] == db.uid
                        ? data.reviews[index]['message']
                        : ""),
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: double.infinity,
                  color: CupertinoTheme.of(context).scaffoldBackgroundColor,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: FormFeildApp(
                          suffix: CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: const Text('Send'),
                            onPressed: () {
                              db.addReview(data, user.name, message.text);
                              message.clear();
                              Navigator.pop(context);
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
        }),

        // ),
      ),
    );
  }
}
