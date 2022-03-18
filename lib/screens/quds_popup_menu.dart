import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../quds_ui_kit.dart';

/// A button with radian ink splash effect.
class QudsPopupButton extends StatefulWidget {
  /// The items of the menu
  final List<QudsPopupMenuBase> items;

  /// The focus node of this button.
  final FocusNode? focusNode;

  /// Weather this button occupies the focus automatically.
  final bool autofocus;

  /// The mouse cursor of this button.
  final MouseCursor? mouseCursor;

  /// The child of this button.
  final Widget? child;

  /// The radius of the ink splash.
  final double? radius;

  /// The tooltip message of this button.
  final String? tooltip;

  final Color? backgroundColor;

  /// Create an instance of [QudsRadianButton].
  const QudsPopupButton(
      {Key? key,
      required this.items,
      this.focusNode,
      this.autofocus = false,
      this.mouseCursor,
      this.backgroundColor,
      this.radius,
      this.tooltip,
      this.child})
      : assert(items.length > 0),
        super(key: key);

  @override
  _QudsPopupButtonState createState() => _QudsPopupButtonState();
}

class _QudsPopupButtonState extends State<QudsPopupButton> {
  Offset? position;
  @override
  Widget build(BuildContext context) {
    Widget result = Semantics(
      button: true,
      enabled: true,
      child: InkResponse(
        onTap: () {
          showQudsPopupMenu(
            backgroundColor: widget.backgroundColor,
            context: context,
            items: widget.items,
          );
        },
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        canRequestFocus: true,
        mouseCursor: widget.mouseCursor,
        child: widget.child,
        radius: widget.radius,
      ),
    );

    if (widget.tooltip != null)
      result = Tooltip(
        message: widget.tooltip!,
        child: result,
      );
    return result;
  }
}

/// The base of the items of [QudsPopupMenu]
abstract class QudsPopupMenuBase {}

/// Quds popup menu that holds a widget
class QudsPopupMenuWidget extends QudsPopupMenuBase {
  /// The builder of the child of this item
  final Widget Function(BuildContext context) builder;

  /// Creates an object of [QudsPopupMenuWidget]
  QudsPopupMenuWidget({required this.builder});
}

/// An item for [QudsPopupMenu] like [ListTile]
class QudsPopupMenuItem extends QudsPopupMenuBase {
  /// The title widget of the item.
  final Widget? title;

  /// The subtitle widget of the item.
  final Widget? subTitle;

  /// The leading widget of the item.
  final Widget? leading;

  /// The trailing widget of the item.
  final Widget? trailing;

  /// The event to be fired when the user press the item
  final VoidCallback onPressed;

  /// Weather to pop when the user press the item.
  final bool popOnTap;

  /// Creates an instance of [QudsPopupMenuItem]
  QudsPopupMenuItem(
      {required this.title,
      required this.onPressed,
      this.popOnTap = true,
      this.subTitle,
      this.leading,
      this.trailing});
}

/// A divider to be inserted in the popup menu
class QudsPopupMenuDivider extends QudsPopupMenuBase {
  /// The color of the divider
  final Color? color;

  /// The height of the divider
  final double? height;

  /// The thickness of the divider
  final double? thickness;

  /// Creates an instance of [QudsPopupMenuDivider]
  QudsPopupMenuDivider({this.height = 1, this.color, this.thickness});
}

/// A Section of items in [QudsPopMenu]
class QudsPopupMenuSection extends QudsPopupMenuBase {
  /// The background color of this section
  final Color? backgroundColor;

  /// The title text of the section
  final String titleText;

  /// The sub title widget of the item
  final Widget? subTitle;

  /// The leading widget of the item
  final Widget? leading;

  /// The sub items of this section
  final List<QudsPopupMenuBase> subItems;

  /// Creates an instance of [QudsPopupMenuSection]
  QudsPopupMenuSection({
    required this.titleText,
    required this.subItems,
    this.subTitle,
    this.leading,
    this.backgroundColor,
  }) : assert(subItems.length > 0);
}

