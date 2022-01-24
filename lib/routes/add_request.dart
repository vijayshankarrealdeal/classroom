import 'package:classroom/controllers/request.dart';
import 'package:classroom/model/all_topics.dart';
import 'package:classroom/model/database_users.dart';
import 'package:classroom/model/notificaiton_req.dart';
import 'package:classroom/services/db.dart';
import 'package:classroom/widgets/error_dialog.dart';
import 'package:classroom/widgets/loading_spinner.dart';
import 'package:classroom/widgets/text_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class MakeARequest extends StatelessWidget {
  const MakeARequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFromDatabase>(context);
    String id = const Uuid().v4();
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const CupertinoSliverNavigationBar(
              previousPageTitle: "Trending",
              largeTitle: Text('Request'),
            )
          ];
        },
        body: ChangeNotifierProvider<RequestController>(
          create: (ctx) => RequestController(),
          child: Consumer<RequestController>(builder: (context, req, _) {
            return ListView(
              children: [
                FormFeildApp(
                  placeholder: 'Class',
                  controller: req.name,
                  type: TextInputType.number,
                ),
                FormFeildApp(
                    placeholder:
                        user.isMentor ? 'Chapter Name' : 'Chapter/Topic',
                    controller: req.topic),
                FormFeildApp(
                  placeholder: user.isMentor
                      ? "Add Subtopics"
                      : 'Reason For Your Request',
                  controller: req.request,
                  maxlines: 8,
                ),
                FormFeildApp(
                  placeholder: user.isMentor
                      ? "Add Somedetails about topic and how student will be benifit from it"
                      : 'Tell about yourself and your interset in topic , so mentor know about yourself. ',
                  controller: req.about,
                  maxlines: 10,
                ),
                const SizedBox(height: 20),
                Consumer<Database>(builder: (context, db, _) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: db.load
                        ? loadingSpinner()
                        : CupertinoButton.filled(
                            child: const Text(
                              "submit",
                              style: TextStyle(
                                color: CupertinoColors.white,
                              ),
                            ),
                            onPressed: () async {
                              if (req.validate()) {
                                if (user.isMentor) {
                                  final data = ClassDataStudent(
                                    rating: 0.3,
                                    mentoruid: user.uid,
                                    classX: req.name.text.toString(),
                                    mentorname: user.name,
                                    subtpoics: req.request.text.split('\n'),
                                    reviews: [],
                                    id: id,
                                    studentenrollUid: [],
                                    topic: req.topic.text,
                                    classInfo: req.about.text,
                                    time: Timestamp.now(),
                                  );
                                  await db.addNewClass(data);
                                  req.clearAll();
                                  errorAlert(context, "Topic Created");
                                } else {
                                  final data = Request(
                                    requestemail: db.email,
                                    id: const Uuid().v4(),
                                    requestBy: db.uid,
                                    classw: req.name.text,
                                    chapter: req.topic.text,
                                    request: req.request.text,
                                    discription: req.about.text,
                                    time: Timestamp.now(),
                                  );
                                  await db.addRequest(data);
                                  req.clearAll();
                                  errorAlert(context, "Topic Created");
                                }
                              } else {
                                errorAlert(context, "Fill All Fields");
                              }
                            }),
                  );
                })
              ],
            );
          }),
        ),
      ),
    );
  }
}
