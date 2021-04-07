import 'package:flutter/widgets.dart';
import 'package:hospitals/views/AnimatedImageList/interpolate.dart';
import 'package:hospitals/views/test/interpolate.dart';

typedef TransformFuntion<I, E> = E Function(I input);
typedef Build<I> = Widget Function(BuildContext context, I value);
const transformMessage =
    "Animation value is not of type double use transformFuntion to extract value";

class InterpolationTransition<T> extends AnimatedWidget {
  const InterpolationTransition(
      {Key key,
      @required Animation<T> animation,
      @required this.buildChild,
      @required this.interpolateConfig,
      this.transformFuntion})
      : assert(transformFuntion != null || (animation is Animation<double>),
            transformMessage),
        super(key: key, listenable: animation);

  Animation<T> get animation => listenable;
  final TransformFuntion<T, double> transformFuntion;
  final Build<double> buildChild;
  final InterpolateConfig interpolateConfig;
  @override
  Widget build(BuildContext context) {
    if (transformFuntion == null && !(animation.value is double)) {
      throw (transformMessage);
    }

    var currentValue = transformFuntion != null
        ? transformFuntion(
            animation.value,
          )
        : animation.value;

    return buildChild(context, interpolate(currentValue, interpolateConfig));
  }
}
