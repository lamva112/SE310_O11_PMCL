import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../enums.dart';

import '../../../../data/data.dart';
import '../widget/side_bar_item.dart';

class LeftSideBar extends StatelessWidget {
  final NavigationType type;
  final User? user;
  final Function(NavigationType) onTapSideBarItem;

  const LeftSideBar({
    required this.type,
    required this.onTapSideBarItem,
    super.key,
    this.user,
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                LottieBuilder.asset(
                  "assets/images/json/avatar.json",
                  fit: BoxFit.cover,
                  width: 250,
                  height: 250,
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Student information",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "User name: ${user?.userName ?? ""}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Email: ${user?.email ?? ""}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Birthday: ${user?.dateOfBirth ?? ""}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
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
