import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:se310_o11_pmcl/data/data.dart';
import 'dart:math';

import 'package:se310_o11_pmcl/widgets/ink_well_wrapper.dart';

import '../../../blocs/blocs.dart';
import '../../../core/core.dart';
import '../../../router/router.dart';

class PreparePage extends StatefulWidget {
  final PrepareBloc bloc;
  const PreparePage({super.key, required this.bloc});

  @override
  State<PreparePage> createState() => _PreparePageState();
}

class _PreparePageState extends BaseState<PreparePage, PrepareBloc>
    with TickerProviderStateMixin {
  final colors = [
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.cyan,
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.red,
  ];
  bool isOpen = false;
  Color selectedColor = Colors.purple;
  late final AnimationController _animationController;
  List<String> questionId = [];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      upperBound: 1.1,
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        const springDescription = SpringDescription(
          mass: 0.8,
          stiffness: 180.0,
          damping: 20.0,
        );
        final simulation = SpringSimulation(springDescription,
            _animationController.value, 0.05, _animationController.velocity);
        _animationController.animateWith(simulation);
      }
    });
  }

  void _openMenu() {
    _animationController.reset();

    const springDescription = SpringDescription(
      mass: 0.8,
      stiffness: 180.0,
      damping: 20.0,
    );
    final simulation = SpringSimulation(
        springDescription, 0, 1, _animationController.velocity);
    _animationController.animateWith(simulation);
    setState(() {
      isOpen = true;
    });
  }

  void _closeMenu(Color color) {
    _animationController.reverse();
    setState(() {
      selectedColor = color;
    });
    Future.delayed(const Duration(milliseconds: 250), () {
      setState(() {
        _animationController.reset();
        isOpen = false;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void onReceivePayload(Object? payload) {
    try {
      questionId = payload as List<String>;
      bloc.loadData(questionId);
    } catch (e) {
      print('get questionId error: ${e}');
    }
    super.onReceivePayload(payload);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Stack(
              children: [
                GestureDetector(
                  onTap: () => _closeMenu(selectedColor),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250 ~/ 2),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          selectedColor.withOpacity(0.2),
                          selectedColor.withOpacity(0.5),
                          selectedColor
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: _animationController
                            .drive(Tween(
                                begin: size.width * 0.4 / 2,
                                end: size.width * 0.9 / 2))
                            .value,
                        height: MediaQuery.of(context).size.width * 0.9 / 2,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white70,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: isOpen ? 30 : 10,
                              offset: Offset(
                                0,
                                isOpen ? 10 : 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ...colors.asMap().entries.map((e) {
                        final angle = e.key * (360 / colors.length);

                        return GestureDetector(
                          onTap: () {
                            _closeMenu(e.value);
                          },
                          child: Transform.rotate(
                            angle: _animationController
                                .drive(
                                    Tween(begin: 0.0, end: angle * (pi / 180)))
                                .value,
                            child: Transform.translate(
                              offset: Offset(
                                0.0,
                                _animationController
                                    .drive(Tween(
                                        begin: 0.0, end: -size.width * 0.2 / 2))
                                    .value,
                              ),
                              child: Container(
                                height: _animationController
                                    .drive(Tween(
                                        begin: size.width * 0.25 / 2,
                                        end: size.width * 0.40 / 2))
                                    .value,
                                width: size.width * 0.25 / 2,
                                //Increasing the margin solve the hit issue
                                margin: const EdgeInsets.all(100),
                                decoration: BoxDecoration(
                                  color: e.value,
                                  gradient: LinearGradient(
                                    colors: [
                                      colors[e.key],
                                      colors[e.key],
                                      colors[e.key].withOpacity(0.7)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: _animationController
                                          .drive(ColorTween(
                                              begin: Colors.transparent,
                                              end: Colors.black
                                                  .withOpacity(0.4)))
                                          .value!,
                                      blurRadius: 5,
                                      offset: const Offset(0, 12),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(
                                      ((size.width * 0.40) / 4) - 10),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      if (!isOpen)
                        GestureDetector(
                          onTap: _openMenu,
                          child: Container(
                            width: size.width * 0.3 / 2,
                            height: size.width * 0.3 / 2,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selectedColor,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWellWrapper(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                size: 32,
                              ),
                              Text(
                                "Back",
                                style: TextStyle(fontSize: 24),
                              ),
                            ],
                          )),
                      InkWellWrapper(
                          onTap: () {
                            AwesomeDialog(
                                width: 600,
                                context: context,
                                dialogType: DialogType.info,
                                animType: AnimType.leftSlide,
                                title: 'Are you ready for this text',
                                desc:
                                    'Each question can only be answered once !',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {
                                  if (bloc.state?.listQuestion != null) {
                                    Navigator.pushNamed(
                                        context, Routes.testDetail,
                                        arguments: {
                                          "color": selectedColor,
                                          "question": dummyData,
                                        });
                                  }
                                }).show();
                          },
                          child: Row(
                            children: [
                              Text(
                                "Next",
                                style: TextStyle(fontSize: 24),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 32,
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  @override
  PrepareBloc get bloc => widget.bloc;
}

List<Question> dummyData = [
  Question(
    id: "1",
    type: true,
    title:
        "https://firebasestorage.googleapis.com/v0/b/dictionaryasp.appspot.com/o/photo%2Fques1.mp3?alt=media&token=db3e892d-5d8e-414e-bad9-7a41145aa702",
    description:
        "https://firebasestorage.googleapis.com/v0/b/dictionaryasp.appspot.com/o/photo%2Fques1.png?alt=media&token=ac0229a4-7985-4b86-b2fd-974a75c5f55c",
    answer: "Paris",
    point: 10,
    options: [
      "644cdeee0e30095d86d1da58",
      "644cdef40e30095d86d1da59",
      "644cdefa0e30095d86d1da5a",
      "644cdf569867c90a88279e5c"
    ],
  ),
  Question(
    id: "2",
    type: false,
    title:
        "During the peak season, it is _____ to hire additional workers for the weekend shifts",
    description: "Answer with true or false.",
    answer: "false",
    point: 5,
    options: [
      "644ce0ba83c5316320d27bd7",
      "644ce0d99394ab4721b2309d",
      "645356397029627e8fd9dc7f",
      "645356487029627e8fd9dc80"
    ],
  ),
  Question(
    id: "3",
    type: false,
    title: "Which programming language is known for its readability?",
    description: "Select the language with good readability.",
    answer: "Python",
    point: 8,
    options: [
      "6453593d7029627e8fd9dc82",
      "645359497029627e8fd9dc83",
      "645359557029627e8fd9dc84",
      "645359607029627e8fd9dc85"
    ],
  ),
  Question(
    id: "4",
    type: false,
    title: "Who wrote 'Romeo and Juliet'?",
    description: "Provide the name of the author.",
    answer: "William Shakespeare",
    point: 7,
    options: [
      "64535bd27029627e8fd9dc87",
      "64535be07029627e8fd9dc88",
      "64535bf27029627e8fd9dc89",
      "64535c037029627e8fd9dc8a"
    ],
  ),
  Question(
    id: "5",
    type: false,
    title: "What is the largest mammal on Earth?",
    description: "Choose the largest mammal from the options.",
    answer: "Blue Whale",
    point: 12,
    options: [
      "64535e347029627e8fd9dc8c",
      "64535e447029627e8fd9dc8d",
      "64535e4f7029627e8fd9dc8e",
      "64535e637029627e8fd9dc8f"
    ],
  ),
];
