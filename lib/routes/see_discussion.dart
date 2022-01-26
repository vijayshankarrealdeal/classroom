import 'dart:io';
import 'package:classroom/controllers/color_controllers.dart';
import 'package:classroom/controllers/data.dart';
import 'package:classroom/controllers/font_controller.dart';
import 'package:classroom/model/chat_model.dart';
import 'package:classroom/model/database_users.dart';
import 'package:classroom/routes/show_user_info.dart';
import 'package:classroom/services/db.dart';
import 'package:classroom/widgets/chat_bubble.dart';
import 'package:classroom/widgets/loading_spinner.dart';
import 'package:classroom/widgets/text_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class DiscussionText extends StatefulWidget {
  final String classid;
  final UserFromDatabase user;
  const DiscussionText({Key? key, required this.user, required this.classid})
      : super(key: key);

  @override
  State<DiscussionText> createState() => _DiscussionTextState();
}

class _DiscussionTextState extends State<DiscussionText> {
  Future<String> _uploadImageToFirebase(File file) async {
    final _ref = FirebaseStorage.instance.ref('/userpost/');
    file = await _compressFile(file);
    final storage = _ref.child('${DateTime.now().millisecondsSinceEpoch}');
    final link = await storage.putFile(file);
    final snap = await link.ref.getDownloadURL();
    return snap;
  }

  Future<File> _compressFile(File file) async {
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: 45,
    );
    return result!;
  }

  Future<void> pickCrop(Database db) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    final image_ = await _cropImage(File(image!.path));
    final url = await _uploadImageToFirebase(image_);
    db.addChat(
        ChatModelX(
            media: url,
            id: const Uuid().v4(),
            pin: false,
            ismentor: widget.user.isMentor,
            text: '',
            time: Timestamp.now(),
            uid: db.uid),
        widget.classid);
  }

  Future<File> _cropImage(File imageFile) async {
    File? croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: CupertinoColors.activeBlue,
          toolbarWidgetColor: CupertinoColors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: const IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
    );
    return croppedFile!;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController message = TextEditingController();

    return Consumer2<Database, ColorPicker>(
      builder: (context, db, color, _) {
        return StreamBuilder<List<ChatModelX>>(
          stream: db.classDiscuss(widget.classid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  previousPageTitle: "Classes",
                  middle: const Text('Discussion'),
                  trailing: Column(
                    children: [
                      CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Provider.of<TypoGraphyOfApp>(context,
                                  listen: false)
                              .button("Join Meeting", color.onlyBlue()),
                          onPressed: () {}),
                    ],
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Focus.of(context).unfocus();
                  },
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          child: snapshot.data!.isEmpty
                              ? Text(
                                  "No Messages",
                                  style: TextStyle(
                                      color: color.textColor(), fontSize: 29),
                                )
                              : ListView.builder(
                                  reverse: true,
                                  itemCount: color.onlypins
                                      ? snapshot.data!
                                          .where(
                                              (element) => element.pin == true)
                                          .length
                                      : snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return StreamBuilder<UserFromDatabase>(
                                      stream: db
                                          .userchat(snapshot.data![index].uid),
                                      builder: (context, user) {
                                        return user.hasData
                                            ? GestureDetector(
                                                onTap: () {
                                                  if (user.data!.uid !=
                                                      db.uid) {
                                                    Navigator.of(context,
                                                            rootNavigator:
                                                                false)
                                                        .push(
                                                      CupertinoPageRoute(
                                                        builder: (context) =>
                                                            UserInfoX(
                                                          user: user.data!,
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },
                                                onLongPress: () {
                                                  {
                                                    _pinmessage(
                                                      context,
                                                      db,
                                                      snapshot.data![index],
                                                      user.data!,
                                                      widget.classid,
                                                    );
                                                  }
                                                },
                                                child: ChatBubble(
                                                    media: snapshot
                                                        .data![index].media,
                                                    ispin: snapshot
                                                        .data![index].pin,
                                                    username: user.data!.name
                                                        .toCapitalized(),
                                                    level: user.data!.level,
                                                    ismentor: snapshot
                                                        .data![index].ismentor,
                                                    text: snapshot
                                                        .data![index].text,
                                                    isCurrentUser: snapshot
                                                            .data![index].uid ==
                                                        db.uid))
                                            : const SizedBox();
                                      },
                                    );
                                  },
                                ),
                        ),
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
                                onPressed: () {
                                  pickCrop(db);
                                },
                                child: const Icon(
                                  CupertinoIcons.photo,
                                  color: CupertinoColors.systemBlue,
                                ),
                              ),
                              Expanded(
                                child: FormFeildApp(
                                  suffix: CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    child: Icon(
                                      CupertinoIcons.location_fill,
                                      color: color.onlyBlue(),
                                    ),
                                    onPressed: () {
                                      db.addChat(
                                          ChatModelX(
                                              media: '',
                                              id: const Uuid().v4(),
                                              pin: false,
                                              ismentor: widget.user.isMentor,
                                              text: message.text,
                                              time: Timestamp.now(),
                                              uid: db.uid),
                                          widget.classid);
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
                  ),
                ),
              );
            } else {
              return loadingSpinner();
            }
          },
        );
      },
    );
  }

  Future<void> _pinmessage(BuildContext context, Database db, ChatModelX data,
      UserFromDatabase user, String classid) async {
    return showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
              !data.pin ? "Star this message" : "Only Mentor can unstar it"),
          actions: data.pin == false
              ? [
                  CupertinoButton(
                    child: const Text("Star"),
                    onPressed: () {
                      db.updatePin(data, classid);
                      Navigator.pop(context);
                    },
                  ),
                  CupertinoButton(
                    child: const Text("Cancel"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ]
              : user.uid == db.uid && user.isMentor == true
                  ? [
                      CupertinoButton(
                          child: const Text("Un Star"),
                          onPressed: () {
                            db.updatePin(data, classid);
                            Navigator.pop(context);
                          }),
                      CupertinoButton(
                        child: const Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ]
                  : [
                      CupertinoButton(
                        child: const Text("Okay"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
        );
      },
    );
  }
}
