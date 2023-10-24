
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:se310_o11_pmcl/extensions/extensions.dart';
import '../../../../enums.dart';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: FlareActor(
        FlareEnum.background.rawValue,
        alignment: Alignment.center,
        fit: BoxFit.cover,
        animation: FlareKeys.midnight.name,
      ),
    );
  }
}