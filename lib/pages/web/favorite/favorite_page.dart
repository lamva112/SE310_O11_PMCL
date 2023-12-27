import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:se310_o11_pmcl/blocs/blocs.dart';
import 'package:se310_o11_pmcl/data/data.dart';
import 'package:se310_o11_pmcl/resources/colors.dart';

import '../../../constants.dart';
import '../../../core/core.dart';
import '../search/widget/audiod.dart';

class FavoritePage extends StatefulWidget {
  final FavoriteBloc bloc;
  const FavoritePage({super.key, required this.bloc});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends BaseState<FavoritePage, FavoriteBloc> {
  @override
  void initState() {
    bloc.loadData();
    bloc.loadUnit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              "Favorite unit",
              style: TextStyle(
                fontSize: 24,
                color: AppColors.primaryWhite,
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          StreamBuilder<List<Unit>?>(
              stream: bloc.unitStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox();
                }
                var data = snapshot.data;
                return Container(
                  constraints: BoxConstraints(maxHeight: 250),
                  child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                              color: AppColors.primaryWhite,
                              borderRadius: BorderRadius.circular(8)),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    child: Text(
                                      data?[index].name ?? "",
                                      style: TextStyle(
                                          color: AppColors.primaryBlack,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: ImageNetwork(
                                      image: data?[index].image ?? "",
                                      height: 150,
                                      width: 150,
                                      duration: 1500,
                                      curve: Curves.easeIn,
                                      onPointer: true,
                                      debugPrint: false,
                                      fullScreen: false,
                                      fitAndroidIos: BoxFit.cover,
                                      fitWeb: BoxFitWeb.cover,
                                      borderRadius: BorderRadius.circular(12),
                                      onLoading:
                                          const CircularProgressIndicator(
                                        color: Colors.indigoAccent,
                                      ),
                                      onError: const Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                      onTap: () {
                                        // Navigator.pushNamed(
                                        //     context, Routes.vocabularyDetail,
                                        //     arguments: data1?[index - 1].id);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(
                                    onPressed: () {
                                      bloc.deleteUnit(
                                        index,
                                      );
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )),
                              ),
                            ],
                          ),
                        );
                      }),
                );
              }),
          SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              "Favorite vocabulary",
              style: TextStyle(
                fontSize: 24,
                color: AppColors.primaryWhite,
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          StreamBuilder<List<Vocabulary>?>(
              stream: bloc.vocabStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox();
                }
                var data = snapshot.data;
                return Container(
                  constraints: BoxConstraints(maxHeight: 350),
                  child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(right: 12),
                          height: 350,
                          width: 250,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  data?[index].word ?? "",
                                  //"word",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                subtitle: Text(
                                  data?[index].phonetics ?? "",
                                  //"phonetics",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                trailing: Text(
                                  //data?[index].type ?? "",
                                  "type",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              ImageNetwork(
                                image: data?[index].image ?? "",
                                // image:
                                //     "https://firebasestorage.googleapis.com/v0/b/dictionaryasp.appspot.com/o/vocabulary%2Fsunset.png?alt=media&token=773dd843-c4e4-4164-b272-3da6b8b562c4",
                                height: 150,
                                width: 150,
                                duration: 1500,
                                //curve: Curves.easeIn,
                                onPointer: true,
                                debugPrint: false,
                                fullScreen: false,
                                fitAndroidIos: BoxFit.cover,
                                fitWeb: BoxFitWeb.cover,
                                borderRadius: BorderRadius.circular(70),
                                onLoading: const CircularProgressIndicator(
                                  color: Colors.indigoAccent,
                                ),
                                onError: const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                                onTap: () {},
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        bloc.deleteVocab(
                                          index,
                                        );
                                      },
                                      icon: Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      ),
                                    ),
                                    const Spacer(),
                                    AudioPlayerButton(
                                      url: data?[index].pronouce ?? "",
                                      // url: '',
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                child: Text(
                                  "Hint: ${data?[index].hint ?? ""}",
                                  //"hint",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    // letterSpacing: 1.1,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                child: Text(
                                  "Meaning: ${data?[index].meaning ?? ""}",
                                  //"meaning ",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    // letterSpacing: 1.1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                );
              }),
        ],
      ),
    );
  }

  @override
  FavoriteBloc get bloc => widget.bloc;
}
