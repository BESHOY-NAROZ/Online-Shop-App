import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RefreshWidget extends StatelessWidget {
  Future<void> Function() onRefresh;
  Widget widget;
  GlobalKey<RefreshIndicatorState> refreshKey;

  RefreshWidget({this.onRefresh, this.widget, this.refreshKey});

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? refreshAndroidWidget() : refreshIOSWidget();
  }

  refreshAndroidWidget() {
    return RefreshIndicator(
      child: widget,
      onRefresh: onRefresh,
      key: refreshKey,
    );
  }

  refreshIOSWidget() {
    return CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverRefreshControl(
          key: refreshKey,
          onRefresh: onRefresh,
        ),
        SliverToBoxAdapter(
          child: widget,
        )
      ],
    );
  }
}
