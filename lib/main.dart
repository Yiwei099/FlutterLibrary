import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xiandun/utils/colors.dart';

import 'constants/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(207, 448),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: '弦盾',
          theme: ThemeData(
            colorScheme: ColorScheme.light(
              primary: MyColors.primary,
              onPrimary: Colors.white,
              onSecondary: Colors.white,
              surface: Colors.white,
            ),
          ),
          themeMode: ThemeMode.system,
          defaultTransition: Transition.rightToLeft,
          initialRoute: Routes.home,
          getPages: Routes.getInstance().pages,
        );
      },
    );
  }
}
