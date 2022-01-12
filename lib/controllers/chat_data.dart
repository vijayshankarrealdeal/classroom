import 'package:classroom/model/chat_model.dart';
import 'package:flutter/cupertino.dart';

class ChatControllers extends ChangeNotifier {
  List<ChatModelX> data = [
    ChatModelX(
      text: 'How was the concert?',
      isCurrentUser: false,
    ),
    ChatModelX(
      text: 'Awesome! Next time you gotta come as well!',
      isCurrentUser: true,
    ),
    ChatModelX(
      text: 'Ok, when is the next date?',
      isCurrentUser: false,
    ),
    ChatModelX(
      text: 'They\'re playing on the 20th of November',
      isCurrentUser: true,
    ),
    ChatModelX(
      text: 'Let\'s do it!',
      isCurrentUser: false,
    ),
    ChatModelX(
      text: 'How was the concert?',
      isCurrentUser: false,
    ),
    ChatModelX(
      text: 'Awesome! Next time you gotta come as well!',
      isCurrentUser: true,
    ),
    ChatModelX(
      text: 'Ok, when is the next date?',
      isCurrentUser: false,
    ),
    ChatModelX(
      text: 'They\'re playing on the 20th of November',
      isCurrentUser: true,
    ),
    ChatModelX(
      text: 'Let\'s do it!',
      isCurrentUser: false,
    ),
    ChatModelX(
      text: 'How was the concert?',
      isCurrentUser: false,
    ),
    ChatModelX(
      text: 'Awesome! Next time you gotta come as well!',
      isCurrentUser: true,
    ),
    ChatModelX(
      text: 'Ok, when is the next date?',
      isCurrentUser: false,
    ),
    ChatModelX(
      text: 'They\'re playing on the 20th of November',
      isCurrentUser: true,
    ),
    ChatModelX(
      text: 'Let\'s do it!',
      isCurrentUser: false,
    ),
    ChatModelX(
      text: 'Awesome! Next time you gotta come as well!',
      isCurrentUser: true,
    ),
    ChatModelX(
      text: 'Ok, when is the next date?',
      isCurrentUser: false,
    ),
    ChatModelX(
      text: 'They\'re playing on the 20th of November',
      isCurrentUser: true,
    ),
    ChatModelX(
      text: 'Let\'s do it!',
      isCurrentUser: false,
    ),
  ];

  List<ChatModelX> get datapublic => data..reversed;
}