/// Show [QudsPopupMenu] from calling button
/// [context] the calling build context.
/// [items] the items to be shown in the menu
/// [useRootNavigator] weather to use root navigator
/// [backgroundColor] the background of the popup menu
void showQudsPopupMenu(
    {required BuildContext context,
    required List<QudsPopupMenuBase> items,
    bool useRootNavigator = false,
    Color? backgroundColor}) {
  final RenderBox button = context.findRenderObject()! as RenderBox;
  final RenderBox overlay =
      Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
  final RelativeRect position = RelativeRect.fromRect(
    Rect.fromPoints(
      button.localToGlobal(Offset.zero, ancestor: overlay),
      button.localToGlobal(button.size.bottomRight(Offset.zero) + Offset.zero,
          ancestor: overlay),
    ),
    Offset.zero & overlay.size,
  );
  final NavigatorState navigator =
      Navigator.of(context, rootNavigator: useRootNavigator);
  Navigator.push(
      context,
      _PopupMenuRoute(
          backgroundColor: backgroundColor,
          position: position,
          items: items,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          capturedThemes:
              InheritedTheme.capture(from: context, to: navigator.context)));
}

class _QudsPopupMenu extends StatefulWidget {
  final Color? backgroundColor;
  final List<QudsPopupMenuBase> items;

  const _QudsPopupMenu({Key? key, required this.items, this.backgroundColor})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _QudsPopupMenuState();
}

class _QudsPopupMenuState extends State<_QudsPopupMenu> {
  List<List<QudsPopupMenuBase>> itemsStack = [];
  List<QudsPopupMenuSection> sections = [];

  @override
  void initState() {
    itemsStack.add(widget.items);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var currentSection = sections.length == 0 ? null : sections.last;
    var currentItems = itemsStack.last;
    BorderRadius borderRadius = BorderRadius.circular(5);
    Widget result = Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        child: ClipRRect(
            borderRadius: borderRadius,
            child: SingleChildScrollView(
              child: QudsAutoAnimatedSize(
                  alignment: AlignmentDirectional.topStart,
                  startAfterDuration: const Duration(milliseconds: 0),
                  child: Container(
                    width: 300,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (sections.length > 0)
                          Row(
                            children: [
                              IconButton(
                                  tooltip: MaterialLocalizations.of(context)
                                      .backButtonTooltip,
                                  onPressed: _back,
                                  icon: Icon(
                                    Icons.arrow_back_ios_rounded,
                                    color: Theme.of(context).iconTheme.color,
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                sections.last.titleText,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        for (var i in currentItems) _buildItem(i)
                      ],
                    ),
                  )),
            )));

    result = AnimatedContainer(
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black38)],
          borderRadius: borderRadius,
          color: _getCurrentBackgroundColor(context)),
      duration: const Duration(milliseconds: 500),
      child: result,
    );
    result = WillPopScope(
        child: result,
        onWillPop: () async {
          if (currentSection == null) return true;
          _back();
          return false;
        });
    return result;
  }

  void _back() {
    setState(() {
      sections.removeLast();
      itemsStack.removeLast();
    });
  }

  Color _getCurrentBackgroundColor(BuildContext context) {
    Color? result;
    for (int i = sections.length - 1; i > -1; i--)
      if (sections[i].backgroundColor != null) {
        result = sections[i].backgroundColor;
        break;
      }
    result ??= widget.backgroundColor ?? result;
    result ??= Theme.of(context).scaffoldBackgroundColor;
    return result;
  }

  Widget _buildItem(QudsPopupMenuBase item) {
    if (item is QudsPopupMenuSection)
      return ListTile(
        onTap: () => setState(() {
          sections.add(item);
          itemsStack.add(item.subItems);
        }),
        leading: item.leading,
        subtitle: item.subTitle,
        title: Text(item.titleText),
        trailing: Icon(Icons.arrow_forward_ios),
      );

    if (item is QudsPopupMenuDivider)
      return Divider(
        height: item.height,
        thickness: item.thickness,
        color: item.color,
      );

    if (item is QudsPopupMenuItem)
      return ListTile(
        onTap: () {
          if (item.popOnTap == true) Navigator.pop(context);
          item.onPressed.call();
        },
        title: item.title,
        subtitle: item.subTitle,
        leading: item.leading,
        trailing: item.trailing,
      );

    if (item is QudsPopupMenuWidget) return item.builder(context);

    return Container();
  }
}

class _PopupMenuRoute<T> extends PopupRoute<T> {
  _PopupMenuRoute({
    required this.position,
    required this.items,
    this.elevation,
    required this.barrierLabel,
    this.semanticLabel,
    this.shape,
    this.color,
    this.backgroundColor,
    required this.capturedThemes,
  }) : itemSizes = List<Size?>.filled(items.length, null);

