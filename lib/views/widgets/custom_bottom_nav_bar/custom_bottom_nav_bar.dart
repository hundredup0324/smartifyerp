// ignore_for_file: prefer_const_constructors, constant_identifier_names, avoid_print, unused_local_variable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:attendance/views/widgets/custom_bottom_nav_bar/reused_gradient.dart';
import 'package:attendance/views/widgets/custom_bottom_nav_bar/styles.dart';
import 'bar_item.dart';
import 'dart:math' as math;
import 'chip_builder.dart';

/// Default size of the curve line.
const double CONVEX_SIZE = 80;

/// Default height of the AppBar.
const double BAR_HEIGHT = 50;

/// Default distance that the child's top edge is inset from the top of the stack.
const double CURVE_TOP = -25;

/// Default size for active tab.
const double ACTION_LAYOUT_SIZE = 60;

/// Default size for active icon in tab.
const double ACTION_INNER_BUTTON_SIZE = 40;

/// Default elevation of [CustomConvexAppBar].
const double ELEVATION = 2;

/// Tab styles.
enum TabStyle {
  /// Convex shape is fixed center with circle, see [FixedCircleTabStyle].
  ///
  /// ![](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-fixed-circle.gif)
  fixedCircle,

  /// Convex shape is moved with circle after selection, see [ReactCircleTabStyle].
  ///
  /// ![](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-react-circle.gif)
  reactCircle,
}

/// Item builder.
abstract class DelegateBuilder {
  /// Called when the tab item is build.
  /// * [context] BuildContext instance;
  /// * [index] tab index;
  /// * [active] tab state;
  Widget build(BuildContext context, int index, bool active);

  /// Whether the convex shape is fixed center or positioned according to selection.
  bool fixed() {
    return false;
  }
}

typedef GestureTapIndexCallback = void Function(int index);

/// Fire before [GestureTapIndexCallback] is handled, you may return false to block the tap event.
typedef TapNotifier = bool Function(int index);

/// Tab builder.
/// * [context] BuildContent instance
/// * [index] index of tab
/// * [active] active state for tab index
typedef CustomTabBuilder = Widget Function(
    BuildContext context, int index, bool active);

/// Interface to apply any custom badge chip.
abstract class ChipBuilder {
  /// Construct a new widget which represent the tab item with custom badge.
  ///
  /// * [context] BuildContext instance;
  /// * [child] the tab item Widget;
  /// * [index] index of the tab item;
  /// * [active] active state for the index;
  Widget build(BuildContext context, Widget child, int index, bool active);
}

class CustomConvexAppBar extends StatefulWidget {
  // /// Tab item builder.
  final DelegateBuilder itemBuilder;

  //
  // /// Badge chip builder.
  final ChipBuilder? chipBuilder;

  /// Tab Click handler.
  final GestureTapIndexCallback? onTap;

  /// Tab event notifier, can be used to block tap event.
  final TapNotifier? onTapNotify;

  /// Tab controller to work with [TabBarView] or [PageView].
  final TabController? controller;

  /// Color of the AppBar.
  final Color? backgroundColor;

  /// Color of the elevation.
  final Color? shadowColor;

  /// Draw the background with topLeft and topRight corner; Only work work with fixed style
  ///
  /// ![corner image](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-corner.png)
  final double? cornerRadius;

  /// If provided, backgroundColor for tab app will be ignored.
  ///
  /// ![](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-gradient.gif)
  final Gradient? gradient;

  /// The initial active index, you can config initialIndex of [TabController] if work with [TabBarView] or [PageView].
  final int? initialActiveIndex;

  /// Disable access of DefaultTabController to avoid unexpected conflict.
  final bool disableDefaultTabController;

  /// Tab count.
  final int count;

  /// Height of the AppBar.
  final double? height;

  /// Size of the curve line.
  final double? curveSize;

  /// The distance that the [actionButton] top edge is inset from the top of the AppBar.
  final double? top;

  /// Elevation for the bar top edge.
  final double? elevation;

  /// The curve to use in the forward direction. Only works when tab style is not fixed.
  final Curve curve;

