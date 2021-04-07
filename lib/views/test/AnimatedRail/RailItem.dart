import 'package:flutter/cupertino.dart';

class RailItem {
  Widget icon;
  String label;
  Color background;
  Color activeColor;
  Color iconColor;
  Widget screen;
  RailItem({
    @required this.icon,
    @required this.screen,
    this.label,
    this.background,
    this.activeColor,
    this.iconColor,
  });
}