  final RelativeRect position;
  final List<QudsPopupMenuBase> items;
  final List<Size?> itemSizes;
  final double? elevation;
  final String? semanticLabel;
  final ShapeBorder? shape;
  final Color? color;
  final CapturedThemes capturedThemes;
  final Color? backgroundColor;

  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
      parent: super.createAnimation(),
      curve: Curves.linear,
      reverseCurve: const Interval(0.0, _kMenuCloseIntervalEnd),
    );
  }

  @override
  Duration get transitionDuration => _kMenuDuration;

  @override
  bool get barrierDismissible => true;

  @override
  Color? get barrierColor => null;

  @override
  final String barrierLabel;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final Widget menu = _QudsPopupMenu(
      backgroundColor: backgroundColor,
      items: items,
    );
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: Builder(
        builder: (BuildContext context) {
          return CustomSingleChildLayout(
            delegate: _PopupMenuRouteLayout(
              position,
              itemSizes,
              Directionality.of(context),
              mediaQuery.padding,
            ),
            child: capturedThemes.wrap(menu),
          );
        },
      ),
    );
  }
}

// Positioning of the menu on the screen.
class _PopupMenuRouteLayout extends SingleChildLayoutDelegate {
  _PopupMenuRouteLayout(
    this.position,
    this.itemSizes,
    this.textDirection,
    this.padding,
  );

  // Rectangle of underlying button, relative to the overlay's dimensions.
  final RelativeRect position;

  // The sizes of each item are computed when the menu is laid out, and before
  // the route is laid out.
  List<Size?> itemSizes;

  // Whether to prefer going to the left or to the right.
  final TextDirection textDirection;

  // The padding of unsafe area.
  EdgeInsets padding;

  // We put the child wherever position specifies, so long as it will fit within
  // the specified parent size padded (inset) by 8. If necessary, we adjust the
  // child's position so that it fits.

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // The menu can be at most the size of the overlay minus 8.0 pixels in each
    // direction.
    return BoxConstraints.loose(constraints.biggest).deflate(
      const EdgeInsets.all(_kMenuScreenPadding) + padding,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // size: The size of the overlay.
    // childSize: The size of the menu, when fully open, as determined by
    // getConstraintsForChild.

    // Find the ideal vertical position.
    double y = position.top;

    // Find the ideal horizontal position.
    double x;
    if (position.left > position.right) {
      // Menu button is closer to the right edge, so grow to the left, aligned to the right edge.
      x = size.width - position.right - childSize.width;
    } else if (position.left < position.right) {
      // Menu button is closer to the left edge, so grow to the right, aligned to the left edge.
      x = position.left;
    } else {
      // Menu button is equidistant from both edges, so grow in reading direction.
      switch (textDirection) {
        case TextDirection.rtl:
          x = size.width - position.right - childSize.width;
          break;
        case TextDirection.ltr:
          x = position.left;
          break;
      }
    }

    // Avoid going outside an area defined as the rectangle 8.0 pixels from the
    // edge of the screen in every direction.
    if (x < _kMenuScreenPadding + padding.left)
      x = _kMenuScreenPadding + padding.left;
    else if (x + childSize.width >
        size.width - _kMenuScreenPadding - padding.right)
      x = size.width - childSize.width - _kMenuScreenPadding - padding.right;
    if (y < _kMenuScreenPadding + padding.top)
      y = _kMenuScreenPadding + padding.top;
    else if (y + childSize.height >
        size.height - _kMenuScreenPadding - padding.bottom)
      y = size.height - padding.bottom - _kMenuScreenPadding - childSize.height;

    return Offset(x, y);
  }

  @override
  bool shouldRelayout(_PopupMenuRouteLayout oldDelegate) {
    // If called when the old and new itemSizes have been initialized then
    // we expect them to have the same length because there's no practical
    // way to change length of the items list once the menu has been shown.
    assert(itemSizes.length == oldDelegate.itemSizes.length);

    return position != oldDelegate.position ||
        textDirection != oldDelegate.textDirection ||
        !listEquals(itemSizes, oldDelegate.itemSizes) ||
        padding != oldDelegate.padding;
  }
}

const Duration _kMenuDuration = Duration(milliseconds: 100);
const double _kMenuCloseIntervalEnd = 1.0 / 3.0;
const double _kMenuScreenPadding = 8.0;