  CustomConvexAppBar({
    Key? key,
    required List<CustomTabItem> items,
    int? initialActiveIndex,
    bool? disableDefaultTabController,
    GestureTapIndexCallback? onTap,
    TapNotifier? onTabNotify,
    TabController? controller,
    Color? color,
    Color? activeColor,
    Color? backgroundColor,
    Color? shadowColor,
    Gradient? gradient,
    double? height,
    double? curveSize,
    double? top,
    double? elevation,
    double? cornerRadius,
    TabStyle? style,
    Curve? curve,
    ChipBuilder? chipBuilder,
  }) : this.builder(
          key: key,
          itemBuilder: supportedStyle(
            style ?? TabStyle.reactCircle,
            items: items,
            color: color ?? Colors.white60,
            activeColor: activeColor ?? Colors.white,
            backgroundColor: backgroundColor ?? Colors.blue,
            curve: curve ?? Curves.easeInOut,
          ),
          onTap: onTap,
          onTapNotify: onTabNotify,
          controller: controller,
          backgroundColor: backgroundColor,
          shadowColor: shadowColor,
          count: items.length,
          initialActiveIndex: initialActiveIndex,
          disableDefaultTabController: disableDefaultTabController ?? false,
          gradient: gradient,
          height: height,
          curveSize: curveSize,
          top: top,
          elevation: elevation,
          cornerRadius: cornerRadius,
          curve: curve ?? Curves.easeInOut,
          chipBuilder: chipBuilder,
        );

  const CustomConvexAppBar.builder({
    Key? key,
    required this.itemBuilder,
    required this.count,
    this.initialActiveIndex,
    this.disableDefaultTabController = false,
    this.onTap,
    this.onTapNotify,
    this.controller,
    this.backgroundColor,
    this.shadowColor,
    this.gradient,
    this.height,
    this.curveSize,
    this.top,
    this.elevation,
    this.cornerRadius,
    this.curve = Curves.easeInOut,
    this.chipBuilder,
  })  : assert(top == null || top <= 0, 'top should be negative'),
        assert(initialActiveIndex == null || initialActiveIndex < count,
            'initial index should < $count'),
        assert(cornerRadius == null || cornerRadius >= 0,
            'cornerRadius must >= 0'),
        super(key: key);

  factory CustomConvexAppBar.badge(
    Map<int, dynamic> badge, {
    Key? key,
    // config for badge
    Color? badgeTextColor,
    Color? badgeColor,
    EdgeInsets? badgePadding,
    EdgeInsets? badgeMargin,
    double? badgeBorderRadius,
    // parameter for appbar
    required List<CustomTabItem> items,
    int? initialActiveIndex,
    bool? disableDefaultTabController,
    GestureTapIndexCallback? onTap,
    TapNotifier? onTabNotify,
    TabController? controller,
    Color? color,
    Color? activeColor,
    Color? backgroundColor,
    Color? shadowColor,
    Gradient? gradient,
    double? height,
    double? curveSize,
    double? top,
    double? elevation,
    double? cornerRadius,
    TabStyle? style,
    Curve? curve,
  }) {
    DefaultChipBuilder? chipBuilder;
    if (badge.isNotEmpty) {
      chipBuilder = DefaultChipBuilder(
        badge,
        textColor: badgeTextColor ?? Colors.white,
        badgeColor: badgeColor ?? Colors.redAccent,
        padding: badgePadding ?? EdgeInsets.only(left: 4, right: 4),
        margin: badgeMargin ?? EdgeInsets.only(top: 10, right: 10),
        borderRadius: badgeBorderRadius ?? 20,
      );
    }
    return CustomConvexAppBar(
      key: key,
      items: items,
      initialActiveIndex: initialActiveIndex,
      disableDefaultTabController: disableDefaultTabController ?? false,
      onTap: onTap,
      onTabNotify: onTabNotify,
      controller: controller,
      color: color,
      activeColor: activeColor,
      backgroundColor: backgroundColor,
      shadowColor: shadowColor,
      gradient: gradient,
      height: height,
      curveSize: curveSize,
      top: top,
      elevation: elevation,
      cornerRadius: cornerRadius,
      style: style,
      curve: curve,
      chipBuilder: chipBuilder,
    );
  }

  @override
  CustomConvexAppBarState createState() {
    return CustomConvexAppBarState();
  }
}

