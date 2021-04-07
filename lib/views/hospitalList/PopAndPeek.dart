import 'package:flutter/material.dart';

class PopAndPeek extends StatefulWidget {
  final Widget child;
  final Widget popUp;
  PopAndPeek({Key key, @required this.child, @required this.popUp})
      : super(key: key);

  @override
  _PopAndPeekState createState() => _PopAndPeekState();
}

class _PopAndPeekState extends State<PopAndPeek> {
  GlobalKey _key;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _key = GlobalKey();
  }

  openPopUp() {
    RenderBox box = _key.currentContext.findRenderObject();
    Offset position = box.localToGlobal(Offset.zero);
    print("position $position");
    showDialog(
      context: context,
      builder: (cx) => GestureDetector(
        onTap: () {
          // print('press');/
          Navigator.pop(cx);
        },
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(0),
          child: Container(
            height: MediaQuery.of(cx).size.height,
            // width: MediaQuery.of(cx).size.width,
            child: Transform(
              transform: Matrix4.identity()
                ..translate(position.dx + 5, position.dy - 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: FractionallySizedBox(
                  // height: 200,
                  // width: 150,
                  heightFactor: 0.5,
                  widthFactor: 0.7,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 5, color: Colors.white)),
                      clipBehavior: Clip.hardEdge,
                      // child: AbsorbPointer(
                      child: widget.popUp),
                  // ),
                ),
              ),
            ),
          ),
        ),
      ),
      // child: Transform(
      //     transform: Matrix4.identity()
      //       ..translate(position.dx, position.dy - 10),
      //     child: Container(
      //       child: SizedBox(
      //         height: 200,
      //         width: 100,
      //         child: Container(
      //           height: 200,
      //           width: 100,
      //           decoration: BoxDecoration(
      //               color: Colors.white,
      //               borderRadius: BorderRadius.circular(5),
      //               border: Border.all(width: 5, color: Colors.white)),
      //           child: AbsorbPointer(
      //               child: Container(
      //             color: Colors.red,
      //             height: 200,
      //             width: 100,
      //           )),
      //         ),
      //       ),
      //     ))
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      onLongPress: openPopUp,
      child: widget.child,
    );
  }
}
