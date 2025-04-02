import 'package:FlutterLibrary/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
          title: '框架',
          theme: ThemeData(
            colorScheme: const ColorScheme.light(
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
