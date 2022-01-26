import 'package:classroom/controllers/userinfo_control.dart';
import 'package:classroom/services/db.dart';
import 'package:classroom/widgets/loading_spinner.dart';
import 'package:classroom/widgets/text_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class MakePage extends StatelessWidget {
  const MakePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context, listen: false);
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("About you"),
      ),
      child: ChangeNotifierProvider<UserInfoAdd>(
        create: (ctx) => UserInfoAdd(),
        child: Consumer<UserInfoAdd>(builder: (context, control, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormFeildApp(placeholder: 'Name', controller: control.name),
              FormFeildApp(placeholder: 'Add Bio', controller: control.bio),
     
              CupertinoButton(
                  child: Text(control.classX.toString()),
                  onPressed: () {
                    control.showClassPop(context);
                  }),
              CupertinoButton(
                  child: Text(control.textX.toString()),
                  onPressed: () {
                    control.showmodelpop(context);
                  }),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              control.uploadstart
                  ? Center(child: loadingSpinner())
                  : Center(
                      child: CupertinoButton.filled(
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: CupertinoColors.white),
                        ),
                        onPressed: () => control.save(db, context),
                      ),
                    ),
            ],
          );
        }),
      ),
    );
  }
}
