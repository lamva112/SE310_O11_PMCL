import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import '../../../../data/data.dart';
import '../../../../widgets/ink_well_wrapper.dart';

import '../../../../constants.dart';
import '../../search/widget/audiod.dart';

class RotatingShiningCard extends StatefulWidget {
  final double width, height;
  final String image, word, type, hint, phonetics, meaning;
  const RotatingShiningCard({
    super.key,
    required this.width,
    required this.height,
    required this.image,
    required this.word,
    required this.type,
    required this.hint,
    required this.phonetics,
    required this.meaning,
  });

  @override
  RotatingShiningCardState createState() => RotatingShiningCardState();
}

/// The state for a [RotatingShiningCard] widget.
class RotatingShiningCardState extends State<RotatingShiningCard> {
  /// The current X angle of the card.
  double xAngle = 0.0;

  /// The current Y angle of the card.
  double yAngle = 0.0;

  /// The offset of the shining effect relative to the card.
  Offset shineOffset = Offset.zero;

  void onHover(PointerEvent event) {
    // Calculate the angles of rotation based on the position of the mouse
    // pointer
    final dx = event.localPosition.dx - (context.size!.width / 2);
    final dy = event.localPosition.dy - (context.size!.height / 2);
    final angleX = math.atan2(dy, context.size!.height);
    final angleY = math.atan2(dx, context.size!.width);

    // Store the position of the mouse pointer
    shineOffset = event.localPosition;

    // Update the state to trigger a rebuild with the new angles of rotation
    setState(() {
      xAngle = angleX;
      yAngle = angleY;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: onHover,
      child: Transform(
        // Set the center point of the rotation to be the center of the widget
        alignment: FractionalOffset.center,
        // Apply a series of transformations to the widget
        transform: Matrix4.identity()
          // Set a small perspective effect by adjusting the z value
          ..setEntry(3, 2, 0.001)
          // Rotate the widget around the x-axis based on the y position of the
          // mouse
          ..rotateX(-xAngle)
          // Rotate the widget around the y-axis based on the x position of the
          // mouse
          ..rotateY(-yAngle),
        child: ClipRect(
          child: Stack(
            children: [
              // Display the Pokemon card image
              InkWellWrapper(
                onTap: () {
                  Navigator.pop(context);
                },
                margin: const EdgeInsets.all(24),
                child: Material(
                  elevation: 10,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: SizedBox(
                              width: double.infinity,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                child: Text(
                                  widget.word,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ),
                            subtitle: Text(
                              widget.phonetics,
                              style: const TextStyle(
                                fontSize: 18,
                                letterSpacing: 1.2,
                              ),
                            ),

                            // trailing: IconButton(
                            //   icon: Icon(
                            //     Icons.headphones,
                            //     color: Colors.grey,
                            //     size: 30,
                            //   ),
                            //   onPressed: () async {
                            //     final player = AudioPlayer();
                            //     await player.play(UrlSource('https://drive.google.com/uc?export=view&id=1BjoSz1EGXWxLnbc8Uk9eV3ebOEOEDSfA'));
                            //   },
                            // ),
                            trailing: Text(
                              widget.type,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                              height: 230,
                              margin: const EdgeInsets.only(
                                top: 10,
                                left: 10,
                                right: 10,
                                bottom: 0,
                              ),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              child: ImageNetwork(
                                image: widget.image,
                                height: 250,
                                width: 250,
                                duration: 1500,
                                curve: Curves.easeIn,
                                onPointer: true,
                                debugPrint: false,
                                fullScreen: false,
                                fitAndroidIos: BoxFit.cover,
                                fitWeb: BoxFitWeb.cover,
                                borderRadius: BorderRadius.circular(70),
                                onLoading: const CircularProgressIndicator(
                                  color: Colors.indigoAccent,
                                ),
                                onError: const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                                onTap: () {},
                              )),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                userData[1]["isLiked"]
                                    ? IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.favorite,
                                          color: Colors.pink,
                                          size: 24,
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.favorite_outline,
                                          size: 24,
                                        ),
                                      ),
                                const Spacer(),
                                AudioPlayerButton(url: ""),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 32),
                            child: Expanded(
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 6,
                                    backgroundImage: AssetImage(
                                      userData[1]["logo"],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.hint,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        // letterSpacing: 1.1,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 14,
                            ),
                            child: Text(
                              widget.meaning,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                // letterSpacing: 1.1,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              // Column(
              //   children: [
              //     Container(
              //       width: widget.width,
              //       height: widget.height,
              //       color: Colors.white,
              //     )
              //   ],
              // ),
              // Add a shining effect based on the position of the mouse
              // pointer.
              // A gradient that creates the shine effect on the card
              Positioned(
                left: shineOffset.dx - widget.width,
                top: shineOffset.dy - widget.height,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: widget.width * 2,
                    height: widget.height * 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.white.withOpacity(.5),
                          Colors.transparent,
                        ],
                        stops: const [0, 1],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
