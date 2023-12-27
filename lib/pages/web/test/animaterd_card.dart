import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

import '../../../data/data.dart';

class AnimatedCard extends StatefulWidget {
  const AnimatedCard({
    Key? key,
    required this.activeColor,
    this.inactiveColor,
    this.onTap,
    this.test,
  }) : super(key: key);

  final Color activeColor;
  final Color? inactiveColor;
  final VoidCallback? onTap;
  final Test? test;

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween(begin: 1.0, end: 11.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_controller.isCompleted) {
          _controller.reverse();
          setState(() {
            _isActive = false;
          });
        } else {
          _controller.forward().then((value) => widget.onTap?.call());
          setState(() {
            _isActive = true;
          });
        }
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          Transform.scale(
                            scale: _scaleAnimation.value,
                            child: Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                color: widget.activeColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    (widget.inactiveColor ?? widget.activeColor)
                                        .withOpacity(_opacityAnimation.value)),
                            child: ImageNetwork(
                              image: widget.test?.image ?? "",
                              height: 130,
                              width: 130,
                              duration: 1500,
                              curve: Curves.easeIn,
                              onPointer: true,
                              debugPrint: false,
                              fullScreen: false,
                              fitAndroidIos: BoxFit.cover,
                              fitWeb: BoxFitWeb.cover,
                              borderRadius: BorderRadius.circular(12),
                              onLoading: const CircularProgressIndicator(
                                color: Colors.indigoAccent,
                              ),
                              onError: const Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                              //onTap: () {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.test?.name ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      _isActive ? Colors.white : Colors.black,
                                ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            '${widget.test?.questions?.length} Questions',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  fontSize: 24,
                                  color:
                                      _isActive ? Colors.white : Colors.black,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