/// State of [CustomConvexAppBar].
class CustomConvexAppBarState extends State<CustomConvexAppBar>
    with TickerProviderStateMixin {
  int? _currentIndex;
  int? localIndex = 2;

  int? get currentIndex => _currentIndex;
  int _warpUnderwayCount = 0;

  Animation<double>? _animation;
  AnimationController? _animationController;
  TabController? _controller;

  int _previousTimestamp = 0;
  static const _TRANSITION_DURATION = 150;

  @override
  void initState() {
    if (widget.cornerRadius != null && widget.cornerRadius! > 0) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('ConvexAppBar is configured with cornerRadius'),
        ErrorDescription(
            'Currently the corner only work for fixed style, if you are using '
            'other styles, the convex shape can be broken on the first and last tab item '),
        ErrorHint(
            'You should use TabStyle.fixed or TabStyle.fixedCircle to make the'
            ' background display with topLeft/topRight corner'),
      ]);
    }
    _resetState();
    super.initState();
  }

  void _handleTabControllerAnimationTick() {
    if (_warpUnderwayCount > 0 ||
        _controller == null ||
        !_controller!.indexIsChanging) {
      return;
    }
    if (_controller!.index != _currentIndex) {
      _warpToCurrentIndex();
    }
  }

  Future<void> _warpToCurrentIndex() async {
    if (!mounted) return Future<void>.value();
    final c = _controller;
    if (c == null) {
      return;
    }
    if (_blockEvent(c.index)) return;
    final previousIndex = c.previousIndex;
    final index = c.index;
    // Counter to avoid repeat calls to animateTo in the middle of a transition.
    _warpUnderwayCount += 1;

    await animateTo(index, from: previousIndex);
    _warpUnderwayCount -= 1;
    return Future<void>.value();
  }

  /// change active tab index; can be used with [PageView].
  Future<void> animateTo(int index, {int? from}) async {
    var gap = DateTime.now().millisecondsSinceEpoch - _previousTimestamp;
    _updateAnimation(
      from: from ?? _currentIndex,
      to: index,
      duration: Duration(
          milliseconds: gap < _TRANSITION_DURATION ? 0 : _TRANSITION_DURATION),
    );
    // ignore: unawaited_futures
    _animationController?.forward();
    if (mounted) {
      setState(() {
        _currentIndex = index;
      });
    }
    _previousTimestamp = DateTime.now().millisecondsSinceEpoch;
  }

  _updateAnimation(
      {int? from,
      int? to,
      Duration duration = const Duration(milliseconds: _TRANSITION_DURATION)}) {
    if (from != null && (from == to) && _animation != null) {
      return _animation!;
    }
    from ??= _controller?.index ?? widget.initialActiveIndex ?? 0;
    to ??= from;
    final lower = (2 * from + 1) / (2 * widget.count);
    final upper = (2 * to + 1) / (2 * widget.count);
    _animationController?.dispose();
    final controller = AnimationController(duration: duration, vsync: this);
    final curve = CurvedAnimation(
      parent: controller,
      curve: widget.curve,
    );
    _animationController = controller;
    return _animation = Tween(begin: lower, end: upper).animate(curve);
  }

  @override
  void dispose() {
    _controller?.animation?.removeListener(_handleTabControllerAnimationTick);
    _controller = null;
    //
    _animationController?.dispose();
    super.dispose();
  }

  TabController? get _currentControllerRef {
    if (widget.disableDefaultTabController == true) {
      return widget.controller;
    }
    return widget.controller ?? DefaultTabController.maybeOf(context);
  }

  void _updateTabController() {
    final newController = _currentControllerRef;
    assert(() {
      if (newController != null &&
          widget.controller == null &&
          widget.initialActiveIndex != null) {
        throw FlutterError(
            'ConvexAppBar.initialActiveIndex is not allowed when working with TabController.\n'
            'Please setup through TabController.initialIndex, or disable DefaultTabController by #disableDefaultTabController');
      }
      return true;
    }());
    if (newController == _controller) return;
    _controller?.animation?.removeListener(_handleTabControllerAnimationTick);
    _controller = newController;
    _controller?.animation?.addListener(_handleTabControllerAnimationTick);
  }

  void _resetState() {
    var index = _controller?.index ?? widget.initialActiveIndex;
    // // when both initialActiveIndex and controller are not configured
    _currentIndex = index ?? 0;
    //
    if (!isFixed() && _controller != null) {
      // when controller is not defined, the default index can rollback to 0
      // https://github.com/hacktons/convex_bottom_bar/issues/67
      _updateAnimation();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_controller != _currentControllerRef) {
      _updateTabController();
      _resetState();
    }
  }

  @override
  void didUpdateWidget(CustomConvexAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller ||
        widget.count != oldWidget.count) {
      _updateTabController();
      _resetState();
    }
  }

  var active = false;

  @override
  Widget build(BuildContext context) {
    // take care of iPhoneX' safe area at bottom edge
    final additionalBottomPadding =
        math.max(MediaQuery.of(context).padding.bottom, 0.0);
    final convexIndex = _currentIndex;

    final height = (widget.height ?? BAR_HEIGHT) + additionalBottomPadding;
    final width = MediaQuery.of(context).size.width;
    int from = 2;
    int to = from;
    final lower = (2 * from + 1) / (2 * widget.count);
    final upper = (2 * to + 1) / (2 * widget.count);
    final controller =
        AnimationController(duration: Duration(milliseconds: 150), vsync: this);
    final curve = CurvedAnimation(
      parent: controller,
      curve: widget.curve,
    );
    _animationController = controller;
    _animation = Tween(begin: lower, end: upper).animate(curve);
    var percent = _animation;
    var factor = 1 / widget.count;
    var textDirection = Directionality.of(context);
    var dx = convexIndex! / (widget.count - 1);
    if (textDirection == TextDirection.rtl) {
      dx = 1 - dx;
    }

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: height,
          width: width,
          // color: Colors.red,
          child: CustomPaint(
            painter: ConvexPainter(
              top: widget.top ?? CURVE_TOP,
              width: widget.curveSize ?? CONVEX_SIZE,
              height: widget.curveSize ?? CONVEX_SIZE,
              color: widget.backgroundColor ?? Colors.blue,
              shadowColor: widget.shadowColor ?? Colors.transparent,
              gradient: widget.gradient,
              sigma: widget.elevation ?? ELEVATION,
              leftPercent: percent!,
              textDirection: textDirection,
              cornerRadius: widget.cornerRadius,
            ),
          ),
        ),
        // _barContent(height, additionalBottomPadding, convexIndex),
        Positioned.fill(
          top: widget.top ?? CURVE_TOP,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(widget.count, (index) {
              // active = widget.initialActiveIndex == index;
              active = _currentIndex == index;

              return Padding(
                padding: EdgeInsets.only(
                    top: index == 2 ? 0 : 30,
                    left: index == 1 ? 0 : 12,
                    right: index == 1 ? 4 : 12),
                child: GestureDetector(
                    onTap: () {
                      _currentIndex = index;
                      _onTabClick(index);
                      setState(() {});
                    },
                    child: _newTab(index, active)),
              );
            }),
          ),
        )
      ],
    );
  }

  /// Whether the tab shape are fixed or not.
  bool isFixed() => widget.itemBuilder.fixed();

  Widget _barContent(double height, double paddingBottom, int curveTabIndex) {
    var children = <Widget>[];
    for (var i = 0; i < widget.count; i++) {
      var active = _currentIndex == i;

      children.add(Expanded(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onTabClick(i),
          child: i == 2
              ? Container(
                  height: 25,
                  width: 15,
                  color: Colors.green,
                )
              : SizedBox(),
        ),
      ));
    }

    return Container(
      height: height,
      padding: EdgeInsets.only(bottom: paddingBottom),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }

  Widget _newTab(int i, bool active) {
    final child = widget.itemBuilder.build(context, i, active);
    return widget.chipBuilder?.build(context, child, i, active) ?? child;
  }

  bool _blockEvent(int i) {
    if (widget.onTapNotify != null && !widget.onTapNotify!(i)) {
      debugPrint('tap event block by ${widget.onTapNotify}');
      return true;
    }
    return false;
  }

  void _onTabClick(int i) {
    setState(() {});
    if (_blockEvent(i)) return;
    if (_controller == null) {
      animateTo(i);
    } else {
      // animation listener [_handleTabControllerAnimationTick] will drive the
      // internal animateTo() via [_warpToCurrentIndex].
      _controller!.animateTo(i);
    }
    widget.onTap?.call(i);
  }

  /// Used to simulate tab event on tab item; This will notify [CustomConvexAppBar.onTap];
  ///
  /// Also see:
  /// * [animateTo]
  void tap(int index) {
    _onTabClick(index);
  }
}

