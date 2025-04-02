import 'package:FlutterLibrary/feature/home/controller/home_controller.dart';
import 'package:FlutterLibrary/utils/channel_manager.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


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
    ChannelManager.getInstance().setupMethodCallHandler();
  }

  @override
  void dispose() {
    ChannelManager.getInstance().destroyMethodCallHandler();
    //移除所有控制器
    Get.deleteAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: _controller.currentIndex.value,
          children: const [
            SizedBox(),
            SizedBox(),
            SizedBox(),
          ],
        );
      }),
      bottomNavigationBar: SafeArea(
        child: Obx(() {
          var currentIndex = _controller.currentIndex.value;
          return BottomAppBar(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 6,
              left: 16,
              right: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBottomNavigationItem(
                  currentIndex: currentIndex,
                  path:
                      currentIndex == 0
                          ? Icons.home
                          : Icons.home_outlined,
                  label: '1',
                  onTap: () {
                    _controller.changeIndex(0);
                  },
                ),
                _buildBottomNavigationItem(
                  currentIndex: currentIndex,
                  path:
                      currentIndex == 1
                          ? Icons.ac_unit
                          : Icons.abc_outlined,
                  label: '2',
                  badgeCount: 0,
                  onTap: () {
                    _controller.changeIndex(1);
                  },
                ),
                _buildBottomNavigationItem(
                  currentIndex: currentIndex,
                  path:
                      currentIndex == 2
                          ? Icons.settings
                          : Icons.settings_ethernet,
                  label: '3',
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
      ),
    );
  }

  Widget _buildBottomNavigationItem({
    required int currentIndex,
    required IconData path,
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

  Widget _convertBottomBarItem(IconData path, int badgeCount, String label) {
    return Column(
      children: [
        _buildItemByBadge(path, badgeCount),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }

  Widget _buildItemByBadge(IconData path, int badgeCount) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: -10, end: -12),
      showBadge: badgeCount > 0,
      badgeStyle: const badges.BadgeStyle(elevation: 0),
      badgeContent: Text(
        badgeCount.toString(),
        style: TextStyle(color: Colors.white, fontSize: 5.sp),
      ),
      child: Icon(path),
    );
  }
}
