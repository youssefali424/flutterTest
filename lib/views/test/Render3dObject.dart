library flutter_3d_obj;

import 'dart:developer';
import 'dart:io';
import 'dart:math' as Math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:gesture_x_detector/gesture_x_detector.dart';
// import 'package:meta/meta.dart';
import 'package:vector_math/vector_math.dart' show Vector3;
import 'package:vector_math/vector_math.dart' as V;

class Render3dObject extends StatefulWidget {
  Render3dObject(
    this.path, {
    this.asset = false,
    this.size = const Size(100, 100),
    this.angleX = 15.0,
    this.angleY = 45.0,
    this.angleZ = 0.0,
    this.zoom = 100.0,
  });

  final Size size;
  final bool asset;
  final String path;
  final double zoom;
  final double angleX;
  final double angleY;
  final double angleZ;

  @override
  _Object3DState createState() => new _Object3DState();
}

class _Object3DState extends State<Render3dObject> {
  _Object3DState();

  void initState() {
    if (widget.asset == true) {
      rootBundle.loadString(widget.path).then((String value) async {
        var temp = parseFile(value);
        setState(() {
          object = temp;
        });
      });
    } else {
      File file = new File(widget.path);
      file.readAsString().then((String value) {
        var temp = parseFile(value);
        setState(() {
          object = temp;
        });
      });
    }
    equalOnNotNull(angleX, widget.angleX);
    equalOnNotNull(angleY, widget.angleY);
    equalOnNotNull(angleZ, widget.angleZ);
    equalOnNotNull(_scaleFactor, widget.zoom / 100);

    super.initState();
  }

  final regx = RegExp('\\s+');

  Map _parseObjString(String objString) {
    List vertices = <Vector3>[];
    List faces = <List<int>>[];
    List<int> face = [];

    List lines = objString.split("\n");

    Vector3 vertex;

    lines.forEach((dynamic line) {
      String lline = line;
      lline = lline.replaceAll(new RegExp(r"\s+$"), "");
      List<String> chars = lline.split(regx);

      // vertex
      if (chars[0] == "v") {
        vertex = new Vector3(double.parse(chars[1]), double.parse(chars[2]),
            double.parse(chars[3]));

        vertices.add(vertex);

        // face
      } else if (chars[0] == "f") {
        for (var i = 1; i < chars.length; i++) {
          face.add(int.parse(chars[i].split("/")[0]));
        }

        faces.add(face);
        face = [];
      }
    });

    return {'vertices': vertices, 'faces': faces};
  }

  List<Vector3> vertices = [];
  List<dynamic> faces = [];
  parseFile(object) {
    return _parseObjString(object);
  }

  equalOnNotNull<T extends dynamic>(T curr, T obj) {
    if (obj != null) {
      curr = obj;
    }
  }

  double angleX = 15.0;
  double angleY = 45.0;
  double angleZ = 0.0;

  double _previousX = 0.0;
  double _previousY = 0.0;

  // double zoom = 100;
  Map object = {};

  File file;

  void _updateCube(MoveEvent data) {
    if (angleY > 360.0) {
      angleY = angleY - 360.0;
    }
    if (_previousY > data.position.dx) {
      setState(() {
        angleY = angleY - 1;
      });
    }
    if (_previousY < data.position.dx) {
      setState(() {
        angleY = angleY + 1;
      });
    }
    _previousY = data.position.dx;

    if (angleX > 360.0) {
      angleX = angleX - 360.0;
    }
    if (_previousX > data.position.dy) {
      setState(() {
        angleX = angleX - 1;
      });
    }
    if (_previousX < data.position.dy) {
      setState(() {
        angleX = angleX + 1;
      });
    }
    _previousX = data.position.dy;
  }

  void _update(MoveEvent data) {
    _updateCube(data);
  }

  // void _updateX(MoveEvent data) {
  //   _updateCube(data);
  // }

  double _scaleFactor = 1;
  Offset currentCenter;

  void _scaleUpdate(ScaleEvent details) {
    if (_scaleFactor <= 1 || _scaleFactor >= 2) {
      return;
    }
    setState(() {
      _scaleFactor = _scaleFactor * details.scale;
    });
  }

