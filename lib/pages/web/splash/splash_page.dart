import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rxdart/rxdart.dart';
import 'package:se310_o11_pmcl/resources/colors.dart';
import 'package:se310_o11_pmcl/widgets/ink_well_wrapper.dart';

import '../../../blocs/blocs.dart';
import '../../../core/core.dart';
import '../../../gen/assets.gen.dart';
import '../../../router/router.dart';
import 'widget/animation_background.dart';

class SplashPage extends StatefulWidget {
  final SplashBloc bloc;

  SplashPage(this.bloc);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends BaseState<SplashPage, SplashBloc>
    with TickerProviderStateMixin {
  @override
  SplashBloc get bloc => widget.bloc;

  late AnimationController controller;
  late AnimationController navigaoteController;
  var isNavigate = BehaviorSubject.seeded(false);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: -1,
      upperBound: 0,
    );

    navigaoteController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: -1,
      upperBound: 1,
    );

    controller.animateTo(0,
        curve: Curves.easeOut, duration: const Duration(seconds: 9));
  }

  @override
  Widget buildContent(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return StreamBuilder<bool>(
        stream: isNavigate,
        builder: (context, snapshot) {
          var data = snapshot.data ?? true;
          return Column(
            children: [
              Stack(
                children: [
                  AnimatedBackground(),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: AnimatedBuilder(
                          animation: controller,
                          builder: (_, Widget? child) {
                            return Transform.translate(
                              offset: Offset(0, controller.value * -500),
                              child: child,
                            );
                          },
                          child: Visibility(
                            visible: !data,
                            child: SizedBox(
                                width: 250,
                                height: 250,
                                child: LottieBuilder.asset(
                                  "assets/images/json/launch.json",
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        flex: 2,
                        child: Visibility(
                          visible: !data,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: screenSize.height / 4,
                              ),
                              Card(
                                color: Colors.white.withOpacity(0.5),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    localization.wellcome_to_panda_english,
                                    style: const TextStyle(
                                        letterSpacing: 0.5,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Card(
                                  color: Colors.white.withOpacity(0.5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                      localization.wellcome_content,
                                      style: const TextStyle(
                                          letterSpacing: 0.5,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              InkWellWrapper(
                                onTap: () {
                                  isNavigate.add(true);
                                  navigaoteController
                                      .animateTo(0,
                                          curve: Curves.easeIn,
                                          duration: const Duration(seconds: 4))
                                      .then((value) {
                                    Navigator.pushNamed(context, Routes.authentication);
                                  });
                                },
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                borderRadius: BorderRadius.circular(24),
                                paddingChild: EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 36),
                                child: Text(
                                  localization.get_started,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  AnimatedBuilder(
                    animation: navigaoteController,
                    builder: (_, Widget? child) {
                      return Transform.translate(
                        offset: Offset(
                          navigaoteController.value * -screenSize.width,
                          screenSize.height / 4,
                        ),
                        child: child,
                      );
                    },
                    child: SizedBox(
                        width: 300,
                        height: 300,
                        child: LottieBuilder.asset(
                          "assets/images/json/move_panda.json",
                          fit: BoxFit.cover,
                          width: 300,
                          height: 300,
                        )),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
