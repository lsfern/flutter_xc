import 'package:flutter/material.dart';

/// Loading View
class LoadingView extends StatelessWidget {
  final Widget child;
  final bool isShowLoading;
  final bool isCover;

  const LoadingView({
    Key key,
    this.isCover = false,
    @required this.child,
    @required this.isShowLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !isCover
        ? !isShowLoading ? child : _loadingView
        : Stack(
            children: <Widget>[child, isShowLoading ? _loadingView : null],
          );
  }

  Widget get _loadingView {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            strokeWidth: 2,
          ),
          Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                '加载中...',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ))
        ],
      ),
    );
  }
}
