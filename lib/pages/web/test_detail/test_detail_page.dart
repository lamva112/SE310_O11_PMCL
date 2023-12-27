import 'dart:async';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:se310_o11_pmcl/data/data.dart';
import 'package:se310_o11_pmcl/resources/colors.dart';
import 'package:se310_o11_pmcl/widgets/ink_well_wrapper.dart';

import '../../../blocs/blocs.dart';
import '../../../core/core.dart';
import 'widget/option_card.dart';

class TestDetailPage extends StatefulWidget {
  final TestDetailBloc bloc;
  const TestDetailPage({super.key, required this.bloc});

  @override
  State<TestDetailPage> createState() => _TestDetailPageState();
}

class _TestDetailPageState extends BaseState<TestDetailPage, TestDetailBloc> {
  int questionTimerSeconds = 20;
  Timer? _timer;
  int _questionNumber = 1;
  PageController _controller = PageController();
  int score = 0;
  bool isLocked = false;
  List optionsLetters = ["A.", "B.", "C.", "D."];
  bool isPlayFirstTime = true;
  final player = AudioPlayer();
  late Timer _timerToPlaySound;

  String topicType = '';
  List<dynamic> questionlenght = [];
  dynamic optionsList = [];
  Color selectedColor = AppColors.primaryWhite;

  List<Question> listQuestion = [];

  int selectedIndex = -1;

  int numOfQuestion = 0;

  bool isTheFistQuestion = true;

  // void startTimerOnQuestions() {
  //   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     if (mounted) {
  //       setState(() {
  //         if (questionTimerSeconds > 0) {
  //           questionTimerSeconds--;
  //         } else {
  //           _timer?.cancel();
  //           navigateToNewScreen();
  //         }
  //       });
  //     }
  //   });
  // }

  void stopTime() {
    _timer?.cancel();
  }

