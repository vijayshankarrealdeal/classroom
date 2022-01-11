import 'package:classroom/controllers/request.dart';
import 'package:classroom/widgets/error_dialog.dart';
import 'package:classroom/widgets/text_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class MakeARequest extends StatelessWidget {
  const MakeARequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const CupertinoSliverNavigationBar(
              previousPageTitle: "Trends",
              largeTitle: Text('Request'),
            )
          ];
        },
        body: ChangeNotifierProvider<RequestController>(
          create: (ctx) => RequestController(),
          child: Consumer<RequestController>(builder: (context, req, _) {
            return ListView(
              children: [
                FormFeildApp(placeholder: 'Name', controller: req.name),
                FormFeildApp(
                    placeholder: 'Chapter/Topic', controller: req.topic),
                FormFeildApp(
                  placeholder: 'Reason For Your Request',
                  controller: req.request,
                  maxlines: 8,
                ),
                FormFeildApp(
                  placeholder:
                      'Tell about yourself and your interset in topic , so mentor know about yourself. ',
                  controller: req.about,
                  maxlines: 10,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CupertinoButton.filled(
                      child: const Text(
                        "submit",
                        style: TextStyle(
                          color: CupertinoColors.white,
                        ),
                      ),
                      onPressed: () {
                        if (req.validate()) {
                        } else {
                          errorAlert(context, "Fill All Fields");
                        }
                      }),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
