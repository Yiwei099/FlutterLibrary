import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xiandun/feature/authorize/controller/authorize_controller.dart';

import '../../../utils/icon_path.dart';
import '../../authorize/widget/authorize_history_widget.dart';
import '../../authorize/widget/start_authorize_widget.dart';
import '../../mine/widget/mine_widget.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<HomeScreen> {
  late HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(HomeController());
    Get.lazyPut(() => AuthorizeController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: _controller.currentIndex.value,
          children: [
            const StartAuthorizeWidget(),
            const AuthorizeHistoryWidget(),
            MineWidget(),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        var currentIndex = _controller.currentIndex.value;
        return BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavigationItem(
                currentIndex: currentIndex,
                path:
                    currentIndex == 0
                        ? IconPath.homeSelected
                        : IconPath.homeUnselected,
                label: '首页',
                onTap: () {
                  _controller.changeIndex(0);
                },
              ),
              _buildBottomNavigationItem(
                currentIndex: currentIndex,
                path:
                    currentIndex == 1
                        ? IconPath.authorizeSelected
                        : IconPath.authorizeUnselected,
                label: '授权',
                badgeCount: _controller.count.value,
                onTap: () {
                  _controller.changeIndex(1);
                },
              ),
              _buildBottomNavigationItem(
                currentIndex: currentIndex,
                path:
                    currentIndex == 2
                        ? IconPath.mineSelected
                        : IconPath.mineUnselected,
                label: '个人中心',
                onTap: () {
                  _controller.changeIndex(2);
                },
              ),
            ],
          ),
          // currentIndex: currentIndex,
          // onTap: _controller.changeIndex,
        );
      }),
    );
  }

  Widget _buildBottomNavigationItem({
    required int currentIndex,
    required String path,
    required String label,
    required GestureTapCallback onTap,
    int badgeCount = 0,
  }) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: onTap,
        child: _convertBottomBarItem(path, badgeCount, label),
      ),
    );
  }

  Widget _convertBottomBarItem(String path, int badgeCount, String label) {
    return Column(
      children: [
        _buildItemByBadge(path, badgeCount),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }

  Widget _buildItemByBadge(String path, int badgeCount) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: -10, end: -12),
      showBadge: badgeCount > 0,
      badgeStyle: badges.BadgeStyle(elevation: 0),
      badgeContent: Text(
        badgeCount.toString(),
        style: TextStyle(color: Colors.white, fontSize: 5.sp),
      ),
      child: Image.asset(path, width: 20, height: 20),
    );
  }
}
