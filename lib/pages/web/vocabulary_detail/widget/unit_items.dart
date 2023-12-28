import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import '../../../../data/data.dart';
import '../../../../resources/colors.dart';
import '../../search/widget/audiod.dart';

class UnitFlipCard extends StatelessWidget {
  final Vocabulary? vocabulary;
  final Function(bool)? onFlipDone;
  const UnitFlipCard({
    super.key,
    required this.vocabulary,
    this.onFlipDone,
  });

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      back: Stack(
        fit: StackFit.loose,
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xFF4993FA),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.24),
                  blurRadius: 20.0,
                  offset: const Offset(0.0, 10.0),
                  spreadRadius: 10,
                  blurStyle: BlurStyle.outer,
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  vocabulary?.word ?? "",
                  style: const TextStyle(
                    fontSize: 40,
                    color: AppColors.primaryWhite,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  vocabulary?.type ?? "",
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.primaryWhite,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(vocabulary?.phonetics ?? "",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white.withOpacity(0.5),
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(height: 30),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Meaning: ',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      TextSpan(
                        text: vocabulary?.meaning ?? "",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AudioPlayerButton(
            url: vocabulary?.pronouce ?? "",
          ),
          Positioned(
            left: -120,
            top: 50,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFF4993FA),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      front: Stack(
        fit: StackFit.loose,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xFF4993FA),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.network(
                        vocabulary?.image ?? "",
                        scale: 3,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          //text: 'Meaning: ',
                          text: 'Hint: ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: vocabulary?.hint ?? "",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: -120,
            top: 30,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFF4993FA).withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: -100,
            bottom: 20,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFF4993FA),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UnitSwipeableStack extends StatelessWidget {
  final List<Widget> items;
  final VoidCallback? onTap;

  final AppinioSwiperController controller;
  const UnitSwipeableStack({
    super.key,
    required this.items,
    required this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AppinioSwiper(
        cardBuilder: (context, index) {
          return items[index];
        },
        onEnd: () => onTap?.call(),
        cardCount: items.length,
        controller: controller,
      ),
    );
  }
}
