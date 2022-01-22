import 'package:cached_network_image/cached_network_image.dart';
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
    required this.ispin,
    required this.media,
  }) : super(key: key);
  final String text;
  final String media;
  final bool ismentor;
  final bool isCurrentUser;
  final String username;
  final bool ispin;

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
                    : ispin
                        ? CupertinoColors.systemPink
                        : media.isNotEmpty
                            ? CupertinoColors.darkBackgroundGray
                            : CupertinoColors.activeBlue
                : ismentor
                    ? ispin
                        ? CupertinoColors.systemYellow
                        : CupertinoColors.systemGreen
                    : filter.hasProfanity(text)
                        ? CupertinoColors.destructiveRed
                        : CupertinoColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: media.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                      CachedNetworkImage(
                        imageUrl: media,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(12),
                  child: Stack(
                    children: [
                      ispin
                          ? const Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                CupertinoIcons.pin,
                                color: Colors.black,
                              ),
                            )
                          : SizedBox(),
                      Column(
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
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: isCurrentUser
                                        ? Colors.white
                                        : ismentor
                                            ? CupertinoColors.white
                                            : Colors.black87),
                          ),
                        ],
                      ),
                    ],
                  )),
        ),
      ),
    );
  }
}