  void _scaleStart(Offset data) {
    currentCenter = data;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.size);
    return XGestureDetector(
        child: CustomPaint(
          painter: _ObjectPainter(widget.size, object, angleX, angleY, angleZ,
              lerpDouble(0, 100, _scaleFactor) ?? 100.0,
              viewPortX: currentCenter?.dx, viewPortY: currentCenter?.dy),
          size: widget.size,
        ),
        onMoveUpdate: _update,
        // onVerticalDragUpdate: _updateX,
        onScaleStart: _scaleStart,
        onScaleUpdate: _scaleUpdate);
  }
}

class _ObjectPainter extends CustomPainter {
  double _zoomFactor = 100.0;

//  final double _rotation = 5.0; // in degrees
  // double _translation = 0.1 / 100;
//  final double _scalingFactor = 10.0 / 100.0; // in percent

  final double zero = 0.0;

  // final String object;

  double viewPortX = 0.0, viewPortY = 0.0;

  List<Vector3> vertices = [];
  List<dynamic> faces = [];
  V.Matrix4 T = V.Matrix4.identity();
  Vector3 camera = Vector3.all(0);
  Vector3 light = Vector3.all(0);

  double angleX;
  double angleY;
  double angleZ;

  Color color = Color.fromARGB(255, 255, 255, 255);

  Size size;
  final Map parsedFile;
  // List<Vector3> verticesDraw = [];
  // bool fileChanged = true;
  _ObjectPainter(this.size, this.parsedFile, this.angleX, this.angleY,
      this.angleZ, this._zoomFactor,
      {this.viewPortX, this.viewPortY}) {
    // _translation *= _zoomFactor;
    camera = new Vector3(0.0, 0.0, 0.0);
    light = new Vector3(0.0, 0.0, 100.0);
    color = new Color.fromARGB(255, 255, 255, 255);
    viewPortX ??= (size.width / 2).toDouble();
    viewPortY ??= (size.height / 2).toDouble();
  }

  bool _shouldDrawFace(List face) {
    var normalVector = _normalVector3(
        vertices[face[0] - 1], vertices[face[1] - 1], vertices[face[2] - 1]);

    var dotProduct = normalVector.dot(camera);
    double vectorLengths = normalVector.length * camera.length;

    double angleBetween = dotProduct / vectorLengths;

    return angleBetween < 0;
  }

  Vector3 _normalVector3(Vector3 first, Vector3 second, Vector3 third) {
    Vector3 secondFirst = new Vector3.copy(second);
    secondFirst.sub(first);
    Vector3 secondThird = new Vector3.copy(second);
    secondThird.sub(third);

    return new Vector3(
        (secondFirst.y * secondThird.z) - (secondFirst.z * secondThird.y),
        (secondFirst.z * secondThird.x) - (secondFirst.x * secondThird.z),
        (secondFirst.x * secondThird.y) - (secondFirst.y * secondThird.x));
  }

  double _scalarMultiplication(Vector3 first, Vector3 second) {
    return (first.x * second.x) + (first.y * second.y) + (first.z * second.z);
  }

  Vector3 _calcDefaultVertex(Vector3 vertex) {
    T = new V.Matrix4.translationValues(viewPortX, viewPortY, zero);
    T.scale(_zoomFactor, -_zoomFactor);

    T.rotateX(_degreeToRadian(angleX != null ? angleX : 0.0));
    T.rotateY(_degreeToRadian(angleY != null ? angleY : 0.0));
    T.rotateZ(_degreeToRadian(angleZ != null ? angleZ : 0.0));

    return T.transform3(vertex);
  }

  double _degreeToRadian(double degree) {
    return degree * (Math.pi / 180.0);
  }

