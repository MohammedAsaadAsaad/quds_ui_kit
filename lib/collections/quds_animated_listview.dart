import 'package:flutter/widgets.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';

class QudsAnimatedListView extends ListView {
  QudsAnimatedListView(
      {List<Widget>? children,
      ScrollPhysics? physics,
      EdgeInsets? padding,
      bool keepChildrenAlive = true,
      SlideDirection slideDirection = SlideDirection.Start,
      Curve curve = Curves.bounceOut,
      Duration duration = const Duration(milliseconds: 500)})
      : super(children: [
          if (children != null)
            for (var c in children)
              _QudsAnimatedListTile(
                keepAlive: keepChildrenAlive,
                child: c,
                curve: curve,
                duration: duration,
                slideDirection: slideDirection,
              )
        ], padding: padding, cacheExtent: 0, physics: physics);
}

class _QudsAnimatedListTile extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final bool keepAlive;
  final SlideDirection slideDirection;
  const _QudsAnimatedListTile(
      {Key? key,
      required this.child,
      required this.curve,
      required this.duration,
      required this.keepAlive,
      required this.slideDirection})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _QudsAnimatedListTileState();
}

class _QudsAnimatedListTileState extends State<_QudsAnimatedListTile>
    with AutomaticKeepAliveClientMixin {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    late Offset initialOffset;
    switch (widget.slideDirection) {
      case SlideDirection.Up:
        initialOffset = Offset(0, 0.7);
        break;
      case SlideDirection.Down:
        initialOffset = Offset(0, -0.7);
        break;
      case SlideDirection.Left:
        initialOffset = Offset(0.4, 0);
        break;
      case SlideDirection.Right:
        initialOffset = Offset(-0.4, 0);
        break;
      case SlideDirection.Start:
        var isLTR = Directionality.of(context) == TextDirection.ltr;
        initialOffset = Offset(isLTR ? 0.4 : -0.4, 0);
        break;
      case SlideDirection.End:
        var isLTR = Directionality.of(context) == TextDirection.ltr;
        initialOffset = Offset(isLTR ? -0.4 : 0.4, 0);
        break;
    }
    return QudsAutoAnimatedSlide(
        xOffset: initialOffset.dx,
        yOffset: initialOffset.dy,
        curve: widget.curve,
        duration: widget.duration,
        child: QudsAutoAnimatedOpacity(
          curve: widget.curve,
          duration: widget.duration,
          child: widget.child,
        ));
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}
