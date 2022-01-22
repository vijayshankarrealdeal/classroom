import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profanity_filter/profanity_filter.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({
    Key? key,
    required this.text,
    required this.ismentor,
    required this.isCurrentUser,
    required this.username,
  }) : super(key: key);
  final String text;
  final bool ismentor;
  final bool isCurrentUser;
  final String username;

  final filter = ProfanityFilter();
  @override
  Widget build(BuildContext context) {
    return Padding(
      // asymmetric padding
      padding: EdgeInsets.fromLTRB(
        isCurrentUser ? 64.0 : 16.0,
        4,
        isCurrentUser ? 16.0 : 64.0,
        4,
      ),
      child: Align(
        // align the child within the container
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: DecoratedBox(
          // chat bubble decoration
          decoration: BoxDecoration(
            color: isCurrentUser
                ? filter.hasProfanity(text)
                    ? CupertinoColors.destructiveRed
                    : CupertinoColors.activeBlue
                : ismentor
                    ? CupertinoColors.systemGreen
                    : CupertinoColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: isCurrentUser
                          ? Colors.purple.shade900
                          : ismentor
                              ? CupertinoColors.white
                              : Colors.black87),
                ),
                Text(
                  filter.hasProfanity(text)
                      ? 'This is an inappropriate message.\n Please maintain discipline of class'
                      : text,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: isCurrentUser
                          ? Colors.white
                          : ismentor
                              ? CupertinoColors.white
                              : Colors.black87),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
