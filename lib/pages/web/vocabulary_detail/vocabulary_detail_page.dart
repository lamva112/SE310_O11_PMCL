import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:lit_starfield/view.dart';
import 'package:lottie/lottie.dart';
import 'package:rxdart/rxdart.dart';
import 'package:se310_o11_pmcl/resources/colors.dart';
import 'package:se310_o11_pmcl/widgets/ink_well_wrapper.dart';
import '../../../blocs/vocabulary_detail/vocabulary_detail.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';
import 'widget/unit_items.dart';

class VocabularyDetailPage extends StatefulWidget {
  final VocabularyDetailBloc bloc;
  const VocabularyDetailPage({super.key, required this.bloc});

  @override
  State<VocabularyDetailPage> createState() => _VocabularyDetailState();
}

class _VocabularyDetailState
    extends BaseState<VocabularyDetailPage, VocabularyDetailBloc> {
  var isShowBackButton = BehaviorSubject.seeded(false);
  final AppinioSwiperController controller = AppinioSwiperController();
  // var data = Vocabulary(
  //     id: "64147d927edf0126d1f6ef93",
  //     type: "noun",
  //     word: "sunset",
  //     hint: "We sat on the beach watching a spectacular sunset",
  //     phonetics: "ˈsʌn.set",
  //     pronouce:
  //         "https://firebasestorage.googleapis.com/v0/b/dictionaryasp.appspot.com/o/vocabulary%2Fsunset.mp3?alt=media&token=9dfbf6f0-ec7f-494f-ac46-6dc95573e2de",
  //     image:
  //         "https://firebasestorage.googleapis.com/v0/b/dictionaryasp.appspot.com/o/vocabulary%2Fsunset.png?alt=media&token=773dd843-c4e4-4164-b272-3da6b8b562c4",
  //     meaning: "the time in the evening when you last see the sun in the sky");

  @override
  Future<void> onReceivePayload(Object? payload) async {
    var unitId = '';
    try {
      unitId = payload as String;
      bloc.loadData(unitId);
    } catch (e) {
      print('get unitId error: ${e}');
    }
    super.onReceivePayload(payload);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: const AppBarWidget(screenTitle: "Unit 1: Daily"),
      body: Stack(
        children: [
          const LitStarfieldContainer(
            animated: true,
            number: 500,
            velocity: 0.85,
            depth: 0.9,
            scale: 4,
            starColor: Colors.amber,
            backgroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF031936),
                  Colors.black54,
                  Color(0xFF284059),
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    StreamBuilder<bool>(
                        stream: isShowBackButton,
                        builder: (context, snapshot) {
                          return Visibility(
                            visible: snapshot.data ?? false,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 250,
                                  height: 250,
                                  child: LottieBuilder.asset(
                                    "assets/images/json/space.json",
                                    fit: BoxFit.cover,
                                    width: 550,
                                    height: 550,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Text(
                                    "You have finished this section. ",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryWhite,
                                    ),
                                  ),
                                ),
                                InkWellWrapper(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  borderRadius: BorderRadius.circular(24),
                                  border:
                                      Border.all(color: AppColors.primaryWhite),
                                  color: Colors.transparent,
                                  paddingChild: const EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 24,
                                  ),
                                  child: Text(
                                    localization.back,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryWhite,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                    StreamBuilder<List<Vocabulary>?>(
                        stream: bloc.unitStream,
                        builder: (context, snapshot) {
                          // if (!snapshot.hasData) {
                          //   return Container(
                          //     width: 50,
                          //     height: 50,
                          //     color: Colors.blue,
                          //   );
                          // }
                          var data = snapshot.data ?? [];
                          return SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: UnitSwipeableStack(
                              items: List.generate(
                                data?.length ?? 0,
                                (index) => UnitFlipCard(
                                  vocabulary: data[index],
                                ),
                              ),
                              onTap: () {
                                isShowBackButton.add(true);
                              },
                              controller: controller,
                            ),
                          );
                        }),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  VocabularyDetailBloc get bloc => widget.bloc;
}
