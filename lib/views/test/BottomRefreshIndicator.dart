// Copyright 2014 The Flutter Authors. All rights reserved. Use of this source
// code is governed by a BSD-style license that can be found in the LICENSE
// file. @dart = 2.8

import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// import 'debug.dart'; import 'material_localizations.dart'; import
// 'progress_indicator.dart'; import 'theme.dart'; The over-scroll distance that
// moves the indicator to its maximum displacement, as a percentage of the
// scrollable's container extent.
const double _kDragContainerExtentPercentage = 0.25;

// How much the scroll's drag gesture can overshoot the RefreshIndicator's
// displacement; max displacement = _kDragSizeFactorLimit * displacement.
const double _kDragSizeFactorLimit = 1.5;

// When the scroll ends, the duration of the refresh indicator's animation to
// the RefreshIndicator's displacement.
const Duration _kIndicatorSnapDuration = Duration(milliseconds: 150);

// The duration of the ScaleTransition that starts when the refresh action has
// completed.
const Duration _kIndicatorScaleDuration = Duration(milliseconds: 200);

// / The signature for a function that's called when the user has dragged a /
// [RefreshIndicator] far enough to demonstrate that they want the app to /
// refresh. The returned [Future] must complete when the refresh operation is /
// finished. / / Used by [RefreshIndicator.onRefresh].
typedef RefreshCallback = Future<void> Function();

// The state machine moves through these modes only when the scrollable
// identified by scrollableKey has been scrolled to its min or max limit.
enum _RefreshIndicatorMode {
  drag, // Pointer is down.
  armed, // Dragged far enough that an up event will run the onRefresh callback.
  snap, // Animating to the indicator's final "displacement".
  refresh, // Running the refresh callback.
  done, // Animating the indicator's fade-out after refreshing.
  canceled, // Animating the indicator's fade-out after not arming.
}

// / A widget that supports the Material "swipe to refresh" idiom. / / When the
// child's [Scrollable] descendant overscrolls, an animated circular / progress
// indicator is faded into view. When the scroll ends, if the / indicator has
// been dragged far enough for it to become completely opaque, / the [onRefresh]
// callback is called. The callback is expected to update the / scrollable's
// contents and then complete the [Future] it returns. The refresh / indicator
// disappears after the callback's [Future] has completed. / / ##
// Troubleshooting / / ### Refresh indicator does not show up / / The
// [RefreshIndicator] will appear if its scrollable descendant can be /
// overscrolled, i.e. if the scrollable's content is bigger than its viewport. /
// To ensure that the [RefreshIndicator] will always appear, even if the /
// scrollable's content fits within its viewport, set the scrollable's /
// [Scrollable.physics] property to [AlwaysScrollableScrollPhysics]: / / ```dart
// / ListView( /   physics: const AlwaysScrollableScrollPhysics(), /   children:
// ... / ) / ``` / / A [RefreshIndicator] can only be used with a vertical
// scroll view. / / See also: / /  *
// <https://material.io/design/platform-guidance/android-swipe-to-refresh.html>
// /  * [RefreshIndicatorState], can be used to programmatically show the
// refresh indicator. /  * [RefreshProgressIndicator], widget used by
// [RefreshIndicator] to show /    the inner circular progress spinner during
// refreshes. /  * [CupertinoSliverRefreshControl], an iOS equivalent of the
// pull-to-refresh pattern. /    Must be used as a sliver inside a
// [CustomScrollView] instead of wrapping /    around a [ScrollView] because
// it's a part of the scrollable instead of /    being overlaid on top of it.
class BottomRefreshIndicator extends StatefulWidget {
  // / Creates a refresh indicator. / / The [onRefresh], [child], and
  // [notificationPredicate] arguments must be / non-null. The default /
  // [displacement] is 40.0 logical pixels. / / The [semanticsLabel] is used to
  // specify an accessibility label for this widget. / If it is null, it will be
  // defaulted to [MaterialLocalizations.refreshIndicatorSemanticLabel]. / An
  // empty string may be passed to avoid having anything read by screen reading
  // software. / The [semanticsValue] may be used to specify progress on the
  // widget.
  const BottomRefreshIndicator(
      {Key key,
      @required this.child,
      this.displacement = 40.0,
      @required this.onRefresh,
      this.color,
      this.backgroundColor,
      this.notificationPredicate = defaultScrollNotificationPredicate,
      this.semanticsLabel,
      this.semanticsValue,
      this.strokeWidth = 2.0})
      : assert(child != null),
        assert(onRefresh != null),
        assert(notificationPredicate != null),
        assert(strokeWidth != null),
        super(key: key);

