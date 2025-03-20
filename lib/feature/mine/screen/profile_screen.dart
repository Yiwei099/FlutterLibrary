import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xiandun/utils/colors.dart';
import 'package:xiandun/utils/icon_path.dart';
import 'package:xiandun/widget/com_app_bar.dart';

import '../../../constants/route.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: ComAppBar(title: '个人资料'), body: _convertBody());
  }

  Widget _convertBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
          InkWell(
            onTap: () => {print('换头像')},
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(IconPath.profile),
            ),
          ),
          const SizedBox(height: 6),
          Text('点击更换头像', style: TextStyle(color: Colors.black, fontSize: 7.sp)),
          InkWell(
            onTap: () => {Get.toNamed(Routes.modifyProfile)},
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 30,
                bottom: 10,
              ),
              child: Row(
                children: [
                  const Text('昵称'),
                  const SizedBox(width: 10,),
                  Expanded(child: const Text('周杰伦',textAlign: TextAlign.end,)),
                  Image.asset(IconPath.next, width: 16, height: 16),
                ],
              ),
            ),
          ),
          // const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Divider(height: 1, color: MyColors.colorEEEEEE),
          ),
        ],
      ),
    );
  }
}
