import 'package:flutter/material.dart';

import '../../../blocs/blocs.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../../router/router.dart';
import 'animaterd_card.dart';

class TestPage extends StatefulWidget {
  final TestBloc bloc;
  const TestPage({super.key, required this.bloc});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends BaseState<TestPage, TestBloc> {
  var test = Test(
      id: "1",
      name: "Photos",
      image:
          "https://firebasestorage.googleapis.com/v0/b/dictionaryasp.appspot.com/o/photo%2Fphotos.png?alt=media&token=98af2607-e123-49bd-a421-e171e9022610",
      questions: [
        "645354247029627e8fd9dc7e",
        "645357b87029627e8fd9dc81",
        "64535a947029627e8fd9dc86",
        "64535d677029627e8fd9dc8b",
        "64535fa57029627e8fd9dc90"
      ]);

  List<Color> activeColors = [
    Color.fromRGBO(14, 165, 233, 1.0),
    Colors.orange,
    Colors.yellow
  ];
  List<Color> inActiveColors = [
    Color.fromRGBO(14, 165, 233, 1.0),
    Colors.orange,
    Colors.yellowAccent
  ];

  @override
  void initState() {
    bloc.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.prepare,arguments: test.questions);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Row(
          children: [
            Expanded(
              flex: 4,
              child: StreamBuilder<List<Test>?>(
                  stream: bloc.testStream,
                  builder: (context, snapshot) {
                    var data = snapshot.data;
                    return ListView.separated(
                      padding: const EdgeInsets.only(left: 24, right: 40),
                      itemBuilder: (context, index) {
                        Color activeColor =
                            activeColors[index % activeColors.length];
                        Color inActiveColor =
                            inActiveColors[index % inActiveColors.length];
                        return AnimatedCard(
                          test: data?[index],
                          onTap: () {
                            Navigator.pushNamed(context, Routes.prepare);
                          },
                          activeColor: activeColor,
                          inactiveColor: inActiveColor,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 24,
                        );
                      },
                      itemCount: data?.length ?? 0,
                    );
                  }),
            ),
            Expanded(flex: 1, child: SizedBox()),
          ],
        )),
      ),
    );
  }

  @override
  TestBloc get bloc => widget.bloc;
}
