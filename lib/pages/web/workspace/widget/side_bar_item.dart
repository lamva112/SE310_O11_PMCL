import 'package:flutter/material.dart';

import '../../../../enums.dart';
import '../../../../generated/l10n.dart';
import '../../../../resources/colors.dart';

class SideBarItem extends StatelessWidget {
  final NavigationType? type;
  final bool isSelected;
  final bool onlyIcon;
  final bool isExpanded;
  final Function()? onTap;
  final Function(bool isExpanded)? onExpanded;

  const SideBarItem(
      {super.key,
      this.type,
      this.isSelected = false,
      required this.isExpanded,
      this.onTap,
      this.onlyIcon = false,
      required this.onExpanded});

  @override
  Widget build(BuildContext context) {
    //final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    IconData? icon;
    String? title = '';
    S localization = S.of(context);
    switch (type) {
      case null:
      case NavigationType.home:
        icon = Icons.home_max_rounded;
        title = "Home";
        break;
      case NavigationType.search:
        icon = Icons.search_outlined;
        title = "Dictionary";
        break;
      case NavigationType.settings:
        icon = Icons.quiz_outlined;
        title = "Quiz";
        break;
      case NavigationType.template:
        icon = Icons.psychology_alt_outlined;
        title = "Chat bot";
        break;
    }
    return InkWell(
      hoverColor: AppColors.primaryWhite,
      splashColor: AppColors.primaryWhite,
      onTap: () {
        onTap?.call();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
            color: AppColors.primaryWhite,
            border: type == NavigationType.settings
                ? Border(
                    top: BorderSide(
                      color: AppColors.primaryWhite,
                    ),
                  )
                : null),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              decoration: BoxDecoration(
                borderRadius: type == NavigationType.settings
                    ? BorderRadius.only(
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                      )
                    : BorderRadius.circular(8.0),
                color: isSelected
                    ? AppColors.primaryBlack
                    : AppColors.primaryWhite,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: 24.0,
                    color: isSelected
                        ? AppColors.primaryWhite
                        : AppColors.primaryBlack,
                  ),
                  if (!onlyIcon)
                    SizedBox(
                      width: 16.0,
                    ),
                  if (!onlyIcon)
                    Expanded(
                        child: Text(
                      title,
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          color: isSelected
                              ? AppColors.primaryWhite
                              : AppColors.primaryBlack),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
                  // if (type == NavigationType.template && !onlyIcon)
                  //   InkWell(
                  //     onTap: () {
                  //       onExpanded?.call(!isExpanded);
                  //     },
                  //     child: Icon(
                  //       isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                  //       size: 24.0,
                  //     ),
                  //   ),
                ],
              ),
            ),
            // if (type == NavigationType.template && isExpand && !onlyIcon)
          ],
        ),
      ),
    );
  }
}