class StyleProvider extends InheritedWidget {
  /// Style configuration
  final StyleHook style;

  /// Provide style to provider, [CustomConvexAppBar] will bind to the provided style.
  /// See also:
  ///
  ///  * [CustomConvexAppBar]
  ///  * [StyleHook]
  const StyleProvider({Key? key, required this.style, required Widget child})
      : super(key: key, child: child);

  /// Get instance of style provider, can be null if you're not providing one.
  static StyleProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StyleProvider>();
  }

  @override
  bool updateShouldNotify(StyleProvider oldWidget) {
    return style.activeIconMargin != oldWidget.style.activeIconMargin ||
        style.activeIconSize != oldWidget.style.activeIconSize ||
        style.iconSize != oldWidget.style.iconSize;
  }
}

/// Custom painter to draw the [ConvexNotchedRectangle] into canvas.
class ConvexPainter extends CustomPainter {
  final _paint = Paint();
  final _shadowPaint = Paint();
  late ConvexNotchedRectangle _shape;
  final ReusedGradient _gradient = ReusedGradient();

  /// Width of the convex shape.
  final double width;

  /// Height of the convex shape.
  final double height;

  /// Position in vertical which describe the offset of shape.
  final double top;

  /// Position in horizontal which describe the offset of shape.
  final Animation<double> leftPercent;

