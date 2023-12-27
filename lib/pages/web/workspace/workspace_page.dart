import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:se310_o11_pmcl/pages/pages.dart';
import 'package:se310_o11_pmcl/pages/web/test/test.dart';

import '../../../blocs/blocs.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../../enums.dart';
import '../../../resources/colors.dart';
import '../../../widgets/responsive_widget.dart';
import '../favorite/favorite.dart';
import 'responsive/left_side_bar.dart';
import 'widget/keep_alive_page.dart';

class Workspace extends StatefulWidget {
  final WorkspaceBloc bloc;
  final SearchBloc searchBloc;
  final VocabularyBloc vocabularyBloc;
  final TestBloc testBloc;
  final FavoriteBloc favoriteBloc;

  const Workspace(
      {Key? key,
      required this.searchBloc,
      required this.bloc,
      required this.vocabularyBloc,
      required this.testBloc, required this.favoriteBloc})
      : super(key: key);

  @override
  State<Workspace> createState() => _WorkspaceState();
}

class _WorkspaceState extends BaseState<Workspace, WorkspaceBloc>
    with TickerProviderStateMixin {
  BehaviorSubject<NavigationType> selectedSideBar =
      BehaviorSubject<NavigationType>.seeded(NavigationType.home);
  BehaviorSubject<String?> hoverSuggestSearch =
      BehaviorSubject<String?>.seeded(null);
  bool previousStateListCategory = true;
  BehaviorSubject<bool> showSearchTopBar = BehaviorSubject<bool>.seeded(false);
  BehaviorSubject<bool> changeSmallAppBar = BehaviorSubject<bool>.seeded(false);

  ScrollController scrollController = ScrollController();
  ScrollController scrollControllerSmallScreen = ScrollController();

  final keyC = GlobalKey();
  final keySmallScreen = GlobalKey();

  var user1 = User(
    id: '1',
    email: 'user1@example.com',
    passWord: 'password123',
    userName: 'User One',
    dateOfBirth: '1990-01-15', // assuming 'YYYY-MM-DD' format
  );

  //AppColors get appColors => Theme.of(context).extension<AppColors>()!;
  @override
  void onReceivePayload(Object? payload) {
    try {
      User? user = payload as User;
      if (user != null) {
        bloc.getUser(user);
      }
    } catch (e) {
      print(e);
    }

    super.onReceivePayload(payload);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        GestureDetector(
          onTap: () {},
          child: Scaffold(
            backgroundColor: AppColors.primaryWhite,
            body: ResponsiveWidget(
              largeScreen: templateLargeWidget(size),
              mediumScreen: templateMediumWidget(size),
              smallScreen: Container(),
            ),
          ),
        ),
        //if (snapshot.data == true) LoadingDialog(),
      ],
    );
  }

  Widget templateLargeWidget(Size size) {
    return StreamBuilder<NavigationType>(
      stream: selectedSideBar,
      builder: (context, snapshot) {
        NavigationType type = snapshot.data ?? NavigationType.home;
        return Row(
          children: [
            StreamBuilder<User?>(
                stream: bloc.userStream,
                builder: (context, snapshot) {
                  return LeftSideBar(
                    user: snapshot.data,
                    type: type,
                    onTapSideBarItem: (value) {
                      selectedSideBar.add(value);
                    },
                  );
                }),
            const SizedBox(height: 1),
            Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  allPageSideBar(type, size, isSmallPage: true),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget templateMediumWidget(Size size) {
    return StreamBuilder<NavigationType>(
      stream: selectedSideBar,
      builder: (context, snapshot) {
        NavigationType type = snapshot.data ?? NavigationType.home;
        return Column(
          children: [
            const SizedBox(height: 1),
            allPageSideBar(type, size),
          ],
        );
      },
    );
  }

  Widget allPageSideBar(NavigationType type, Size size, {bool? isSmallPage}) {
    return Expanded(
      child: IndexedStack(
        index: NavigationType.values.indexOf(type),
        children: [
          KeepAlivePage(child: VocabularyPage(bloc: widget.vocabularyBloc)),
          SearchPage(bloc: widget.searchBloc),
          KeepAlivePage(child: ChatBotPage()),
          KeepAlivePage(
            child: TestPage(bloc: widget.testBloc),
          ),
          FavoritePage(bloc: widget.favoriteBloc,),
        ],
      ),
    );
  }

  // Widget templateSmallWidget(Size size) {
  //   return StreamBuilder<NavigationType>(
  //     stream: selectedSideBar,
  //     builder: (context, snapshot) {
  //       NavigationType type = snapshot.data ?? NavigationType.project;
  //       return Scaffold(
  //         extendBodyBehindAppBar: true,
  //         appBar: AppBar(
  //           backgroundColor: appColors.transparent,
  //           elevation: 0,
  //           title: TextField(
  //             key: keySmallScreen,
  //             cursorColor: appColors.primaryBlack,
  //             controller: templateEditingController,
  //             onSubmitted: (value) {
  //               bloc.onSearchData(value);
  //             },
  //             onChanged: (value) {
  //               bloc.onSearchData(value);
  //             },
  //             style: TextStyle(fontSize: 14.0),
  //             decoration: InputDecoration(
  //               filled: true,
  //               fillColor: appColors.primaryWhite,
  //               contentPadding: EdgeInsets.symmetric(vertical: 8.0),
  //               prefixIcon: Container(
  //                 child: Icon(
  //                   Icons.search,
  //                   size: 24.0,
  //                   color: appColors.baseNeutral,
  //                 ),
  //               ),
  //               suffixIcon: StreamBuilder<bool>(
  //                 stream: showSuffixIcon,
  //                 builder: (context, snapshot) {
  //                   return snapshot.data == true
  //                       ? IconButton(
  //                           onPressed: () {
  //                             templateEditingController.clear();
  //                             bloc.onSearchData('');
  //                           },
  //                           iconSize: 24.0,
  //                           icon: Icon(
  //                             Icons.clear,
  //                             color: appColors.colorText,
  //                           ),
  //                         )
  //                       : SizedBox();
  //                 },
  //               ),
  //               iconColor: appColors.baseNeutral,
  //               hintText: "Search a template, design,...",
  //               hintStyle: TextStyle(
  //                 fontSize: 14,
  //                 color: appColors.baseNeutral,
  //                 fontWeight: FontWeight.w300,
  //               ),
  //               border: OutlineInputBorder(
  //                 borderSide: BorderSide(color: appColors.baseNeutral),
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //               enabledBorder: OutlineInputBorder(
  //                 borderSide: BorderSide(color: appColors.baseNeutral),
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //               focusedBorder: OutlineInputBorder(
  //                 borderSide: BorderSide(color: appColors.baseNeutral),
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //             ),
  //           ),
  //         ),
  //         drawer: Drawer(),
  //         body: SingleChildScrollView(
  //           controller: scrollControllerSmallScreen,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Container(
  //                 width: size.width,
  //                 padding: EdgeInsets.only(
  //                   left: 24,
  //                   right: 24,
  //                 ),
  //                 decoration: BoxDecoration(
  //                   gradient: LinearGradient(
  //                     colors: [
  //                       appColors.blueGradient,
  //                       appColors.purpleGradient,
  //                     ],
  //                     begin: Alignment.topLeft,
  //                     end: Alignment.bottomCenter,
  //                   ),
  //                 ),
  //                 child: Column(
  //                   children: [
  //                     SizedBox(height: AppBar().preferredSize.height + 16),
  //                     Container(
  //                       width: size.width,
  //                       height: 100,
  //                       alignment: Alignment.center,
  //                       child: StreamBuilder<SuggestCategories?>(
  //                         stream: hoverCategory,
  //                         builder: (context, snapshot) {
  //                           return ListView.separated(
  //                             itemCount: SuggestCategories.values.length,
  //                             shrinkWrap: true,
  //                             scrollDirection: Axis.horizontal,
  //                             itemBuilder: (context, i) {
  //                               return MouseRegion(
  //                                 onHover: (_) {
  //                                   hoverCategory.add(SuggestCategories.values[i]);
  //                                 },
  //                                 onExit: (_) {
  //                                   hoverCategory.add(null);
  //                                 },
  //                                 onEnter: (_) {},
  //                                 child: SizedBox(
  //                                   width: 100,
  //                                   child: Column(
  //                                     children: [
  //                                       Container(
  //                                         height: 50,
  //                                         width: 500,
  //                                         decoration: BoxDecoration(
  //                                           color: (snapshot.hasData && snapshot.data == SuggestCategories.values[i])
  //                                               ? categoriesColor(SuggestCategories.values[i])
  //                                               : Colors.white,
  //                                           shape: BoxShape.circle,
  //                                         ),
  //                                         child: Center(
  //                                           child: Icon(
  //                                               [
  //                                                 Icons.recommend_rounded,
  //                                                 Icons.sell,
  //                                                 Icons.bar_chart,
  //                                                 Icons.favorite,
  //                                               ][i],
  //                                               size: 28,
  //                                               color: (snapshot.hasData && snapshot.data == SuggestCategories.values[i])
  //                                                   ? Colors.white
  //                                                   : categoriesColor(SuggestCategories.values[i])),
  //                                         ),
  //                                       ),
  //                                       const SizedBox(height: 16),
  //                                       Text(
  //                                         SuggestCategories.values[i].name.replaceAll('_', ' & ').toTitleCase(),
  //                                         style: TextStyle(
  //                                           color: Colors.white,
  //                                           fontWeight: FontWeight.w100,
  //                                           fontSize: 13,
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               );
  //                             },
  //                             separatorBuilder: (BuildContext context, int index) {
  //                               return Container(width: 16);
  //                             },
  //                           );
  //                         },
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               const SizedBox(height: 32),
  //               //buildListTemplateSmall(size: size, type: type),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // buildLeftSideBar({required NavigationType type}) {
  //   return AnimatedSize(
  //     curve: Curves.fastOutSlowIn,
  //           duration: new Duration(milliseconds: 300),

  //     child:
  //   );
  // }

  @override
  get bloc => widget.bloc;
}