  // void navigateToNewScreen() {
  //   if (_questionNumber < questionlenght.length) {
  //     _controller.nextPage(
  //       duration: const Duration(milliseconds: 600),
  //       curve: Curves.easeInOut,
  //     );
  //     setState(() {
  //       _questionNumber++;
  //       isLocked = false;
  //     });
  //     _resetQuestionLocks();
  //     startTimerOnQuestions();
  //   } else {
  //     _timer?.cancel();
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    // _resetQuestionLocks();
    //startTimerOnQuestions();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void onReceivePayload(Object? payload) {
    try {
      var data = payload as Map<String, dynamic>;
      if (data['color'] != null) {
        selectedColor = data['color'] as Color;
      }
      if (data['question'] != null) {
        listQuestion = data['question'] as List<Question>;
      }
    } catch (err) {
      print('Get coupon data error ::: $err');
    }
    bloc.getQuestionList(listQuestion);
    super.onReceivePayload(payload);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedContainer(
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
          StreamBuilder<List<Question>?>(
              stream: bloc.questionStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox();
                }
                var data = snapshot.data;
                numOfQuestion = data?.length ?? 0;
                if (data?[0].options != null && isTheFistQuestion) {
                  bloc.getListId(data?[0].options ?? []);
                  isTheFistQuestion = false;
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //     right: 10,
                      //     bottom: 10,
                      //     left: 10,
                      //     top: 10,
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       IconButton(
                      //         onPressed: () async {
                      //           //Navigator.pop(context);
                      //         },
                      //         icon: const Icon(
                      //           CupertinoIcons.clear,
                      //           color: Colors.black,
                      //           weight: 10,
                      //         ),
                      //       ),
                      //       Expanded(
                      //         child: ClipRRect(
                      //           borderRadius: BorderRadius.circular(12),
                      //           child: LinearProgressIndicator(
                      //             minHeight: 20,
                      //             value: 1 - (questionTimerSeconds / 20),
                      //             backgroundColor: Colors.blue.shade100,
                      //             color: Colors.blueGrey,
                      //             valueColor: const AlwaysStoppedAnimation(
                      //                 AppColors.primaryDark),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Container(
                        padding:
                            const EdgeInsets.only(top: 12, left: 10, right: 10),
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: MediaQuery.of(context).size.height * 0.90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.24),
                              blurRadius: 20.0,
                              offset: const Offset(0.0, 10.0),
                              spreadRadius: 10,
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Question ${_questionNumber}/${data?.length}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.shade500),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: PageView.builder(
                                    controller: _controller,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: data?.length,
                                    onPageChanged: (value) async {
                                      setState(() {
                                        _questionNumber = value + 1;
                                        isLocked = false;
                                        _resetQuestionLocks();
                                      });
                                      bloc.getListId(
                                          data?[value].options ?? []);
                                      await player.stop();
                                    },
                                    itemBuilder: (context, index) {
                                      // final myquestions = [];
                                      // var optionsIndex = 1;
                                      // numOfQuestion =
                                      //     data?[index].options?.length ?? 0;

                                      return Column(
                                        children: [
                                          data?[index].type == true
                                              ? Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () async {
                                                          final duration = await player
                                                              .setUrl(
                                                                  // Load a URL
                                                                  data?[index]
                                                                          .title ??
                                                                      "");
                                                          player.play();
                                                        },
                                                        icon: Icon(Icons
                                                            .headphones_rounded)),
                                                    Image.network(
                                                      data?[index]
                                                              .description ??
                                                          "",
                                                      fit: BoxFit.cover,
                                                      width: 500,
                                                      height: 300,
                                                    ),
                                                    SizedBox(),
                                                  ],
                                                )
                                              : Text(
                                                  data?[index].title ?? "",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                        fontSize: 18,
                                                      ),
                                                ),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          Expanded(
                                            child: StreamBuilder<
                                                    List<Options>?>(
                                                stream: bloc.optionStream,
                                                builder: (context, snapshot) {
                                                  var dataOption =
                                                      snapshot.data;

                                                  return ListView.builder(
                                                    itemCount:
                                                        dataOption?.length ?? 0,
                                                    itemBuilder:
                                                        (context, index) {
                                                      var color =
                                                          Colors.grey.shade200;

                                                      // var questionOption =
                                                      //     myquestions.options[index];
                                                      // final letters = optionsLetters[index];

                                                      // if (myquestions.isLocked) {
                                                      //   if (questionOption ==
                                                      //       myquestions
                                                      //           .selectedWiidgetOption) {
                                                      //     color = questionOption.isCorrect
                                                      //         ? Colors.green
                                                      //         : Colors.red;
                                                      //   } else if (questionOption.isCorrect) {
                                                      //     color = Colors.green;
                                                      //   }
                                                      // }
                                                      // return InkWell(
                                                      //   onTap: () {
                                                      //     //stopTime();
                                                      //     // if (!myquestions.isLocked) {
                                                      //     //   setState(() {
                                                      //     //     myquestions.isLocked = true;
                                                      //     //     myquestions
                                                      //     //             .selectedWiidgetOption =
                                                      //     //         questionOption;
                                                      //     //   });

                                                      //     //   isLocked = myquestions.isLocked;
                                                      //     //   if (myquestions
                                                      //     //       .selectedWiidgetOption
                                                      //     //       .isCorrect) {
                                                      //     //     score++;
                                                      //     //   }
                                                      //     // }
                                                      //   },
                                                      //   child: Container(
                                                      //     height: 45,
                                                      //     padding:
                                                      //         const EdgeInsets.all(
                                                      //             10),
                                                      //     margin: const EdgeInsets
                                                      //         .symmetric(vertical: 8),
                                                      //     decoration: BoxDecoration(
                                                      //       border: Border.all(
                                                      //           color: color),
                                                      //       color:
                                                      //           Colors.grey.shade100,
                                                      //       borderRadius:
                                                      //           const BorderRadius
                                                      //               .all(
                                                      //               Radius.circular(
                                                      //                   10)),
                                                      //     ),
                                                      //     child: Row(
                                                      //       mainAxisAlignment:
                                                      //           MainAxisAlignment
                                                      //               .spaceBetween,
                                                      //       children: [
                                                      //         Text(
                                                      //           "LE Hoang Phuc",
                                                      //           style:
                                                      //               const TextStyle(
                                                      //                   fontSize: 16),
                                                      //         ),
                                                      //         // isLocked == true
                                                      //         //     ? questionOption.isCorrect
                                                      //         //         ? const Icon(
                                                      //         //             Icons.check_circle,
                                                      //         //             color: Colors.green,
                                                      //         //           )
                                                      //         //         : const Icon(
                                                      //         //             Icons.cancel,
                                                      //         //             color: Colors.red,
                                                      //         //           )
                                                      //         //     : const SizedBox.shrink()
                                                      //       ],
                                                      //     ),
                                                      //   ),
                                                      // );
                                                      return OptionCard(
                                                        title:
                                                            dataOption?[index]
                                                                    .value ??
                                                                "",
                                                        onTap: () {
                                                          setState(() {
                                                            if (selectedIndex ==
                                                                -1) {
                                                              selectedIndex =
                                                                  index;
                                                            }
                                                          });
                                                        },
                                                        isLocked:
                                                            selectedIndex ==
                                                                index,
                                                        questionOption:
                                                            dataOption?[index]
                                                                    .isCorrect ??
                                                                false,
                                                      );
                                                    },
                                                  );
                                                }),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: selectedIndex != -1,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: InkWellWrapper(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      onTap: () async {
                                        if (_questionNumber < numOfQuestion) {
                                          _controller.nextPage(
                                            duration: const Duration(
                                                milliseconds: 800),
                                            curve: Curves.easeInOut,
                                          );
                                          setState(() {
                                            selectedIndex = -1;
                                          });
                                        }
                                        if (_questionNumber > numOfQuestion) {
                                          AwesomeDialog(
                                              width: 600,
                                              context: context,
                                              dialogType: DialogType.info,
                                              animType: AnimType.leftSlide,
                                              title: 'Congratulation',
                                              desc: 'You are finish this test',
                                              btnCancelOnPress: () {
                                                Navigator.pop(context);
                                              },
                                              btnOkOnPress: () {
                                                Navigator.of(context).pop(true);
                                              }).show();
                                        }
                                        _questionNumber++;
                                      },
                                      color: Color(0xFF4993FA),
                                      width: MediaQuery.sizeOf(context).width *
                                          0.60,
                                      paddingChild:
                                          EdgeInsets.symmetric(vertical: 14),
                                      borderRadius: BorderRadius.circular(12),
                                      child: Text(
                                        _questionNumber < questionlenght.length
                                            ? 'Back to home'
                                            : 'Next Question',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                // isLocked
                                //     ? buildElevatedButton()
                                //     : const SizedBox.shrink(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }

  void _resetQuestionLocks() {
    for (var question in questionlenght) {
      question.isLocked = false;
    }
    questionTimerSeconds = 20;
  }

  // ElevatedButton buildElevatedButton() {
  //   //  const Color bgColor3 = Color(0xFF5170FD);
  //   const Color cardColor = Color(0xFF4993FA);

  //   return ElevatedButton(
  //     style: ButtonStyle(
  //       backgroundColor: MaterialStateProperty.all(cardColor),
  //       fixedSize: MaterialStateProperty.all(
  //         Size(MediaQuery.sizeOf(context).width * 0.80, 40),
  //       ),
  //       elevation: MaterialStateProperty.all(4),
  //     ),
  //     onPressed: () {
  //       print("${questionlenght.length} len ne");
  //       if (_questionNumber < questionlenght.length) {
  //         _controller.nextPage(
  //           duration: const Duration(milliseconds: 800),
  //           curve: Curves.easeInOut,
  //         );
  //         setState(() {
  //           _questionNumber++;
  //           isLocked = false;
  //         });
  //         _resetQuestionLocks();
  //         startTimerOnQuestions();
  //       } else {
  //         _timer?.cancel();
  //         // Navigator.pushReplacement(
  //         //   context,
  //         //   MaterialPageRoute(
  //         //     builder: (context) => ResultsScreen(
  //         //       score: score,
  //         //       totalQuestions: widget.questionlenght.length,
  //         //       whichTopic: widget.topicType,
  //         //     ),
  //         //   ),
  //         // );
  //       }
  //     },
  //     child: Text(
  //       _questionNumber < questionlenght.length ? 'Next Question' : 'Result',
  //       style: Theme.of(context).textTheme.bodySmall!.copyWith(
  //             color: Colors.white,
  //             fontSize: 16,
  //             fontWeight: FontWeight.w500,
  //           ),
  //     ),
  //   );
  // }

  @override
  TestDetailBloc get bloc => widget.bloc;
}
