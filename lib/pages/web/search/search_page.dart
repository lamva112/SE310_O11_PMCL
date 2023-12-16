import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_network/image_network.dart';
import 'package:lottie/lottie.dart';
import 'package:rxdart/rxdart.dart';
import 'package:se310_o11_pmcl/data/data.dart';
import 'package:se310_o11_pmcl/pages/web/search/widget/audiod.dart';
import 'package:se310_o11_pmcl/resources/colors.dart';

import '../../../blocs/blocs.dart';
import '../../../constants.dart';
import '../../../core/core.dart';
import '../../../generated/l10n.dart';
import '../../../router/router.dart';
import '../../../widgets/custom_textfield/custom_textfield.dart';

class SearchPage extends StatefulWidget {
  final SearchBloc bloc;
  const SearchPage({super.key, required this.bloc});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends BaseState<SearchPage, SearchBloc> {
  var _searchController = TextEditingController();
  var isSearch = BehaviorSubject.seeded(false);

  @override
  void initState() {
    super.initState();
    bloc.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<bool>(
                stream: isSearch,
                builder: (context, snapshot) {
                  var data = snapshot.data ?? false;
                  return Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Visibility(
                        visible: !data,
                        child: LottieBuilder.asset(
                          "assets/images/json/search.json",
                          fit: BoxFit.cover,
                          width: 350,
                          height: 350,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            localization.what_would_you_like_to_search,
                            style: const TextStyle(
                              color: AppColors.primaryWhite,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Visibility(
                            visible: data,
                            child: LottieBuilder.asset(
                              "assets/images/json/search.json",
                              fit: BoxFit.cover,
                              width: 45,
                              height: 45,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 30),
                        child: CustomTextField(
                          onChanged: (value) {
                            if (value != "") {
                              isSearch.add(true);
                            } else {
                              isSearch.add(false);
                            }
                          },
                          textFieldType: TextFieldType.text,
                          decorationConfig: textFieldDecorationConfig(
                              controller: _searchController,
                              hint: S.of(context).search,
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: const Icon(Icons.remove_circle)),
                          textFieldConfig:
                              textFieldConfig(controller: _searchController),
                        ),
                      ),
                      StreamBuilder<List<Vocabulary>?>(
                          stream: bloc.vocalStream,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return SizedBox();
                            }
                            var data = snapshot.data;

                            return StaggeredGrid.count(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                axisDirection: AxisDirection.down,
                                children: [
                                  ...List.generate(data?.length ?? 0, (index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Routes.searchDetail,
                                            arguments: data?[index]);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 10,
                                            left: 12,
                                            right: 5,
                                            bottom: 5),
                                        child: Material(
                                          elevation: 10,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                              ),
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    title: SizedBox(
                                                      width: double.infinity,
                                                      child:
                                                          SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        physics:
                                                            const BouncingScrollPhysics(),
                                                        child: Text(
                                                          data?[index].word ??
                                                              "",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 1.2,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    subtitle: Text(
                                                      data?[index].phonetics ??
                                                          "",
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        letterSpacing: 1.2,
                                                      ),
                                                    ),

                                                    // trailing: IconButton(
                                                    //   icon: Icon(
                                                    //     Icons.headphones,
                                                    //     color: Colors.grey,
                                                    //     size: 30,
                                                    //   ),
                                                    //   onPressed: () async {
                                                    //     final player = AudioPlayer();
                                                    //     await player.play(UrlSource('https://drive.google.com/uc?export=view&id=1BjoSz1EGXWxLnbc8Uk9eV3ebOEOEDSfA'));
                                                    //   },
                                                    // ),
                                                    trailing: Text(
                                                      data?[index].type ?? "",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 200,
                                                    margin:
                                                        const EdgeInsets.only(
                                                      top: 10,
                                                      left: 10,
                                                      right: 10,
                                                      bottom: 0,
                                                    ),
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  24)),
                                                    ),
                                                    child: ImageNetwork(
                                                      image:
                                                          data?[index].image ??
                                                              "",
                                                      // 'https://firebasestorage.googleapis.com/v0/b/dictionaryasp.appspot.com/o/vocabulary%2Fsunset.png?alt=media&token=773dd843-c4e4-4164-b272-3da6b8b562c4',
                                                      height: 150,
                                                      width: 150,
                                                      duration: 1500,
                                                      curve: Curves.easeIn,
                                                      onPointer: true,
                                                      debugPrint: false,
                                                      fullScreen: false,
                                                      fitAndroidIos:
                                                          BoxFit.cover,
                                                      fitWeb: BoxFitWeb.cover,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              70),
                                                      onLoading:
                                                          const CircularProgressIndicator(
                                                        color:
                                                            Colors.indigoAccent,
                                                      ),
                                                      onError: const Icon(
                                                        Icons.error,
                                                        color: Colors.red,
                                                      ),
                                                      onTap: () {},
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12),
                                                    child: Row(
                                                      children: [
                                                        userData[index]
                                                                ["isLiked"]
                                                            ? IconButton(
                                                                onPressed:
                                                                    () {},
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .favorite,
                                                                  color: Colors
                                                                      .pink,
                                                                ),
                                                              )
                                                            : IconButton(
                                                                onPressed:
                                                                    () {},
                                                                icon: const Icon(
                                                                    Icons
                                                                        .favorite_outline),
                                                              ),
                                                        const Spacer(),
                                                        AudioPlayerButton()
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12,
                                                        vertical: 10),
                                                    child: Expanded(
                                                      child: Row(
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 6,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    userData[
                                                                            index]
                                                                        [
                                                                        "logo"]),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              data?[index]
                                                                      .hint ??
                                                                  "",
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                // letterSpacing: 1.1,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 12,
                                                      vertical: 10,
                                                    ),
                                                    child: Text(
                                                      data?[index].meaning ??
                                                          "",
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        // letterSpacing: 1.1,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    );
                                  })
                                ]);
                          }),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement bloc
  SearchBloc get bloc => widget.bloc;

  TextFieldConfig textFieldConfig({required TextEditingController controller}) {
    return TextFieldConfig(
      validatorMode: AutovalidateMode.onUserInteraction,
      enableSuggestions: false,
      controller: controller,
      style: Theme.of(context)
          .textTheme
          .titleSmall
          ?.copyWith(color: AppColors.primaryBlack.withOpacity(0.3)),
      cursorColor: AppColors.primaryBlack.withOpacity(0.3),
    );
  }

  TextFieldDecorationConfig textFieldDecorationConfig(
      {required TextEditingController controller,
      String? hint,
      Widget? prefixIcon,
      Widget? suffixIcon}) {
    return TextFieldDecorationConfig(
      contentPadding: EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      fillColor: AppColors.primaryWhite,
      filled: true,
      hintText: hint,
      hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w400,
          color: AppColors.primaryBlack.withOpacity(0.3)),
      errorStyle:
          Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.red),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primaryBlack),
        borderRadius: BorderRadius.circular(15),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryBlack),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryBlack),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(15),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(15),
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }
}