  // / The widget below this widget in the tree. / / The refresh indicator will be
  // stacked on top of this child. The indicator / will appear when child's
  // Scrollable descendant is over-scrolled. / / Typically a [ListView] or
  // [CustomScrollView].
  final Widget child;

  // / The distance from the child's top or bottom edge to where the refresh /
  // indicator will settle. During the drag that exposes the refresh indicator, /
  // its actual displacement may significantly exceed this value.
  final double displacement;

  // / A function that's called when the user has dragged the refresh indicator /
  // far enough to demonstrate that they want the app to refresh. The returned /
  // [Future] must complete when the refresh operation is finished.
  final RefreshCallback onRefresh;

  // / The progress indicator's foreground color. The current theme's /
  // [ThemeData.accentColor] by default.
  final Color color;

  // / The progress indicator's background color. The current theme's /
  // [ThemeData.canvasColor] by default.
  final Color backgroundColor;

  // / A check that specifies whether a [ScrollNotification] should be / handled by
  // this widget. / / By default, checks whether `notification.depth == 0`. Set it
  // to something / else for more complicated layouts.
  final ScrollNotificationPredicate notificationPredicate;

  // / {@macro flutter.material.progressIndicator.semanticsLabel} / / This will be
  // defaulted to [MaterialLocalizations.refreshIndicatorSemanticLabel] / if it is
  // null.
  final String semanticsLabel;

  /// {@macro flutter.material.progressIndicator.semanticsValue}
  final String semanticsValue;

  // / Defines `strokeWidth` for `RefreshIndicator`. / / By default, the value of
  // `strokeWidth` is 2.0 pixels.
  final double strokeWidth;

  @override
  BottomRefreshIndicatorState createState() => BottomRefreshIndicatorState();
}

