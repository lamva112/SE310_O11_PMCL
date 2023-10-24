import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../constants.dart';
import '../../../../../enums.dart';
import '../../../../../resources/colors.dart';

import '../widget/side_bar_item.dart';

class LeftSideBar extends StatelessWidget {
  final NavigationType type;
  final Function(NavigationType) onTapSideBarItem;

  const LeftSideBar({
    required this.type,
    required this.onTapSideBarItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: const EdgeInsets.only(top: 16.0),
        color: Colors.white,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
          }, scrollbars: false),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  // color: Colors.red,
                  margin: const EdgeInsets.only(
                    top: 12,
                    left: 12,
                    right: 10,
                    bottom: 10,
                  ),
                  child: Row(
                    children: [
                      Image.asset("assets/images/png/insta_logo.png"),
                      Image.asset("assets/images/png/font_logo.png"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                LottieBuilder.asset(
                  "assets/images/json/avatar.json",
                  fit: BoxFit.cover,
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Abhivan Khare",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "@abhi_navikhare",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Abhivan Khare",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.only(left: 25, right: 10),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "UI Designer | Traveler | Lifestyle Blogger",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Story Highlights",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 70,
                  // color: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text(
                            "472",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Posts",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const VerticalDivider(
                        endIndent: 35,
                        color: Colors.black,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text(
                            "12.4K",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Followers",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const VerticalDivider(
                        endIndent: 35,
                        color: Colors.black,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text(
                            "228",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Following",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Abhivan Khare",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.only(left: 25, right: 10),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "UI Designer | Traveler | Lifestyle Blogger",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Story Highlights",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerLeft,
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(dragDevices: {
                        PointerDeviceKind.mouse,
                        PointerDeviceKind.touch,
                      }, scrollbars: false),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ...List.generate(storyHighlights.length, (index) {
                              if (index == 0) {
                                return Column(
                                  children: const [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.grey,
                                      child:
                                          Icon(Icons.add, color: Colors.black),
                                    ),
                                    SizedBox(height: 5),
                                    Text("New")
                                  ],
                                );
                              }
                              return Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage: AssetImage(
                                        "${storyHighlights[index]["img"]}",
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(storyHighlights[index]["name"])
                                  ],
                                ),
                              );
                            })
                          ],
                        ),
                      ),
                    )),
                const SizedBox(height: 25),
                SideBarItem(
                  type: NavigationType.home,
                  onTap: () {
                    onTapSideBarItem.call(NavigationType.home);
                  },
                  isSelected: type == NavigationType.home,
                  onlyIcon: false,
                  onExpanded: (bool isExpanded) {
                    // previousStateListCategory = isExpanded;
                  },
                  isExpanded: true,
                ),
                SizedBox(
                  height: 16.0,
                ),
                SideBarItem(
                  type: NavigationType.search,
                  onTap: () {
                    onTapSideBarItem.call(NavigationType.search);
                  },
                  isSelected: type == NavigationType.search,
                  onlyIcon: false,
                  onExpanded: (bool isExpanded) {
                    // previousStateListCategory = isExpanded;
                  },
                  isExpanded: true,
                ),
                SizedBox(
                  height: 16.0,
                ),
                SideBarItem(
                  type: NavigationType.settings,
                  onTap: () {
                    onTapSideBarItem.call(NavigationType.settings);
                  },
                  isSelected: type == NavigationType.settings,
                  onlyIcon: false,
                  onExpanded: (bool isExpanded) {
                    // previousStateListCategory = isExpanded;
                  },
                  isExpanded: true,
                ),
                SizedBox(
                  height: 16.0,
                ),
                SideBarItem(
                  type: NavigationType.template,
                  onTap: () {
                    onTapSideBarItem.call(NavigationType.template);
                  },
                  isSelected: type == NavigationType.template,
                  onlyIcon: false,
                  onExpanded: (bool isExpanded) {},
                  isExpanded: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
