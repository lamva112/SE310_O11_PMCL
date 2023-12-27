import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import '../../../../data/data.dart';
import '../../../../resources/colors.dart';

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
      back: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.blue,
          border: Border.all(
            color: AppColors.primaryWhite,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              vocabulary?.word??"",
              style: const TextStyle(
                fontSize: 40,
                color: AppColors.primaryBlack,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              vocabulary?.type??"",
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.primaryBlack,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(vocabulary?.phonetics??"",
                style: const TextStyle(
                  fontSize: 20,
                  color: AppColors.primaryGradientDark,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(height: 30),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Hint: ',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.primaryBlack,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextSpan(
                    text: vocabulary?.hint??"",
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.primaryBlack,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      front: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          border: Border.all(
            color: AppColors.primaryBlack,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.network(
                  vocabulary?.image??"",
                  scale: 3,
                ),
                // PronounceWidget(
                //   url: vocabulary.pronounce!,
                // ),
              ],
            ),
            const SizedBox(height: 30),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Meaning: ',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.primaryLight,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextSpan(
                    text: vocabulary?.meaning??"",
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.primaryBlack,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
