import 'package:classroom/controllers/color_controllers.dart';
import 'package:classroom/controllers/data.dart';
import 'package:classroom/controllers/font_controller.dart';
import 'package:classroom/model/all_topics.dart';
import 'package:classroom/model/database_users.dart';
import 'package:classroom/services/db.dart';
import 'package:classroom/widgets/error_dialog.dart';
import 'package:classroom/widgets/text_form.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddReview extends StatelessWidget {
  final UserFromDatabase user;
  final ClassDataStudent index;
  const AddReview({
    Key? key,
    required this.index,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController message = TextEditingController();
    final font = Provider.of<TypoGraphyOfApp>(context);
    final color = Provider.of<ColorPicker>(context);

    return CupertinoPageScaffold(
      child: NestedScrollView(
        // physics: const NeverScrollableScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const CupertinoSliverNavigationBar(
              previousPageTitle: "Classes",
              largeTitle: Text('Reviews & Ratings'),
            )
          ];
        },
        body: Consumer2<Database, ClassDataStudent>(
          builder: (context, db, data, _) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: data.reviews.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, dynamic> _data = data.reviews[index] ?? {};

                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      color: color.cardColor(), width: 1),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor:
                                                Colors.blue.shade900,
                                            child: Text(_data['name']
                                                .toString()
                                                .toCapitalized()
                                                .substring(0, 1)
                                                .toUpperCase()),
                                          ),
                                          const SizedBox(width: 15),
                                          Column(
                                            children: [
                                              font.body1(
                                                _data['name']
                                                    .toString()
                                                    .toCapitalized(),
                                                color.textColor(),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: font.body1(
                                          _data['message'], color.textColor()),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Row(
                  children: <Widget>[
                    CupertinoButton(
                        padding: const EdgeInsets.all(3),
                        child: Icon(
                          CupertinoIcons.star,
                          color: color.onlyBlue(),
                        ),
                        onPressed: () async {
                          await addRating(
                              context, db, data.classX, data.id, data.rating);
                        }),
                    Expanded(
                      child: FormFeildApp(
                        suffix: CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: font.button('Send', color.onlyBlue()),
                          onPressed: () {
                            db.addReview(data, user.name, message.text);
                            message.clear();
                            Navigator.pop(context);
                          },
                        ),
                        controller: message,
                        placeholder: "Review...",
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
