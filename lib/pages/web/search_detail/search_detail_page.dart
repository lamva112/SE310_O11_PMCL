import 'package:flutter/material.dart';
import 'package:se310_o11_pmcl/data/data.dart';
import '../../../blocs/blocs.dart';
import 'widget/rotating_shining_card.dart';

class SearchDetailPage extends StatefulWidget {
  final SearchDetailBloc bloc;
  const SearchDetailPage({super.key, required this.bloc});

  @override
  State<SearchDetailPage> createState() => _SearchDetailPageState();
}

class _SearchDetailPageState extends State<SearchDetailPage> {
  late Vocabulary? voca;
  bool isDataInitialized = false;

  void _getArgumentData() {
    try {
      voca = ModalRoute.of(context)?.settings.arguments as Vocabulary?;
    } catch (err) {
      print('Get vocal data error ::: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isDataInitialized) {
      _getArgumentData();
      isDataInitialized = true;
      print(voca?.toJson());
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: RotatingShiningCard(
          width: 400,
          height: 560,
          image: voca?.image ?? "",
          word: voca?.word ?? '',
          meaning: voca?.meaning ?? '',
          type: voca?.type ?? '',
          phonetics: voca?.phonetics ?? '',
          hint: voca?.hint ?? '',
        ),
      ),
    );
  }
}
