import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xiandun/utils/colors.dart';

class SecondaryConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final String cancelText;
  final String confirmText;
  final TextAlign contentAlign;
  final VoidCallback onConfirm;

  const SecondaryConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    this.cancelText = '取消',
    this.confirmText = '确认',
    this.contentAlign = TextAlign.center,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // 圆角
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                color: MyColors.black333333,
              ),
            ),
            SizedBox(height: 16),
            Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: MyColors.black333333,
                fontSize: 8.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: MyColors.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: MyColors.primary),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(cancelText),
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: onConfirm,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: MyColors.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(confirmText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
