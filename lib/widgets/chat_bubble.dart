import 'package:cached_network_image/cached_network_image.dart';
import 'package:classroom/controllers/color_controllers.dart';
import 'package:classroom/controllers/font_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:provider/provider.dart';

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
    final font = Provider.of<TypoGraphyOfApp>(context);
    final color = Provider.of<ColorPicker>(context);

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
                        ? CupertinoColors.darkBackgroundGray
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
                      font.heading5(
                          username, CupertinoColors.darkBackgroundGray),
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
                          ? Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                CupertinoIcons.pin,
                                color: color.textColor(),
                              ),
                            )
                          : const SizedBox(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          font.heading5(
                              username,
                              !isCurrentUser
                                  ? CupertinoColors.darkBackgroundGray
                                  : color.textColor()),
                          Text(
                            filter.hasProfanity(text)
                                ? 'This is an inappropriate message.\n Please maintain discipline of class'
                                : text,
                            style: GoogleFonts.sourceSansPro(
                                color: isCurrentUser
                                    ? Colors.white
                                    : ismentor
                                        ? CupertinoColors.white
                                        : Colors.black87,
                                fontSize: 15,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5),
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