// / Contains the state for a [RefreshIndicator]. This class can be used to /
// programmatically show the refresh indicator, see the [show] method.
class BottomRefreshIndicatorState extends State<BottomRefreshIndicator>
    with TickerProviderStateMixin<BottomRefreshIndicator> {
  AnimationController _positionController;
  AnimationController _scaleController;
  Animation<double> _positionFactor;
  Animation<double> _scaleFactor;
  Animation<double> _value;
  Animation<Color> _valueColor;

  _RefreshIndicatorMode _mode;
  Future<void> _pendingRefreshFuture;
  bool _isIndicatorAtBottom;
  double _dragOffset;

  static final Animatable<double> _threeQuarterTween =
      Tween<double>(begin: 0.0, end: 0.75);
  static final Animatable<double> _kDragSizeFactorLimitTween =
      Tween<double>(begin: 0.0, end: _kDragSizeFactorLimit);
  static final Animatable<double> _oneToZeroTween =
      Tween<double>(begin: 1.0, end: 0.0);

  @override
  void initState() {
    super.initState();
    _positionController = AnimationController(vsync: this);
    _positionFactor = _positionController.drive(_kDragSizeFactorLimitTween);
    _value = _positionController.drive(
        _threeQuarterTween); // The "value" of the circular progress indicator during a drag.

    _scaleController = AnimationController(vsync: this);
    _scaleFactor = _scaleController.drive(_oneToZeroTween);
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    _valueColor = _positionController.drive(
      ColorTween(
        begin: (widget.color ?? theme.accentColor).withOpacity(0.0),
        end: (widget.color ?? theme.accentColor).withOpacity(1.0),
      ).chain(
          CurveTween(curve: const Interval(0.0, 1.0 / _kDragSizeFactorLimit))),
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _positionController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (!widget.notificationPredicate(notification)) return false;
    if (notification is ScrollStartNotification &&
        notification.metrics.extentAfter == 0.0 && //edited
        _mode == null &&
        _start(notification.metrics.axisDirection)) {
      setState(() {
        _mode = _RefreshIndicatorMode.drag;
      });
      return false;
    }
    bool indicatorAtBottomNow; //edited
    switch (notification.metrics.axisDirection) {
      //edited
      case AxisDirection.down:
        indicatorAtBottomNow = false;
        break;
      case AxisDirection.up:
        indicatorAtBottomNow = true;
        break;
      case AxisDirection.left:
      case AxisDirection.right:
        indicatorAtBottomNow = null;
        break;
    }
    if (indicatorAtBottomNow != _isIndicatorAtBottom) {
      if (_mode == _RefreshIndicatorMode.drag ||
          _mode == _RefreshIndicatorMode.armed)
        _dismiss(_RefreshIndicatorMode.canceled);
    } else if (notification is ScrollUpdateNotification) {
      if (_mode == _RefreshIndicatorMode.drag ||
          _mode == _RefreshIndicatorMode.armed) {
        if (notification.metrics.extentAfter > 0.0) {
          _dismiss(_RefreshIndicatorMode.canceled);
        } else {
          _dragOffset += notification.scrollDelta;
          _checkDragOffset(notification.metrics.viewportDimension);
        }
      }
      if (_mode == _RefreshIndicatorMode.armed &&
          notification.dragDetails == null) {
        // On iOS start the refresh when the Scrollable bounces back from the overscroll
        // (ScrollNotification indicating this don't have dragDetails because the scroll
        // activity is not directly triggered by a drag).
        _show();
      }
    } else if (notification is OverscrollNotification) {
      if (_mode == _RefreshIndicatorMode.drag ||
          _mode == _RefreshIndicatorMode.armed) {
        _dragOffset += notification.overscroll / 2.0;
        _checkDragOffset(notification.metrics.viewportDimension);
      }
    } else if (notification is ScrollEndNotification) {
      switch (_mode) {
        case _RefreshIndicatorMode.armed:
          _show();
          break;
        case _RefreshIndicatorMode.drag:
          _dismiss(_RefreshIndicatorMode.canceled);
          break;
        default:
          // do nothing
          break;
      }
    }
    return false;
  }

  bool _handleGlowNotification(OverscrollIndicatorNotification notification) {
    if (notification.depth != 0 || !notification.leading) return false;
    if (_mode == _RefreshIndicatorMode.drag) {
      notification.disallowGlow();
      return true;
    }
    return false;
  }

  bool _start(AxisDirection direction) {
    assert(_mode == null);
    assert(_isIndicatorAtBottom == null);
    assert(_dragOffset == null);
    switch (direction) {
      case AxisDirection.down:
        _isIndicatorAtBottom = false;
        break;
      case AxisDirection.up:
        _isIndicatorAtBottom = true;
        break;
      case AxisDirection.left:
      case AxisDirection.right:
        _isIndicatorAtBottom = null;
        // we do not support horizontal scroll views.
        return false;
    }
    _dragOffset = 0.0;
    _scaleController.value = 0.0;
    _positionController.value = 0.0;
    return true;
  }

  void _checkDragOffset(double containerExtent) {
    assert(_mode == _RefreshIndicatorMode.drag ||
        _mode == _RefreshIndicatorMode.armed);
    double newValue =
        _dragOffset / (containerExtent * _kDragContainerExtentPercentage);
    if (_mode == _RefreshIndicatorMode.armed)
      newValue = math.max(newValue, 1.0 / _kDragSizeFactorLimit);
    _positionController.value =
        newValue.clamp(0.0, 1.0) as double; // this triggers various rebuilds
    if (_mode == _RefreshIndicatorMode.drag && _valueColor.value.alpha == 0xFF)
      _mode = _RefreshIndicatorMode.armed;
  }

  // Stop showing the refresh indicator.
  Future<void> _dismiss(_RefreshIndicatorMode newMode) async {
    await Future<void>.value();
    // This can only be called from _show() when refreshing and
    // _handleScrollNotification in response to a ScrollEndNotification or direction
    // change.
    assert(newMode == _RefreshIndicatorMode.canceled ||
        newMode == _RefreshIndicatorMode.done);
    setState(() {
      _mode = newMode;
    });
    switch (_mode) {
      case _RefreshIndicatorMode.done:
        await _scaleController.animateTo(1.0,
            duration: _kIndicatorScaleDuration);
        break;
      case _RefreshIndicatorMode.canceled:
        await _positionController.animateTo(0.0,
            duration: _kIndicatorScaleDuration);
        break;
      default:
        assert(false);
    }
    if (mounted && _mode == newMode) {
      _dragOffset = null;
      _isIndicatorAtBottom = null;
      setState(() {
        _mode = null;
      });
    }
  }

  void _show() {
    assert(_mode != _RefreshIndicatorMode.refresh);
    assert(_mode != _RefreshIndicatorMode.snap);
    final Completer<void> completer = Completer<void>();
    _pendingRefreshFuture = completer.future;
    _mode = _RefreshIndicatorMode.snap;
    _positionController
        .animateTo(1.0 / _kDragSizeFactorLimit,
            duration: _kIndicatorSnapDuration)
        .then<void>((void value) {
      if (mounted && _mode == _RefreshIndicatorMode.snap) {
        assert(widget.onRefresh != null);
        setState(() {
          // Show the indeterminate progress indicator.
          _mode = _RefreshIndicatorMode.refresh;
        });

        final Future<void> refreshResult = widget.onRefresh();
        assert(() {
          if (refreshResult == null)
            FlutterError.reportError(FlutterErrorDetails(
              exception: FlutterError('The onRefresh callback returned null.\n'
                  'The RefreshIndicator onRefresh callback must return a Future.'),
              context: ErrorDescription('when calling onRefresh'),
              library: 'material library',
            ));
          return true;
        }());
        if (refreshResult == null) return;
        refreshResult.whenComplete(() {
          if (mounted && _mode == _RefreshIndicatorMode.refresh) {
            completer.complete();
            _dismiss(_RefreshIndicatorMode.done);
          }
        });
      }
    });
  }

  // / Show the refresh indicator and run the refresh callback as if it had / been
  // started interactively. If this method is called while the refresh / callback
  // is running, it quietly does nothing. / / Creating the [RefreshIndicator] with
  // a [GlobalKey<RefreshIndicatorState>] / makes it possible to refer to the
  // [RefreshIndicatorState]. / / The future returned from this method completes
  // when the / [RefreshIndicator.onRefresh] callback's future completes. / / If
  // you await the future returned by this function from a [State], you / should
  // check that the state is still [mounted] before calling [setState]. / / When
  // initiated in this manner, the refresh indicator is independent of any /
  // actual scroll view. It defaults to showing the indicator at the top. To /
  // show it at the bottom, set `atTop` to false.
  Future<void> show({bool atTop = true}) {
    if (_mode != _RefreshIndicatorMode.refresh &&
        _mode != _RefreshIndicatorMode.snap) {
      if (_mode == null) _start(atTop ? AxisDirection.down : AxisDirection.up);
      _show();
    }
    return _pendingRefreshFuture;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final Widget child = NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: _handleGlowNotification,
        child: widget.child,
      ),
    );
    assert(() {
      if (_mode == null) {
        assert(_dragOffset == null);
        assert(_isIndicatorAtBottom == null);
      } else {
        assert(_dragOffset != null);
        assert(_isIndicatorAtBottom != null);
      }
      return true;
    }());

    final bool showIndeterminateIndicator =
        _mode == _RefreshIndicatorMode.refresh ||
            _mode == _RefreshIndicatorMode.done;

    return Stack(
      children: <Widget>[
        // child,

        AnimatedBuilder(
            animation: _positionController,
            child: child,
            builder: (BuildContext context, Widget child) {
              return Transform.translate(
                  offset: Offset(0, _value.value * -100), child: child);
            }),
        // Column(
        //   children: [
        //     Expanded(child: child),
        //     AnimatedContainer(
        //       height: showIndeterminateIndicator ? 100 : 0,
        //       duration: _kIndicatorScaleDuration,
        //     )
        //   ],
        // ),
        if (_mode != null)
          Positioned(
            top: _isIndicatorAtBottom ? 0.0 : null,
            bottom: !_isIndicatorAtBottom ? 0.0 : null,
            left: 0.0,
            right: 0.0,
            child: SizeTransition(
              axisAlignment: _isIndicatorAtBottom ? 1.0 : -1.0,
              sizeFactor: _positionFactor, // this is what brings it down
              child: Container(
                padding: _isIndicatorAtBottom
                    ? EdgeInsets.only(top: widget.displacement)
                    : EdgeInsets.only(bottom: widget.displacement),
                alignment: _isIndicatorAtBottom
                    ? Alignment.topCenter
                    : Alignment.bottomCenter,
                child: ScaleTransition(
                  scale: _scaleFactor,
                  child: AnimatedBuilder(
                    animation: _positionController,
                    builder: (BuildContext context, Widget child) {
                      return RefreshProgressIndicator(
                        semanticsLabel: widget.semanticsLabel ??
                            MaterialLocalizations.of(context)
                                .refreshIndicatorSemanticLabel,
                        semanticsValue: widget.semanticsValue,
                        value: showIndeterminateIndicator ? null : _value.value,
                        valueColor: _valueColor,
                        backgroundColor: widget.backgroundColor,
                        strokeWidth: widget.strokeWidth,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
