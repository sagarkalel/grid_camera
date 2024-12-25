import 'package:flutter/material.dart';

/// This extension on the Widget class provides utility methods
/// to simplify the addition of padding and expansion functionality
/// to widgets in a concise and readable manner.
extension WidgetExtensions on Widget {
  /// Adds default horizontal padding of 16 pixels to the widget.
  Widget get padXXDefault =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: this);

  /// Adds horizontal padding with a custom value [xx] to the widget.
  ///
  /// [xx]: The amount of horizontal padding to apply.
  Widget padXX(double xx) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: xx), child: this);

  /// Adds vertical padding with a custom value [yy] to the widget.
  ///
  /// [yy]: The amount of vertical padding to apply.
  Widget padYY(double yy) =>
      Padding(padding: EdgeInsets.symmetric(vertical: yy), child: this);

  /// Adds padding only to the bottom of the widget.
  ///
  /// [y]: The amount of padding to apply at the bottom.
  Widget padYBottom(double y) =>
      Padding(padding: EdgeInsets.only(bottom: y), child: this);

  /// Adds padding only to the top of the widget.
  ///
  /// [y]: The amount of padding to apply at the top.
  Widget padYTop(double y) =>
      Padding(padding: EdgeInsets.only(top: y), child: this);

  /// Adds padding only to the left side of the widget.
  ///
  /// [x]: The amount of padding to apply on the left side.
  Widget padXLeft(double x) =>
      Padding(padding: EdgeInsets.only(left: x), child: this);

  /// Adds padding only to the right side of the widget.
  ///
  /// [x]: The amount of padding to apply on the right side.
  Widget padXRight(double x) =>
      Padding(padding: EdgeInsets.only(right: x), child: this);

  /// Adds uniform padding to all sides of the widget.
  ///
  /// [all]: The amount of padding to apply on all sides.
  Widget padAll(double all) =>
      Padding(padding: EdgeInsets.all(all), child: this);

  /// Wraps the widget in an [Expanded] widget.
  ///
  /// This is useful in layouts like [Row], [Column], or [Flex]
  /// where the widget needs to take up the remaining available space.
  Widget get expand => Expanded(child: this);
}