  /// RLT support
  final TextDirection? textDirection;

  /// Create painter
  ConvexPainter({
    required this.top,
    required this.width,
    required this.height,
    this.leftPercent = const AlwaysStoppedAnimation<double>(0.5),
    this.textDirection,
    Color color = Colors.white,
    Color shadowColor = Colors.black38,
    double sigma = 2,
    Gradient? gradient,
    double? cornerRadius,
  }) : super(repaint: leftPercent) {
    _paint.color = color;
    try {
      _shadowPaint
        ..color = shadowColor
        ..maskFilter = MaskFilter.blur(BlurStyle.outer, sigma);
    } catch (e, s) {
      debugPrintStack(label: 'ElevationError', stackTrace: s);
    }
    _gradient.gradient = gradient;
    _shape = ConvexNotchedRectangle(radius: cornerRadius ?? 0);
  }

  @override
  void paint(Canvas canvas, Size size) {
    var host = Rect.fromLTWH(0, 0, size.width, size.height);
    var percent = textDirection == TextDirection.rtl
        ? (1 - leftPercent.value)
        : leftPercent.value;
    var guest =
        Rect.fromLTWH(size.width * percent - width / 2, top, width, height);
    _gradient.updateWith(_paint, size: host);
    var path = _shape.getOuterPath(host, guest);
    canvas.drawPath(path, _shadowPaint);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(ConvexPainter oldDelegate) {
    return oldDelegate.leftPercent.value != leftPercent.value ||
        oldDelegate._paint != _paint;
  }
}

class ConvexNotchedRectangle extends NotchedShape {
  /// Draw the background with topLeft and topRight corner
  final double radius;

  /// Create Shape instance
  const ConvexNotchedRectangle({this.radius = 0});

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) return Path()..addRect(host);

    // The guest's shape is a circle bounded by the guest rectangle.
    // So the guest's radius is half the guest width.
    final notchRadius = guest.width / 2.0;

    const s1 = 15.0;
    const s2 = 1.0;

    final r = notchRadius;
    final a = -1.0 * r - s2;
    final b = host.top - guest.center.dy;

    final n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    final p2xA = ((a * r * r) - n2) / (a * a + b * b);
    final p2xB = ((a * r * r) + n2) / (a * a + b * b);
    final p2yA = -math.sqrt(r * r - p2xA * p2xA);
    final p2yB = -math.sqrt(r * r - p2xB * p2xB);

    final p = List<Offset>.filled(6, Offset.zero, growable: false);
    // p0, p1, and p2 are the control points for segment A.
    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    final cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    // p3, p4, and p5 are the control points for segment B, which is a mirror
    // of segment A around the y axis.
    p[3] = Offset(-1.0 * p[2].dx, p[2].dy);
    p[4] = Offset(-1.0 * p[1].dx, p[1].dy);
    p[5] = Offset(-1.0 * p[0].dx, p[0].dy);

    // translate all points back to the absolute coordinate system.
    for (var i = 0; i < p.length; i += 1) {
      p[i] = p[i] + guest.center;
      //p[i] += padding;
    }

    return radius > 0
        ? (Path()
          ..moveTo(host.left, host.top + radius)
          ..arcToPoint(Offset(host.left + radius, host.top),
              radius: Radius.circular(radius))
          ..lineTo(p[0].dx, p[0].dy)
          ..quadraticBezierTo(p[1].dx, p[1].dy, p[2].dx, p[2].dy)
          ..arcToPoint(
            p[3],
            radius: Radius.circular(notchRadius),
            clockwise: true,
          )
          ..quadraticBezierTo(p[4].dx, p[4].dy, p[5].dx, p[5].dy)
          ..lineTo(host.right - radius, host.top)
          ..arcToPoint(Offset(host.right, host.top + radius),
              radius: Radius.circular(radius))
          ..lineTo(host.right, host.bottom)
          ..lineTo(host.left, host.bottom)
          ..close())
        : (Path()
          ..moveTo(host.left, host.top)
          ..lineTo(p[0].dx, p[0].dy)
          ..quadraticBezierTo(p[1].dx, p[1].dy, p[2].dx, p[2].dy)
          ..arcToPoint(
            p[3],
            radius: Radius.circular(notchRadius),
            clockwise: true,
          )
          ..quadraticBezierTo(p[4].dx, p[4].dy, p[5].dx, p[5].dy)
          ..lineTo(host.right, host.top)
          ..lineTo(host.right, host.bottom)
          ..lineTo(host.left, host.bottom)
          ..close());
  }
}
