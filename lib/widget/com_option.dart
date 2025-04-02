import 'package:FlutterLibrary/utils/colors.dart';
import 'package:flutter/material.dart';

class ComOption extends StatelessWidget {
  const ComOption({
    super.key,
    required this.title,
    this.contentWidget,
    this.onTap,
    this.icon,
    this.showNext = true,
    this.showDivider = true,
  });

  final String title;
  final Widget? contentWidget;
  final Widget? icon;
  final bool showNext;
  final bool showDivider;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    bool showIcon = icon != null;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20,top: 20),
        child: Column(
          children: [
            Row(
              children: [
                showIcon ? icon! : const SizedBox(),
                showIcon ? const SizedBox(width: 10) : const SizedBox(),
                Text(title),
                Expanded(child: contentWidget != null ? contentWidget! : const SizedBox()),
                showNext ? const Icon(Icons.navigate_next) : const SizedBox()
              ],
            ),
            showDivider ? const Column(
              children: [
                SizedBox(height: 20),
                Divider(height: 1, color: MyColors.colorECECEC),
              ],
            ) : const SizedBox()
          ],
        ),
      )
    );
  }
}