import 'package:cached_network_image/cached_network_image.dart';
import 'package:classroom/controllers/color_controllers.dart';
import 'package:classroom/controllers/font_controller.dart';
import 'package:classroom/widgets/mapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({
    Key? key,
    required this.text,
    required this.level,
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
  final String level;
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
                            ? color.onlyBlue()
                            : color.onlyBlue()
                : ismentor
                    ? ispin
                        ? color.yellow()
                        : color.nowarning()
                    : filter.hasProfanity(text)
                        ? color.red()
                        : color.onlyWhite(),
            borderRadius: BorderRadius.circular(16),
          ),
          child: media.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: ismentor
                                      ? MapperX().getMapperX("Mentor")
                                      : MapperX().getMapperX(level),
                                  child: font.body2(
                                    username.substring(0, 1),
                                    color.onlyWhite(),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                font.heading6(
                                    username,
                                    !isCurrentUser
                                        ? CupertinoColors.darkBackgroundGray
                                        : ispin &&
                                                filter.hasProfanity(text) ==
                                                    false
                                            ? color.onlyBlue()
                                            : color.textColor()),
                              ],
                            ),
                            ispin
                                ? Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(
                                      CupertinoIcons.star_circle_fill,
                                      color: ismentor
                                          ? CupertinoColors.darkBackgroundGray
                                          : color.yellow(),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
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
                          ? Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                CupertinoIcons.star_circle_fill,
                                color: ismentor
                                    ? CupertinoColors.darkBackgroundGray
                                    : color.yellow(),
                              ),
                            )
                          : const SizedBox(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: ismentor
                                    ? MapperX().getMapperX("Mentor")
                                    : MapperX().getMapperX(level),
                                child: font.body2(
                                  username.substring(0, 1),
                                  color.onlyWhite(),
                                ),
                              ),
                              const SizedBox(width: 10),
                              font.heading6(
                                  username,
                                  !isCurrentUser
                                      ? CupertinoColors.darkBackgroundGray
                                      : ispin &&
                                              filter.hasProfanity(text) == false
                                          ? color.onlyBlue()
                                          : color.textColor()),
                            ],
                          ),
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
