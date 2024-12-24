import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget get padXXDefault =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: this);
  Widget padXX(double xx) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: xx), child: this);
  Widget padYY(double yy) =>
      Padding(padding: EdgeInsets.symmetric(vertical: yy), child: this);

  Widget padYBottom(double y) =>
      Padding(padding: EdgeInsets.only(bottom: y), child: this);

  Widget padYTop(double y) =>
      Padding(padding: EdgeInsets.only(top: y), child: this);

  Widget padXLeft(double x) =>
      Padding(padding: EdgeInsets.only(left: x), child: this);

  Widget padXRight(double x) =>
      Padding(padding: EdgeInsets.only(right: x), child: this);

  Widget padAll(double all) =>
      Padding(padding: EdgeInsets.all(all), child: this);

  Widget get expand => Expanded(child: this);
}