  List<dynamic> _drawFace(List<Vector3> verticesToDraw, List face) {
    List<dynamic> list = <dynamic>[];
    Paint paint = new Paint();
    Vector3 normalizedLight = new Vector3.copy(light).normalized();

    var normalVector = _normalVector3(verticesToDraw[face[0] - 1],
        verticesToDraw[face[1] - 1], verticesToDraw[face[2] - 1]);

    Vector3 jnv = new Vector3.copy(normalVector).normalized();

    double koef = _scalarMultiplication(jnv, normalizedLight);

    if (koef < 0.0) {
      koef = 0.0;
    }

    Color newColor = new Color.fromARGB(255, 0, 0, 0);

    Path path = new Path();

    newColor = newColor.withRed((color.red.toDouble() * koef).round());
    newColor = newColor.withGreen((color.green.toDouble() * koef).round());
    newColor = newColor.withBlue((color.blue.toDouble() * koef).round());
    paint.color = newColor;
    paint.style = PaintingStyle.fill;

    bool lastPoint = false;
    double firstVertexX, firstVertexY, secondVertexX, secondVertexY;

    for (int i = 0; i < face.length; i++) {
      if (i + 1 == face.length) {
        lastPoint = true;
      }

      if (lastPoint) {
        firstVertexX = verticesToDraw[face[i] - 1][0].toDouble();
        firstVertexY = verticesToDraw[face[i] - 1][1].toDouble();
        secondVertexX = verticesToDraw[face[0] - 1][0].toDouble();
        secondVertexY = verticesToDraw[face[0] - 1][1].toDouble();
      } else {
        firstVertexX = verticesToDraw[face[i] - 1][0].toDouble();
        firstVertexY = verticesToDraw[face[i] - 1][1].toDouble();
        secondVertexX = verticesToDraw[face[i + 1] - 1][0].toDouble();
        secondVertexY = verticesToDraw[face[i + 1] - 1][1].toDouble();
      }

      if (i == 0) {
        path.moveTo(firstVertexX, firstVertexY);
      }

      path.lineTo(secondVertexX, secondVertexY);
    }
    // var z = 0.0;
    // face.forEach((dynamic x) {
    //   int xx = x;
    // z += verticesToDraw[xx - 1].z;
    // });

    path.close();
    list.add(path);
    list.add(paint);
    return list;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Map parsedFile = _parseObjString(object);
    if (parsedFile == null || parsedFile.length < 1) {
      return;
    }
    vertices = parsedFile["vertices"];
    faces = parsedFile["faces"];

    List<Vector3> verticesToDraw = [];
    // print(fileChanged);
    // if (fileChanged) {
      verticesToDraw = [];
      vertices.forEach((vertex) {
        verticesToDraw.add(new Vector3.copy(vertex));
      });
    // }
    for (int i = 0; i < verticesToDraw.length; i++) {
      verticesToDraw[i] = _calcDefaultVertex(verticesToDraw[i]);
    }

    final List<Map> avgOfZ = [];
    for (int i = 0; i < faces.length; i++) {
      List face = faces[i];
      double z = 0.0;
      face.forEach((dynamic x) {
        int xx = x;
        z += verticesToDraw[xx - 1].z;
      });
      Map data = <String, dynamic>{
        "index": i,
        "z": z,
      };
      avgOfZ.add(data);
    }
    avgOfZ.sort((Map a, Map b) => a['z'].compareTo(b['z']));

    // verticesDraw = verticesToDraw;

    for (int i = 0; i < faces.length; i++) {
      List face = faces[avgOfZ[i]["index"]];
      if (_shouldDrawFace(face) || true) {
        final List<dynamic> faceProp = _drawFace(verticesToDraw, face);
        canvas.drawPath(faceProp[0], faceProp[1]);
      }
    }
  }

  @override
  bool shouldRepaint(_ObjectPainter old) =>(old.parsedFile != parsedFile ||
        old.angleX != angleX ||
        old.angleY != angleY ||
        old.angleZ != angleZ ||
        old._zoomFactor != _zoomFactor);
  // {
    // print(old.parsedFile != parsedFile ||
    //     old.angleX != angleX ||
    //     old.angleY != angleY ||
    //     old.angleZ != angleZ ||
    //     old._zoomFactor != _zoomFactor);
  //   if (old.parsedFile != parsedFile ||
  //       old.angleX != angleX ||
  //       old.angleY != angleY ||
  //       old.angleZ != angleZ ||
  //       old._zoomFactor != _zoomFactor) {
  //     if (old.parsedFile != parsedFile) {
  //       fileChanged = true;
  //     } else {
  //       fileChanged = false;
  //     }
  //     return true;
  //   } else {
  //     fileChanged = false;
  //   }
  //   return false;
  // }
}
