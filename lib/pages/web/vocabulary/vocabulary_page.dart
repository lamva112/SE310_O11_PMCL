import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_network/image_network.dart';
import 'package:se310_o11_pmcl/resources/colors.dart';
import '../../../blocs/blocs.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../../router/router.dart';
import 'widget/item_data.dart';
import 'widget/scroll_config.dart';

class VocabularyPage extends StatefulWidget {
  final VocabularyBloc bloc;
  const VocabularyPage({super.key, required this.bloc});

  @override
  State<VocabularyPage> createState() => _VocabularyPageState();
}

class _VocabularyPageState extends BaseState<VocabularyPage, VocabularyBloc> {
  late final PageController _coffeController;
  late final PageController _headingController;
  late double _currentPosition;
  late int _currentHeading;

  void _navigationListener() {
    setState(() {
      _currentPosition = _coffeController.page!;
      // print(_currentPosition);
      if (_currentPosition.round() != _currentHeading) {
        _currentHeading = _currentPosition.round();
        _headingController.animateToPage(_currentHeading,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _coffeController = PageController(viewportFraction: 0.4, initialPage: 4);
    _headingController = PageController(viewportFraction: 1, initialPage: 4);
    _currentPosition = _coffeController.initialPage.toDouble();
    _currentHeading = _headingController.initialPage;
    _coffeController.addListener(_navigationListener);
    bloc.loadData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _coffeController.removeListener(_navigationListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder<List<Unit>?>(
          stream: bloc.unitStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return SizedBox();
            }
            var data1 = snapshot.data;
            return Stack(
              children: [
                ..._buildBackground(),
                Transform.scale(
                  alignment: Alignment.bottomCenter,
                  scale: 2.3,
                  child: PageView.builder(
                      controller: _coffeController,
                      itemCount: (data1?.length ?? 0) + 1 ?? 0,
                      clipBehavior: Clip.none,
                      scrollBehavior: WindowsScrollBehaviour(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          // HEADINGS HERE Would be great
                          return const SizedBox.shrink();
                        }
                        // we need to know how much index is far from the current page to scale it
                        final double distance =
                            (_currentPosition - index + 1).abs();
                        final isNotOnScreen =
                            (_currentPosition - index + 1) > 0;
                        final double scale =
                            1 - distance * .345 * (isNotOnScreen ? 1 : -1);
                        final double translateY = (1 - scale).abs() *
                                MediaQuery.of(context).size.height /
                                1.5 +
                            20 * (distance - 1).clamp(0.0, 1);
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height * .1),
                          child: Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..translate(
                                  0.0, !isNotOnScreen ? 0.0 : translateY)
                              ..scale(scale),
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              child: Hero(
                                flightShuttleBuilder: (
                                  BuildContext flightContext,
                                  Animation<double> animation,
                                  HeroFlightDirection flightDirection,
                                  BuildContext fromHeroContext,
                                  BuildContext toHeroContext,
                                ) {
                                  late Widget hero;
                                  if (flightDirection ==
                                      HeroFlightDirection.push) {
                                    hero = fromHeroContext.widget;
                                  } else {
                                    hero = toHeroContext.widget;
                                  }
                                  return hero;
                                },
                                tag: "coffee_${data1?[index - 1].id}",
                                // child: Image.asset(
                                //   CoffeeItem.mockItems[index - 1].image,
                                //   fit: BoxFit.fitHeight,
                                // ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.favorite)),
                                    Container(
                                      constraints:
                                          BoxConstraints(maxWidth: 200),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: ImageNetwork(
                                          image: data1?[index - 1].image ?? "",
                                          height: 230,
                                          width: 200,
                                          duration: 1500,
                                          curve: Curves.easeIn,
                                          onPointer: true,
                                          debugPrint: false,
                                          fullScreen: false,
                                          fitAndroidIos: BoxFit.cover,
                                          fitWeb: BoxFitWeb.cover,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          onLoading:
                                              const CircularProgressIndicator(
                                            color: Colors.indigoAccent,
                                          ),
                                          onError: const Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                Routes.vocabularyDetail,
                                                arguments:
                                                    data1?[index - 1].id);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                Container(
                    height: 180,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [.6, 1],
                        colors: [
                          Colors.black,
                          Colors.black.withOpacity(0.0),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 70,
                          child: PageView.builder(
                              controller: _headingController,
                              itemCount: data1?.length ?? 0,
                              scrollBehavior: WindowsScrollBehaviour(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final TextStyle titleStyle =
                                    GoogleFonts.montserrat(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  height: 1,
                                  color: AppColors.primaryWhite,
                                );
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 80),
                                  child: Center(
                                    child: Hero(
                                      tag: "coffee_${data1?[index].id}_name",
                                      child: Text(
                                        data1?[index].name ?? "",
                                        style: titleStyle,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )),
                ..._buildOverlays(),
              ],
            );
          }),
    );
  }

  List<Widget> _buildBackground() {
    return [
      Align(
        alignment: Alignment.bottomCenter + const Alignment(0, .7),
        child: Container(
          width: MediaQuery.of(context).size.width * .3,
          height: MediaQuery.of(context).size.width * .3,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: AppColors.primaryWhite,
              blurRadius: 90,
              spreadRadius: 90,
              offset: Offset.zero,
            ),
          ], shape: BoxShape.circle),
        ),
      ),
      Align(
        alignment: Alignment.bottomRight + const Alignment(5.8, -0.45),
        child: const SizedBox(
            width: 350,
            height: 350,
            child: DecoratedBox(
              decoration: BoxDecoration(
                // color: kBrownColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryWhite,
                    blurRadius: 60,
                    spreadRadius: 20,
                    offset: Offset(5, 0),
                  ),
                ],
                shape: BoxShape.circle,
              ),
            )),
      )
    ];
  }

  List<Widget> _buildOverlays() {
    return [
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 115,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                AppColors.primaryBlack20.withRed(170).withOpacity(.6),
                AppColors.primaryBlack20.withOpacity(0.0),
              ],
            ),
          ),
        ),
      )
    ];
  }

  @override
  VocabularyBloc get bloc => widget.bloc;
}
