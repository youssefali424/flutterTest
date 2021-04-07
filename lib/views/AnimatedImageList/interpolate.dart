double interpolateInternalSingleProc(
    double value, double inS, double inE, double outS, double outE) {
  double progress = (value - inS) / (inE - inS);
  double resultForNonZeroRange = (outS + (progress * (outE - outS)));
  double result;

  if (inS == inE) {
    if (value <= inS) {
      result = outS;
    } else {
      result = outE;
    }
  } else {
    result = resultForNonZeroRange;
  }
  return result;
}

double interpolateInternalSingle(double value, List<double> inputRange,
    List<double> outputRange, int offset) {
  double inS = inputRange[offset];
  double inE = inputRange[offset + 1];
  double outS = outputRange[offset];
  double outE = outputRange[offset + 1];
  return interpolateInternalSingleProc(value, inS, inE, outS, outE);
}

double interpolateInternal(
    double value, List<double> inputRange, List<double> outputRange,
    {int offset = 0}) {
  if (inputRange.length - offset == 2) {
    return interpolateInternalSingle(value, inputRange, outputRange, offset);
  }
  return value < inputRange[offset + 1]
      ? interpolateInternalSingle(value, inputRange, outputRange, offset)
      : interpolateInternal(value, inputRange, outputRange, offset: offset + 1);
}

void invariant(bool cond, List<String> str) {
  if (!cond) {
    throw (str.join(" "));
  }
}

void checkNonDecreasing(String name, List<double> arr) {
  for (int i = 1; i < arr.length; ++i) {
    invariant(arr[i] >= arr[i - 1], [
      '%s must be monotonically non-decreasing. (%s)',
      name,
      arr.toString()
    ]);
  }
}

void checkMinElements(String name, List<double> arr) {
  invariant(arr.length >= 2,
      ['%s must have at least 2 elements. (%s)', name, arr.toString()]);
}

enum Extrapolate { EXTEND, CLAMP, IDENTITY }

class InterpolateConfig {
  List<double> inputRange;
  List<double> outputRange;
  Extrapolate extrapolate;
  Extrapolate extrapolateLeft;
  Extrapolate extrapolateRight;
  InterpolateConfig(this.inputRange, this.outputRange,
      {this.extrapolate = Extrapolate.EXTEND,
      this.extrapolateLeft,
      this.extrapolateRight}) {
    checkMinElements('inputRange', inputRange);
    checkMinElements('outputRange', outputRange);
    checkNonDecreasing('inputRange', inputRange);
    invariant(inputRange.length == outputRange.length,
        ['inputRange and outputRange must be the same length.']);
  }
}

double interpolate(double value, InterpolateConfig config) {
  var inputRange = config.inputRange;
  var outputRange = config.outputRange;
  var extrapolate = config.extrapolate;
  var extrapolateLeft = config.extrapolateLeft;
  var extrapolateRight = config.extrapolateRight;
  // checkMinElements('inputRange', inputRange);
  // checkMinElements('outputRange', outputRange);
  // checkNonDecreasing('inputRange', inputRange);
  // invariant(inputRange.length == outputRange.length,
  //     ['inputRange and outputRange must be the same length.']);

  var left = extrapolateLeft ?? extrapolate;
  var right = extrapolateRight ?? extrapolate;
  var output = interpolateInternal(value, inputRange, outputRange);

  if (left == Extrapolate.EXTEND) {
  } else if (left == Extrapolate.CLAMP) {
    if (value < inputRange[0]) {
      output = outputRange[0];
    }
  } else if (left == Extrapolate.IDENTITY) {
    if (value < inputRange[0]) {
      output = value;
    }
  }

  if (right == Extrapolate.EXTEND) {
  } else if (right == Extrapolate.CLAMP) {
    if (value > inputRange[inputRange.length - 1]) {
      output = outputRange[outputRange.length - 1];
    }
  } else if (right == Extrapolate.IDENTITY) {
    if (value > inputRange[inputRange.length - 1]) {
      output = value;
    }
  }

  return output;
}
// cl
