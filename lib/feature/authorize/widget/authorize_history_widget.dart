import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiandun/bean/authorize_history_response_item.dart';
import 'package:xiandun/constants/route.dart';
import 'package:xiandun/utils/icon_path.dart';
import 'package:xiandun/utils/route_middleware.dart';
import 'package:xiandun/widget/com_app_bar.dart';

import '../../../bean/authorize_history.dart';
import '../../../utils/image_path.dart';
import '../controller/authorize_controller.dart';

class AuthorizeHistoryWidget extends StatefulWidget {
  const AuthorizeHistoryWidget({super.key});

  @override
  State<StatefulWidget> createState() => _AuthorizeHistoryWidgetState();
}

class _AuthorizeHistoryWidgetState extends State<AuthorizeHistoryWidget> {
  late AuthorizeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<AuthorizeController>();
    _controller.onRefreshAuthorizeHistoryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ComAppBar(title: '授权管理', showLeading: false),
      body: _convertWidget(),
    );
  }

  Widget _convertWidget() {
    if (_controller.authorizeHistoryList.isEmpty) {
      return _convertEmptyWidget();
    } else {
      return _convertDataWidget();
    }
  }

  Widget _convertDataWidget() {
    return ListView.builder(
      itemCount: _controller.authorizeHistoryList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap:
              () => {
                RouteMiddleWare.getInstance().redirectAfterLogin(
                  name: Routes.authorizeDetail,
                  args: {'id': '23213214'},
                ),
              },
          child: _convertDataItem(_controller.authorizeHistoryList[index]),
        );
      },
    );
  }

  Widget _convertDataItem(AuthorizeHistoryResponseItem item) {
    int colorValue = 0;
    switch (item.status) {
      case AuthorizeHistory.STATUS_AUTHORIZED:
        colorValue = 0xFF02B449;
      case AuthorizeHistory.STATUS_REVOEKE:
      case AuthorizeHistory.STATUS_REFUSE:
      case AuthorizeHistory.STATUS_EXPIRES:
        colorValue = 0xFF131415;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white, // 设置背景颜色
        borderRadius: BorderRadius.circular(8), // 设置圆角
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // 阴影颜色和透明度
            spreadRadius: 2, // 阴影扩散半径
            blurRadius: 5, // 阴影模糊半径
            offset: Offset(0, 3), // 阴影偏移
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              item.red
                  ? Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: const CircleAvatar(
                      radius: 3, // 圆点的半径
                      backgroundColor: Colors.red, // 圆点的颜色
                      child: SizedBox(), // 可以为空
                    ),
                  )
                  : const SizedBox(),
              Expanded(child: Text('车架号：${item.vin}')),
              const Text('查看详情', style: TextStyle(color: Color(0xFF1D51D2))),
              Image.asset(
                IconPath.next,
                color: Color(0xFF1D51D2),
                width: 16,
                height: 16,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(color: Color(0xFFF1F1F1), height: 1),
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: const Text(
                  '授权开始时间',
                  style: TextStyle(color: Color(0xFF666666)),
                ),
              ),
              Expanded(flex: 7, child: Text(item.authTime)),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: const Text(
                  '授权结果',
                  style: TextStyle(color: Color(0xFF666666)),
                ),
              ),
              Expanded(
                flex: 7,
                child: Text(
                  item.convertStatusName(),
                  style: TextStyle(color: Color(colorValue)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _convertEmptyWidget() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          const SizedBox(height: 200),
          Image.asset(ImagePath.emptyData, width: 150, height: 150),
          const Text('暂无授权内容', style: TextStyle(color: Color(0xFF7E7E7E))),
        ],
      ),
    );
  }
}
