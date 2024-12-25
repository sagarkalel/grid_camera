import 'package:flutter/cupertino.dart';

/// A custom widget that creates a flexible gap (empty space)
/// of specified height and width.
///
/// This widget is useful for adding consistent spacing
/// between widgets in your UI layout.
class Gap extends StatelessWidget {
  /// Creates a [Gap] widget with the specified size [val].
  ///
  /// [val]: The size of the gap, applied to both height and width.
  const Gap(this.val, {super.key});

  /// The size of the gap (height and width).
  final double val;

  @override
  Widget build(BuildContext context) {
    // Builds a SizedBox with the given height and width.
    return SizedBox(height: val, width: val);
  }
}
