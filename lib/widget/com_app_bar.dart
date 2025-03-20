import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xiandun/utils/colors.dart';
import 'package:xiandun/utils/icon_path.dart';

class ComAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showLeading;
  final List<Widget> actions;

  const ComAppBar({
    super.key,
    required this.title,
    this.actions = const [],
    this.showLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return _convertAppBar();
  }

  PreferredSizeWidget _convertAppBar() {
    return AppBar(
      backgroundColor: MyColors.primary,
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 10.sp),
      ),
      centerTitle: true,
      leading:
          showLeading
              ? IconButton(
                onPressed: () => {Get.back()},
                icon: Image.asset(IconPath.back, width: 15, height: 15),
              )
              : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
